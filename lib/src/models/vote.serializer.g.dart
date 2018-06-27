// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote.dart';

// **************************************************************************
// Generator: SerializerGenerator
// **************************************************************************

abstract class VoteSerializer {
  static Vote fromMap(Map map) {
    return new Vote(
        id: map['id'],
        isUpvote: map['is_upvote'],
        userId: map['user_id'],
        postId: map['post_id'],
        commentId: map['comment_id'],
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

  static Map<String, dynamic> toMap(Vote model) {
    return {
      'id': model.id,
      'is_upvote': model.isUpvote,
      'user_id': model.userId,
      'post_id': model.postId,
      'comment_id': model.commentId,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String()
    };
  }
}

abstract class VoteFields {
  static const String id = 'id';

  static const String isUpvote = 'is_upvote';

  static const String userId = 'user_id';

  static const String postId = 'post_id';

  static const String commentId = 'comment_id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';
}
