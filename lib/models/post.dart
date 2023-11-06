

// post.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String id;
  String content;
  DateTime createdAt;

  PostModel({required this.id, required this.content, required this.createdAt});

  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return PostModel(
      id: doc.id,
      content: data['content'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
