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
}
