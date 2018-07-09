import 'dart:async';
import 'package:hn/src/models/models.dart';
import 'package:hn/src/services.dart';

Future<User> findUser(String username, Services services) async {
  // * Create a query that searches for a user with the given username.
  var query = {UserFields.username: username};

  // * Query the database
  // * Use the deserializer to create typed Dart objects
  var users = await services.userService
          .index({'query': query}).then((it) => it.map(UserSerializer.fromMap))
      as Iterable<User>;

  return users.isEmpty ? null : users.first;
}
