import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'key_storage.dart';

class AiApiService {
  /// Sends a chat request and streams back delta text chunks.
  ///
  /// [messages] is the full conversation history in OpenAI format.
  /// [imagePath] is an optional path to a PNG file for vision requests.
  ///
  /// Yields String deltas as they stream in.
  static Stream<String> streamChat({
    required List<Map<String, dynamic>> messages,
    String? imagePath,
  }) async* {
    // Read credentials from secure storage — never log these
    final apiKey = await SecureKeyStorage.getApiKey();
    final baseUrl = await SecureKeyStorage.getBaseUrl();
    final model = await SecureKeyStorage.getModel();

    if (apiKey == null || apiKey.isEmpty) {
      yield '[ERROR] No API key set. Please add your Gemini API key in Settings.';
      return;
    }

    // If an image is attached, convert the last user message to vision format
    final requestMessages = List<Map<String, dynamic>>.from(messages);
    if (imagePath != null) {
      final imageBytes = await File(imagePath).readAsBytes();
      final base64Image = base64Encode(imageBytes);
      final lastMsg = requestMessages.last;
      requestMessages[requestMessages.length - 1] = {
        'role': lastMsg['role'],
        'content': [
          {'type': 'text', 'text': lastMsg['content']},
          {
            'type': 'image_url',
            'image_url': {'url': 'data:image/png;base64,$base64Image'},
          },
        ],
      };
    }

    final dio = Dio();
    try {
      final response = await dio.post(
        '$baseUrl/chat/completions',
        data: {
          'model': model,
          'messages': requestMessages,
          'stream': true,
        },
        options: Options(
          // API key sent directly in header — never logged, never echoed
          headers: {'Authorization': 'Bearer $apiKey'},
          responseType: ResponseType.stream,
          receiveTimeout: const Duration(seconds: 60),
        ),
      );

      final stream = (response.data as ResponseBody).stream;
      String buffer = '';

      await for (final chunk in stream) {
        buffer += utf8.decode(chunk, allowMalformed: true);
        final lines = buffer.split('\n');
        // Keep the last (potentially incomplete) line in buffer
        buffer = lines.removeLast();

        for (final line in lines) {
          final trimmed = line.trim();
          if (!trimmed.startsWith('data: ')) continue;
          final payload = trimmed.substring(6);
          if (payload == '[DONE]') return;

          try {
            final json = jsonDecode(payload) as Map<String, dynamic>;
            final choices = json['choices'] as List?;
            if (choices == null || choices.isEmpty) continue;
            final delta = (choices[0] as Map)['delta'] as Map?;
            final content = delta?['content'] as String?;
            if (content != null && content.isNotEmpty) {
              yield content;
            }
          } catch (_) {
            // Skip malformed SSE lines — never log the raw content
          }
        }
      }
    } on DioException catch (e) {
      // Return a user-friendly error — never expose raw response bodies
      final statusCode = e.response?.statusCode;
      if (statusCode == 401 || statusCode == 403) {
        yield '[ERROR] Invalid API key. Please check your key in Settings.';
      } else if (statusCode == 429) {
        yield '[ERROR] Rate limit reached. Please wait a moment and try again.';
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        yield '[ERROR] Request timed out. Please check your connection.';
      } else {
        yield '[ERROR] Could not reach AI service. Please try again.';
      }
    } catch (_) {
      yield '[ERROR] Something went wrong. Please try again.';
    }
  }
}
