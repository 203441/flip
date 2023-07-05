import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/post.dart';

class PostModel {
  final String id;
  final String description;
  final String fileUrl;
  final String userId;
  final String userName;
  final DateTime createdAt;
  final String fileName;

  PostModel({
    required this.id,
    required this.description,
    required this.fileUrl,
    required this.userId,
    required this.userName,
    required this.createdAt,
    required this.fileName,
  });

  Post toDomain() {
    return Post(
      id: id,
      description: description,
      fileUrl: fileUrl,
      userId: userId,
      userName: userName,
      createdAt: createdAt,
      fileName: fileName,
    );
  }

  factory PostModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return PostModel(
      id: snapshot.id,
      description: data['description'] as String,
      fileUrl: data['fileUrl'] as String,
      userId: data['userId'] as String,
      userName: data['userName'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      fileName: data['fileName'] as String,
    );
  }
}
