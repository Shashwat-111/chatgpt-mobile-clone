import 'dart:io';

import 'package:chatgpt_clone/src/core/assets/svg_assets.dart';
import 'package:chatgpt_clone/src/ui/widgets/attachment_bottom_sheet.dart';
import 'package:flutter/material.dart';


class ChatInputField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onImageTap;
  final VoidCallback onRemoveImage;
  final VoidCallback onSend;
  final File? selectedImage;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onImageTap,
    required this.onRemoveImage,
    this.selectedImage,
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
      builder: (_) => AttachmentBottomSheet(onAttachmentTap: ()=> widget.onImageTap(),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
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
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B2B2B),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.selectedImage != null) ...[
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  widget.selectedImage!,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 2,
                                right: 2,
                                child: GestureDetector(
                                  onTap: widget.onRemoveImage,
                                  child: const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.black54,
                                    child: Icon(Icons.close, size: 12, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                        TextField(
                          controller: widget.controller,
                          minLines: 1,
                          maxLines: 6,
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: const InputDecoration(
                            fillColor: Colors.transparent,
                            isDense: true,
                            contentPadding: EdgeInsets.only(right: 40),
                            hintText: "Ask anything",
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (_) {
                            if (_isTyping) widget.onSend();
                          },
                        ),
                      ],
                    ),
                  ),
                  if (!_isTyping)
                    Positioned(
                      bottom: 12,
                      right: 54   ,
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
                  Padding(
                    padding: const EdgeInsets.only(right: 8, bottom: 6),
                    child: GestureDetector(
                      onTap: () {
                        if (_isTyping) {
                          widget.onSend();
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: _isTyping ? Colors.white : Colors.black54,
                        radius: 18,
                        child: Icon(
                          _isTyping ? Icons.arrow_upward_rounded : Icons.graphic_eq_rounded,
                          color: _isTyping ? Colors.black : Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
