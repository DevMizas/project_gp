import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_gpt/models/models.dart';
import 'package:project_gpt/presentation/presentation.dart';

class ChatScreenViewModel extends StatefulWidget {
  const ChatScreenViewModel({super.key});

  @override
  State<ChatScreenViewModel> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreenViewModel> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      context.read<ChatBlocViewModel>().add(SendMessageEvent(text));
      _controller.clear();
    }
  }

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

  Widget _buildMessageCard(String text, {required bool isUser}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[100] : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Quase GPT')),
      body: Column(
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
                      // mensagem parcial de digitação
                      return _buildMessageCard(typingText, isUser: false);
                    }

                    final msg = messages[index];
                    return _buildMessageCard(msg.content, isUser: msg.role == 'user');
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: 'Digite sua pergunta...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
