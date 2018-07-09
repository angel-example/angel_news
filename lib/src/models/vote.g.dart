// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote.dart';

// **************************************************************************
// JsonModelGenerator
// **************************************************************************

class Vote extends _Vote {
  Vote(
      {this.id,
      this.userId,
      this.type,
      this.postId,
      this.commentId,
      this.createdAt,
      this.updatedAt});

  @override
  final String id;

  @override
  final String userId;

  @override
  final VoteType type;

  @override
  final String postId;

  @override
  final String commentId;

  @override
  final DateTime createdAt;

  @override
  final DateTime updatedAt;

  Vote copyWith(
      {String id,
      String userId,
      VoteType type,
      String postId,
      String commentId,
      DateTime createdAt,
      DateTime updatedAt}) {
    return new Vote(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        type: type ?? this.type,
        postId: postId ?? this.postId,
        commentId: commentId ?? this.commentId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  bool operator ==(other) {
    return other is _Vote &&
        other.id == id &&
        other.userId == userId &&
        other.type == type &&
        other.postId == postId &&
        other.commentId == commentId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  Map<String, dynamic> toJson() {
    return VoteSerializer.toMap(this);
  }
}
