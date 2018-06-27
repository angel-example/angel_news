// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote.dart';

// **************************************************************************
// Generator: JsonModelGenerator
// **************************************************************************

class Vote extends _Vote {
  Vote(
      {this.id,
      this.isUpvote,
      this.userId,
      this.postId,
      this.commentId,
      this.createdAt,
      this.updatedAt});

  @override
  final String id;

  @override
  final bool isUpvote;

  @override
  final String userId;

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
      bool isUpvote,
      String userId,
      String postId,
      String commentId,
      DateTime createdAt,
      DateTime updatedAt}) {
    return new Vote(
        id: id ?? this.id,
        isUpvote: isUpvote ?? this.isUpvote,
        userId: userId ?? this.userId,
        postId: postId ?? this.postId,
        commentId: commentId ?? this.commentId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  bool operator ==(other) {
    return other is _Vote &&
        other.id == id &&
        other.isUpvote == isUpvote &&
        other.userId == userId &&
        other.postId == postId &&
        other.commentId == commentId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  Map<String, dynamic> toJson() {
    return VoteSerializer.toMap(this);
  }
}
