import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_gpt/models/models.dart';

class GptService {
  final String apiKey;

  GptService(this.apiKey);

  Future<MessageModel> sendMessage(String content) async {
    final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": content}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final text = data['candidates'][0]['content']['parts'][0]['text'];
      return MessageModel(role: 'assistant', content: text);
    } else {
      throw Exception('Erro: ${response.body}');
    }
  }
}
