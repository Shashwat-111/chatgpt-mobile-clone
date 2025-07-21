enum Role {
  user,
  assistant,
  system,
}

class Message {
  final Role role;
  String content;
  bool isComplete;
  String? image;

  Message({
    required this.role,
    required this.content,
    this.isComplete = false,
    this.image,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      role: Role.values.firstWhere((e) => e.name == json['role']),
      content: json['content'],
      image: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
    'role': role.name,
    'content': content,
    'imageUrl': image,
  };
}

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
