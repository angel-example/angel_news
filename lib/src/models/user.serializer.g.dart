// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// Generator: SerializerGenerator
// **************************************************************************

abstract class UserSerializer {
  static User fromMap(Map map) {
    return new User(
        id: map['id'],
        username: map['username'],
        password: map['password'],
        salt: map['salt'],
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

  static Map<String, dynamic> toMap(User model) {
    return {
      'id': model.id,
      'username': model.username,
      'password': model.password,
      'salt': model.salt,
      'karma': model.karma,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String()
    };
  }
}

abstract class UserFields {
  static const String id = 'id';

  static const String username = 'username';

  static const String password = 'password';

  static const String salt = 'salt';

  static const String karma = 'karma';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';
}
