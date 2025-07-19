enum Role {
  user,
  assistant,
  system,
}

class Message {
  final Role role;
  String content;
  bool isComplete;

  Message({
    required this.role,
    required this.content,
    this.isComplete = false,
  });
}
