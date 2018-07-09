// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonModelGenerator
// **************************************************************************

class Comment extends _Comment {
  Comment(
      {this.id,
      this.userId,
      this.postId,
      this.parentId,
      this.text,
      this.karma,
      this.user,
      this.createdAt,
      this.updatedAt});

  @override
  final String id;

  @override
  final String userId;

  @override
  final String postId;

  @override
  final String parentId;

  @override
  final String text;

  @override
  final int karma;

  @override
  final User user;

  @override
  final DateTime createdAt;

  @override
  final DateTime updatedAt;

  Comment copyWith(
      {String id,
      String userId,
      String postId,
      String parentId,
      String text,
      int karma,
      User user,
      DateTime createdAt,
      DateTime updatedAt}) {
    return new Comment(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        postId: postId ?? this.postId,
        parentId: parentId ?? this.parentId,
        text: text ?? this.text,
        karma: karma ?? this.karma,
        user: user ?? this.user,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  bool operator ==(other) {
    return other is _Comment &&
        other.id == id &&
        other.userId == userId &&
        other.postId == postId &&
        other.parentId == parentId &&
        other.text == text &&
        other.karma == karma &&
        other.user == user &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  Map<String, dynamic> toJson() {
    return CommentSerializer.toMap(this);
  }
}
