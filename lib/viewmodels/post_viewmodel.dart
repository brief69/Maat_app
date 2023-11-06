

// tweet_view_model.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdv/models/post.dart';

final postListProvider = StreamProvider.autoDispose<List<PostModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('post')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) => PostModel.fromFirestore(doc)).toList();
  });
});
