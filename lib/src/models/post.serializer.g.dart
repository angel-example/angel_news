// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// Generator: SerializerGenerator
// **************************************************************************

abstract class PostSerializer {
  static Post fromMap(Map map) {
    return new Post(
        id: map['id'] as String,
        userId: map['user_id'] as String,
        type: map['type'] is PostType
            ? map['type']
            : (map['type'] is int ? PostType.values[map['type']] : null),
        title: map['title'] as String,
        link: map['link'] as String,
        text: map['text'] as String,
        karma: map['karma'] as int,
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? (map['created_at'] as DateTime)
                : DateTime.parse(map['created_at']))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? (map['updated_at'] as DateTime)
                : DateTime.parse(map['updated_at']))
            : null);
  }

  static Map<String, dynamic> toMap(Post model) {
    return {
      'id': model.id,
      'user_id': model.userId,
      'type': model.type == null ? null : PostType.values.indexOf(model.type),
      'title': model.title,
      'link': model.link,
      'text': model.text,
      'karma': model.karma,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String()
    };
  }
}

abstract class PostFields {
  static const String id = 'id';

  static const String userId = 'user_id';

  static const String type = 'type';

  static const String title = 'title';

  static const String link = 'link';

  static const String text = 'text';

  static const String karma = 'karma';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';
}
