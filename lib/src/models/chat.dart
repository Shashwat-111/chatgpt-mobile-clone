import 'message.dart';

// for displaying full chat/conversation. Also used when fetching full chat
// data from backend
class Chat {
  final String id;
  final String title;
  final List<Message> messages;
  final DateTime createdAt;

  Chat({
    required this.id,
    required this.title,
    required this.messages,
    required this.createdAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['_id'],
      title: json['title'],
      createdAt: DateTime.parse(json['createdAt']),
      messages: (json['messages'] as List)
          .map((msg) => Message.fromJson(msg))
          .toList(),
    );
  }
}


//used in nav drawer to display a list of all past chats.
class ChatPreview {
  final String id;
  final String title;
  final DateTime createdAt;

  ChatPreview({required this.id, required this.title, required this.createdAt});

  factory ChatPreview.fromJson(Map<String, dynamic> json) => ChatPreview(
    id: json['_id'],
    title: json['title'],
    createdAt: DateTime.parse(json['createdAt']),
  );
}
