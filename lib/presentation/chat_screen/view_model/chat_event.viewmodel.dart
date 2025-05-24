import 'package:equatable/equatable.dart';

abstract class ChatEventViewModel extends Equatable {
  @override
  List<Object> get props => [];
}

class SendMessageEvent extends ChatEventViewModel {
  final String message;

  SendMessageEvent(this.message);

  @override
  List<Object> get props => [message];
}
