class Post {
  final String id;
  final String description;
  final String fileUrl;
  final String userId;
  final String userName;
  final DateTime createdAt;
  final String fileName;

  Post({
    required this.id,
    required this.description,
    required this.fileUrl,
    required this.userId,
    required this.userName,
    required this.createdAt,
    required this.fileName,
  });
}
