import 'package:angel_auth/angel_auth.dart' hide UserSerializer;
import 'package:angel_framework/angel_framework.dart';
import 'package:hn/src/models/models.dart';
import 'package:hn/src/services.dart';
import 'package:uuid/uuid.dart';
import 'auth_callback.dart';
import 'find_user.dart';
import 'hash_user_password.dart';

Function createAccount(AngelAuth<User> auth, String pepper) {
  // Angel's IoC container will ensure that all these parameters are available at runtime.
  return (RequestContext req, ResponseContext res, Services services,
      Uuid uuid) async {
    // Grab the data from the request body.
    String username = req.body['username'], password = req.body['password'];

    // If a user already exists, see if we can just sign them in instead.
    var user = await findUser(username, services);

    // Find or create a user...
    if (user != null) {
      if (user.password != hashUserPassword(password, user.salt, pepper)) {
        user = null;
      }
    } else {
      // Otherwise, create a new user.
      var salt = uuid.v4() as String;
      user = new User(
          username: username,
          salt: salt,
          password: hashUserPassword(password, salt, pepper),
          karma: 0);

      // The user we've created has no ID, because it's purely a Dart object,
      // and doesn't exist in the database.
      //
      // We need to insert it into the database. Then, we deserialize the database's response,
      // as it contains timestamps, the ID, etc.
      user = await services.userService
          .create(user.toJson())
          .then((map) => UserSerializer.fromMap(map as Map));
    }

    // Now that we've found or created a user, let's give the user a response.
    if (user != null) {
      // Log the user in; `package:angel_auth` will take care of setting cookies, etc.
      await auth.loginById(user.id, req, res);

      // Next, just call the auth callback, and redirect the user.
      return await authCallback(req, res);
    } else {
      res
        ..statusCode = 401
        ..redirect('/login?bad_signup=1');
    }
  };
}
