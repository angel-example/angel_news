import 'dart:async';
import 'package:angel_auth/angel_auth.dart' hide UserSerializer;
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_validate/server.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:hn/src/models/models.dart';
import 'package:hn/src/services.dart';
import 'package:uuid/uuid.dart';

Future configureServer(Angel app) async {
  // Grab the JWT secret from the environment.
  var pepper = app.configuration['jwt_secret'] as String;

  // Grab a reference to our services from the IoC container.
  var services = app.container.make(Services) as Services;

  // Use `AngelAuth` to manage user authentication.
  var auth = new AngelAuth<User>(jwtKey: pepper);

  // A function that serializes a user for a JWT.
  auth.serializer = (u) => u.id;

  // A function that finds the user associated with a JWT.
  auth.deserializer = (id) {
    return services.userService
        .read(id)
        .then((map) => UserSerializer.fromMap(map));
  };

  auth.strategies.add(new LocalAuthStrategy((username, password) async {
    var user = await findUser(username, services);
    if (user == null) return null;

    // Don't sign a user in, if they have the wrong password, of course.
    if (user.password != hashUserPassword(password, user.salt, pepper))
      return null;

    return user;
  }));

  app.group('/auth', (router) {
    // Create the /auth/login route; we'll point a form here.
    router.post(
        '/login',
        auth.authenticate(
            'local',
            new AngelAuthOptions(
              callback: authCallback,
              failureRedirect: '/login?bad_login=1',
            )));

    // We also want to sign users up, at /auth/create_account.
    //
    // Let's create a `Validator`, which enforces that:
    // * username and password are both present
    // * username and password are both strings, and not the empty string.
    // * goto is optional, but it must be a string.
    var createAccountValidator = new Validator(
        {'username*,password*': isNonEmptyString, 'goto': isString});

    router
        .chain(validate(createAccountValidator))
        .post('/create_account', createAccount(auth, pepper));
  });
}

// If the user was signed in successfully, then take them to /,
// OR to the "goto" value from the request body.
authCallback(RequestContext req, ResponseContext res, [String jwt]) {
  res.redirect(req.body['goto'] ?? '/');
  return false;
}

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
      var salt = uuid.v4();
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
          .then((map) => UserSerializer.fromMap(map));
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

// Create a hash of a password...
String hashUserPassword(String password, String salt, String pepper) {
  var bytes = sha256.convert('$password.$salt:$pepper'.codeUnits).bytes;
  return hex.encode(bytes);
}

Future<User> findUser(String username, Services services) async {
  // * Create a query that searches for a user with the given username.
  var query = {UserFields.username: username};

  // * Query the database
  // * Use the deserializer to create typed Dart objects
  Iterable<User> users = await services.userService
      .index({'query': query}).then((it) => it.map(UserSerializer.fromMap));

  return users.isEmpty ? null : users.first;
}
