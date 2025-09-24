class User {
  String id;
  String email;
  String? username;
  String? avatarUrl;
  User({required this.email, required this.id, this.username, this.avatarUrl});
}
