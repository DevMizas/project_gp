import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_gpt/constants/colors_theme.dart';
import 'package:project_gpt/presentation/presentation.dart';

class TextFieldAndButton extends StatefulWidget {
  const TextFieldAndButton({super.key});

  @override
  State<TextFieldAndButton> createState() => _TextFieldAndButtonState();
}

class _TextFieldAndButtonState extends State<TextFieldAndButton> {
  final _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      context.read<ChatBlocViewModel>().add(SendMessageEvent(text));
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeBlockViewModel>().state;
    return Padding(
            padding: const EdgeInsets.only(left: 12, right: 12,
            bottom: 30,),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _sendMessage(),
                    style: TextStyle(color: isDark ? ColorsScheme.white54 : ColorsScheme.black),
                    decoration: InputDecoration(
                      hintText: 'Digite sua pergunta...',
                      hintStyle: TextStyle(
                        color: isDark ? ColorsScheme.white54 : ColorsScheme.black,
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: isDark ? ColorsScheme.black45 : ColorsScheme.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                  color: ColorsScheme.black87,
                ),
              ],
            ),
          );
  }
}