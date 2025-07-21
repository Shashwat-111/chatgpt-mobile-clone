import 'dart:convert';
import 'package:chatgpt_clone/main.dart';
import 'package:chatgpt_clone/src/core/assets/svg_assets.dart';
import 'package:chatgpt_clone/src/models/message.dart';
import 'package:chatgpt_clone/src/ui/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SearchField(),
                const SizedBox(width: 16),
                SVGs.edit(),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 16),
            CustomListTile(
              svg: SVGs.edit(),
              label: "New Chat",
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const MyApp()),
                );
              },
            ),
            CustomListTile(
              svg: SVGs.photos(),
              label: "Library",
              onTap: () {},
            ),
            CustomListTile(
              svg: SVGs.explore(),
              label: "Explore",
              onTap: () {},
            ),
            CustomListTile(
              svg: SVGs.chat(),
              label: "Chats",
              onTap: () {},
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<ChatPreview>>(
                future: fetchChats(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    debugPrint(snapshot.error.toString());
                    return Center(child: Text('Unable to load past conversations\nServer is Unrechable.'));
                  } else {
                    final chats = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        final chat = chats[index];
                        return ListTile(
                            onTap: () async {
                              final response = await http.get(
                                Uri.parse('http://10.0.2.2:3000/api/chats/${chat.id}'),
                              );

                              if (response.statusCode == 200) {
                                final json = jsonDecode(response.body);
                                final fullChat = Chat.fromJson(json);

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => MyApp(existingChat: fullChat)),
                                );
                              }
                            },
                            title: Text(chat.title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                        );
                      },
                    );
                  }
                },
              )
              ,
            ),
            ListTile(
              leading:
                  CircleAvatar(backgroundColor: Colors.grey[700], radius: 20),
              title: const Row(
                children: [
                  Text("Shashawt dubey",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        enabled: false,
        minLines: 1,
        maxLines: 1,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(
              18, 12, 48, 12), // space for icon
          filled: true,
          fillColor:
          const Color(0xFF2B2B2B), // Slightly lighter black
          hintText: "Search",
          prefixIcon: SVGs.search(),
          hintStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

Future<List<ChatPreview>> fetchChats() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/chats'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List;
    return data.map((json) => ChatPreview.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch chats');
  }
}
