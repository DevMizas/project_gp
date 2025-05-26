import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_gpt/constants/colors_theme.dart';
import 'package:project_gpt/presentation/presentation.dart';

class ChatScreenViewModel extends StatefulWidget {
  const ChatScreenViewModel({super.key});

  @override
  State<ChatScreenViewModel> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreenViewModel> {

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeBlockViewModel>().state;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat Quase Gemini',
          style: TextStyle(color: isDark ? ColorsScheme.white54 : ColorsScheme.black,),
        ),
         actions: [
          IconButton(
            onPressed: () {
              context.read<ThemeBlockViewModel>().toggleTheme();
            }, 
            icon: Icon(isDark ? Icons.sunny : Icons.dark_mode, color: isDark ? ColorsScheme.white : ColorsScheme.black,),
          ),
         ],
        backgroundColor: isDark ? ColorsScheme.black87 : ColorsScheme.white,
      ),
      body: BodyChatScreen(),
    );
  }
}
