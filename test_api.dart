import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  try {
    final response = await dio.post(
      'https://generativelanguage.googleapis.com/v1beta/openai/chat/completions',
      data: {'model': 'gemini-1.5-flash', 'messages': [{'role': 'user', 'content': 'Hi'}]},
      options: Options(
        headers: {'Authorization': 'Bearer DUMMY_KEY'},
      ),
    );
    print('Success: \${response.data}');
  } on DioException catch (e) {
    print('Dio Error: \${e.response?.statusCode} \${e.response?.statusMessage}');
    print('Response Data: \${e.response?.data}');
  } catch (e) {
    print('Error: \$e');
  }
}
