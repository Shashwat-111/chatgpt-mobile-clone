import 'package:chatgpt_clone/src/core/assets/svg_assets.dart';
import 'package:chatgpt_clone/src/models/message.dart';
import 'package:chatgpt_clone/src/ui/widgets/chat_input_field.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

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

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty || !_isConnected) return;

    _addMessage(Message(role: Role.user, content: text));
    _controller.clear();

    try {
      _channel.sink.add(text);
    } catch (e) {
      _addMessage(Message(role: Role.system, content: 'Failed to send message.'));
    }
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
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                      maxWidth: isUser
                          ? MediaQuery.of(context).size.width * 0.75
                          : MediaQuery.of(context).size.width * 0.85,
                    ),
                    decoration: BoxDecoration(
                      color: isUser
                          ? const Color(0xFF2B2B2B)
                          : Colors.transparent,
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
                        if(!isUser)
                          const SizedBox(height: 12),
                        if(!isUser)
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
                );
              },
            ),
          ),
          ChatInputField(
            controller: _controller,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}