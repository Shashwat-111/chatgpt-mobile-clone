import 'package:chatgpt_clone/src/models/chat.dart';
import 'package:chatgpt_clone/src/core/theme/theme.dart';
import 'package:chatgpt_clone/src/ui/screens/home_screen.dart';
import 'package:chatgpt_clone/src/ui/widgets/drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  //to view a past chat, currently just calling MyApp again with existing chat,
  //fetched from backend.
  //later to be refactored with a state management solution.
  final Chat? existingChat;
  const MyApp({super.key, this.existingChat});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: AppColors.chatGptDarkTheme,
      themeMode: ThemeMode.dark,
      home: Scaffold(
        drawer: const MyDrawer(),
        drawerScrimColor: Colors.white30,
        drawerEdgeDragWidth: 400,
        body: Homepage(existingChat: widget.existingChat,),
      ),
    );
  }
}