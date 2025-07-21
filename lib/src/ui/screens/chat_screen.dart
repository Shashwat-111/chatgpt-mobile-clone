import 'dart:convert';
import 'dart:io';

import 'package:chatgpt_clone/src/core/assets/svg_assets.dart';
import 'package:chatgpt_clone/src/models/message.dart';
import 'package:chatgpt_clone/src/ui/widgets/chat_input_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];
  late WebSocketChannel _channel;
  bool _isTyping = false;
  bool _isConnected = false;
  File? _selectedImage;
  String? _selectedImageUrl;

  @override
  void initState() {
    super.initState();
    _connectSocket();
  }

  void _connectSocket() {
    _channel = WebSocketChannel.connect(Uri.parse('ws://localhost:3000'));

    _channel.stream.listen(
      (data) {
        if (data == '[END]') {
          _isTyping = false;
          if (_messages.isNotEmpty && _messages.first.role == Role.assistant) {
            setState(() {
              _messages.first.isComplete = true;
            });
          }
        } else if (data == '[ERROR]') {
          _addMessage(
            Message(role: Role.system, content: 'Something went wrong.'),
          );
        } else {
          if (_messages.isNotEmpty &&
              _messages.first.role == Role.assistant &&
              _isTyping) {
            _messages.first.content += data;
          } else {
            _messages.insert(
              0,
              Message(role: Role.assistant, content: data, isComplete: false),
            );
            _isTyping = true;
          }
          setState(() {});
        }
      },
      onDone: () {
        _isConnected = false;
        debugPrint('Socket closed');
      },
      onError: (error) {
        _addMessage(
          Message(role: Role.system, content: 'Socket error: $error'),
        );
      },
    );

    _isConnected = true;
  }

  void _addMessage(Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if ((text.isEmpty && _selectedImage == null) || !_isConnected) return;

    // Upload image if exists
    if (_selectedImage != null) {
      _selectedImageUrl = await _uploadImage(_selectedImage!);
      debugPrint('Image uploaded: $_selectedImageUrl');
    }

    final newMsg = Message(
      role: Role.user,
      content: text,
      image: _selectedImageUrl,
    );
    _addMessage(newMsg);
    _controller.clear();

    final history = _messages.reversed
        .where((msg) => msg.role != Role.system)
        .map((msg) => {
      'role': msg.role.name,
      'content': msg.content,
      if (msg.image != null) 'imageUrl': msg.image,
    })
        .toList();

    final payload = jsonEncode({
      'prompt': text,
      'imageUrl': _selectedImageUrl,
      'history': history,
    });

    _channel.sink.add(payload);

    setState(() {
      _selectedImage = null;
      _selectedImageUrl = null;
    });
  }


  Future<void> _pickImage() async {
    // Dismiss the bottom sheet first
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }

    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      if (mounted) {
        setState(() {
          _selectedImage = File(picked.path);
        });
      }
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      final bytes = await image.readAsBytes();
      final base64Img = base64Encode(bytes);

      final response = await http.post(
        Uri.parse('http://localhost:3000/api/upload-image'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'base64': base64Img}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['url'];
      }
    } catch (e) {
      debugPrint('Image upload failed: $e');
    }
    return null;
  }


  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _channel.sink.close(status.goingAway);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg.role == Role.user;
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (isUser && msg.image != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            msg.image ?? "",
                            width: MediaQuery.of(context).size.width * 0.65,
                            fit: BoxFit.cover,
                          ),
                        ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(12),
                        constraints: BoxConstraints(
                          maxWidth: isUser
                              ? MediaQuery.of(context).size.width * 0.75
                              : MediaQuery.of(context).size.width * 0.85,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isUser ? const Color(0xFF2B2B2B) : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              msg.content,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (!isUser) const SizedBox(height: 12),
                            if (!isUser)
                              AnimatedOpacity(
                                opacity: msg.isComplete ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeIn,
                                child: Row(
                                  children: [
                                    SVGs.copy(),
                                    const SizedBox(width: 12),
                                    SVGs.like(),
                                    const SizedBox(width: 12),
                                    SVGs.dislike(),
                                    const SizedBox(width: 12),
                                    SVGs.volume(),
                                    const SizedBox(width: 12),
                                    SVGs.resend()
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ChatInputField(
            controller: _controller,
            onSend: _sendMessage,
            onImageTap: _pickImage,
            selectedImage: _selectedImage,
            onRemoveImage: () => setState(() => _selectedImage = null),
          ),
        ],
      ),
    );
  }
}
