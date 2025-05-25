import 'package:project_gpt/infra/services/services.dart';
import 'package:project_gpt/models/models.dart';

class ChatRepo {
  final GeminiService geminiService;

  ChatRepo(this.geminiService);

  Future<MessageModel> sendMessage(String message) {
    return geminiService.sendMessage(message);
  }
}
