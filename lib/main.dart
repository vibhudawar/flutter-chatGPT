import 'package:chat_gpt_clone/providers/chat_provider.dart';
import 'package:chat_gpt_clone/providers/models_provider.dart';
import 'package:chat_gpt_clone/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(color: cardColor),
          useMaterial3: true,
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const ChatScreen(),
      ),
    );
  }
}
