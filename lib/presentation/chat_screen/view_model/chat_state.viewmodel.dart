import 'package:equatable/equatable.dart';
import 'package:project_gpt/models/models.dart';

abstract class ChatStateViewModel extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatStateViewModel {}

class ChatLoading extends ChatStateViewModel {
  final List<MessageModel> messages;

  ChatLoading(this.messages);

  @override
  List<Object> get props => [messages];
}


class ChatLoaded extends ChatStateViewModel {
  final List<MessageModel> messages;

  ChatLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}

class ChatError extends ChatStateViewModel {
  final String error;

  ChatError(this.error);

  @override
  List<Object> get props => [error];
}

class ChatTyping extends ChatStateViewModel {
  final List<MessageModel> messages;
  final String partialResponse;

  ChatTyping(this.messages, this.partialResponse);

  @override
  List<Object> get props => [messages, partialResponse];
}


