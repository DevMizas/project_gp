import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_gpt/infra/infra.dart';
import 'package:project_gpt/models/models.dart';

import '../../presentation.dart';

class ChatBlocViewModel extends Bloc<ChatEventViewModel, ChatStateViewModel> {
  final ChatRepo repo;
  final List<MessageModel> _messages = [];

  ChatBlocViewModel(this.repo) : super(ChatInitial()) {
    on<SendMessageEvent>((event, emit) async {
  emit(ChatLoading(List.from(_messages)));
  _messages.add(MessageModel(role: 'user', content: event.message));
  emit(ChatLoaded(List.from(_messages)));

  try {
    final response = await repo.sendMessage(event.message);
    final fullText = response.content;

    String partialText = '';
    for (int i = 0; i < fullText.length; i++) {
      partialText += fullText[i];
      emit(ChatTyping(List.from(_messages), partialText));
      await Future.delayed(Duration(milliseconds: 30));
    }

    _messages.add(response);
    emit(ChatLoaded(List.from(_messages)));

  } catch (e) {
    emit(ChatError(e.toString()));
  }
});

  }
}

