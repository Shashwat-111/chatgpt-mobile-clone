import 'package:chatgpt_clone/src/models/chat.dart';
import 'package:flutter/material.dart';
import '../../core/assets/svg_assets.dart';
import '../../core/storage/local_storage.dart';
import '../widgets/model_selection_sheet.dart';
import 'chat_screen.dart';


class Homepage extends StatefulWidget {
  final Chat? existingChat;
  const Homepage({super.key, this.existingChat});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // just a default value
  String _selectedModel = "gpt-4";

  @override
  void initState() {
    getSelectedModel();
    super.initState();
  }

  getSelectedModel () async {
    _selectedModel = await LocalStorage.selectedModel;
  }

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
                child: SVGs.menu()
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

                //save the selected model to local storage.
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