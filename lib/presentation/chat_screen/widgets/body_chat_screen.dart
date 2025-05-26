import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_gpt/constants/colors_theme.dart';
import 'package:project_gpt/models/models.dart';
import 'package:project_gpt/presentation/presentation.dart';

class BodyChatScreen extends StatelessWidget {
  BodyChatScreen({super.key});

  final _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeBlockViewModel>().state;
    return ColoredBox(
      color: isDark ? ColorsScheme.black54 : ColorsScheme.white,
      child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatBlocViewModel, ChatStateViewModel>(
                listener: (context, state) {
                  if (state is ChatLoaded || state is ChatTyping || state is ChatLoading) {
                    _scrollToBottom();
                  }
                },
                builder: (context, state) {
                  List<MessageModel> messages = [];
                  String typingText = '';
      
                  if (state is ChatLoaded) {
                    messages = state.messages;
                  } else if (state is ChatTyping) {
                    messages = state.messages;
                    typingText = state.partialResponse;
                  } else if (state is ChatLoading) {
                    messages = state.messages;
                  }
      
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length + (typingText.isNotEmpty ? 1 : 0),
                    itemBuilder: (_, index) {
                      if (index == messages.length && typingText.isNotEmpty) {
                        return BuildMessageCard(text: typingText, isUser: false);
                      }
      
                      final msg = messages[index];
                      return BuildMessageCard(text: msg.content, isUser: msg.role == 'user');
                    },
                  );
                },
              ),
            ),
            TextFieldAndButton(),
          ],
        ),
    );
  }
}