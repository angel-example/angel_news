// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// Generator: SerializerGenerator
// **************************************************************************

abstract class CommentSerializer {
  static Comment fromMap(Map map) {
    return new Comment(
        id: map['id'],
        userId: map['user_id'],
        postId: map['post_id'],
        parentId: map['parent_id'],
        text: map['text'],
        karma: map['karma'],
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? map['created_at']
                : DateTime.parse(map['created_at']))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? map['updated_at']
                : DateTime.parse(map['updated_at']))
            : null);
  }

  static Map<String, dynamic> toMap(Comment model) {
    return {
      'id': model.id,
      'user_id': model.userId,
      'post_id': model.postId,
      'parent_id': model.parentId,
      'text': model.text,
      'karma': model.karma,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String()
    };
  }
}

abstract class CommentFields {
  static const String id = 'id';

  static const String userId = 'user_id';

  static const String postId = 'post_id';

  static const String parentId = 'parent_id';

  static const String text = 'text';

  static const String karma = 'karma';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';
}
