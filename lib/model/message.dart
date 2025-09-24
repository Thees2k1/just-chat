class Message {
  String text;
  String userId;
  String username;
  String? avatarUrl;

  Message({
    required this.text,
    required this.username,
    required this.userId,
    this.avatarUrl,
  });
}
