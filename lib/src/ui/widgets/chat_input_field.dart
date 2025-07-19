import 'package:chatgpt_clone/src/core/assets/svg_assets.dart';
import 'package:chatgpt_clone/src/ui/widgets/attachment_bottom_sheet.dart';
import 'package:flutter/material.dart';


class ChatInputField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        _isTyping = widget.controller.text.trim().isNotEmpty;
      });
    });
  }

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      barrierColor: Colors.grey.withOpacity(0.5),
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const AttachmentBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => _showCustomBottomSheet(context),
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFF2B2B2B),
                    radius: 22,
                    child: SVGs.photos(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    minLines: 1,
                    maxLines: 10,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(16, 12, 48, 12),
                      filled: true,
                      fillColor: const Color(0xFF2B2B2B),
                      hintText: "Ask anything",
                      hintStyle: const TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) {
                      if (_isTyping) widget.onSend();
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  if (_isTyping) {
                    widget.onSend();
                  } else {
                    debugPrint("Mic tapped");
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    backgroundColor: _isTyping ? Colors.white : Colors.black54,
                    radius: 20,
                    child: Icon(
                      _isTyping ? Icons.arrow_upward_rounded : Icons.graphic_eq_rounded,
                      color: _isTyping ? Colors.black : Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
            if (!_isTyping)
              Positioned(
                bottom: 12,
                right: 52,
                child: GestureDetector(
                  onTap: () {
                    debugPrint("Mic tapped");
                  },
                  child: const Icon(
                    Icons.mic,
                    color: Colors.white54,
                    size: 24,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
