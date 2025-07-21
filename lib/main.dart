import 'package:chatgpt_clone/src/core/assets/svg_assets.dart';
import 'package:chatgpt_clone/src/core/storage/local_storage.dart';
import 'package:chatgpt_clone/src/models/message.dart';
import 'package:chatgpt_clone/src/ui/screens/chat_screen.dart';
import 'package:chatgpt_clone/src/core/theme/theme.dart';
import 'package:chatgpt_clone/src/ui/widgets/drawer.dart';
import 'package:chatgpt_clone/src/ui/widgets/model_selection_sheet.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
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
        body: Homepage(existingChat: widget.existingChat,),
        drawerScrimColor: Colors.white30,
        drawerEdgeDragWidth: 400,
        drawer: MyDrawer(),),
    );
  }
}

class Homepage extends StatefulWidget {
  final Chat? existingChat;
  const Homepage({super.key, this.existingChat});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String _selectedModel = "gpt-4";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("ChatGPT"),
        centerTitle: false,
        leading: GestureDetector(
            onTap: (){
              Scaffold.of(context).openDrawer();
            },
            child: SizedBox(
                width: 30,
                height: 30,
                child: SVGs.menu(size: 12)
            )
        ),
        actions: [
          GestureDetector(
              onTap: () {},
              child: SVGs.edit()
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, size: 24,),
            onPressed: () {
              showModelSelectorDialog(context, _selectedModel, (model) {
                LocalStorage.setSelectedModel(model);
                setState(() {
                  _selectedModel = model;
                });
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
      body: ChatScreen(existingChat: widget.existingChat,),
    );
  }
}