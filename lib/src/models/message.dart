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
