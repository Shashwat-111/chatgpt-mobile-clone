import 'package:chatgpt_clone/src/core/assets/svg_assets.dart';
import 'package:chatgpt_clone/src/ui/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

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
              onTap: () {},
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
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: (){},
                      title: Text("Chat ${index + 1}", style: const TextStyle(color: Colors.white),),
                    );
                  }),
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
