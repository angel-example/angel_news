// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonModelGenerator
// **************************************************************************

class Post extends _Post {
  Post(
      {this.id,
      this.userId,
      this.type,
      this.title,
      this.link,
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
  final PostType type;

  @override
  final String title;

  @override
  final String link;

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

  Post copyWith(
      {String id,
      String userId,
      PostType type,
      String title,
      String link,
      String text,
      int karma,
      User user,
      DateTime createdAt,
      DateTime updatedAt}) {
    return new Post(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        type: type ?? this.type,
        title: title ?? this.title,
        link: link ?? this.link,
        text: text ?? this.text,
        karma: karma ?? this.karma,
        user: user ?? this.user,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  bool operator ==(other) {
    return other is _Post &&
        other.id == id &&
        other.userId == userId &&
        other.type == type &&
        other.title == title &&
        other.link == link &&
        other.text == text &&
        other.karma == karma &&
        other.user == user &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  Map<String, dynamic> toJson() {
    return PostSerializer.toMap(this);
  }
}
