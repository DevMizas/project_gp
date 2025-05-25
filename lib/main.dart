import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project_gpt/infra/services/services.dart';
import 'package:project_gpt/presentation/presentation.dart';

import 'infra/repository/repository.dart';

Future<void> main() async {
  await dotenv.load();
  final geminiApiKey = dotenv.env['GEMINI_API_KEY']!;
  final geminiService = GeminiService(geminiApiKey);
  final response = ChatRepo(geminiService);

  runApp(MyApp(response));
}

class MyApp extends StatelessWidget {
  final ChatRepo response;

  const MyApp(this.response, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => ChatBlocViewModel(response),
        child: ChatScreenViewModel(),
      ),
    );
  }
}
