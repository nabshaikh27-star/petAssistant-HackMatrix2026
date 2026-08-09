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
    final model = 'gemini-2.5-flash';

    if (apiKey == null || apiKey.isEmpty) {
      yield '[ERROR] No API key set. Please add your Gemini API key in Settings.';
      return;
    }

    // Convert messages to native Gemini format
    final geminiContents = messages.map((msg) {
      final role = msg['role'] == 'assistant' ? 'model' : 'user';
      return {
        'role': role,
        'parts': [{'text': msg['content']}]
      };
    }).toList();

    if (imagePath != null) {
      final imageBytes = await File(imagePath).readAsBytes();
      final base64Image = base64Encode(imageBytes);
      final lastContent = geminiContents.last;
      final parts = List<Map<String, dynamic>>.from(lastContent['parts'] as Iterable);
      parts.add({
        'inline_data': {
          'mime_type': 'image/png',
          'data': base64Image
        }
      });
      lastContent['parts'] = parts;
    }

    final dio = Dio();
    try {
      final response = await dio.post(
        'https://generativelanguage.googleapis.com/v1beta/models/$model:streamGenerateContent?alt=sse&key=$apiKey',
        data: {
          'contents': geminiContents,
        },
        options: Options(
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
            final candidates = json['candidates'] as List?;
            if (candidates == null || candidates.isEmpty) continue;
            final contentMap = (candidates[0] as Map)['content'] as Map?;
            final parts = contentMap?['parts'] as List?;
            if (parts != null && parts.isNotEmpty) {
              final text = (parts[0] as Map)['text'] as String?;
              if (text != null && text.isNotEmpty) {
                yield text;
              }
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
