import 'package:angel_auth/angel_auth.dart' hide UserSerializer;
import 'package:angel_framework/angel_framework.dart';
import 'package:hn/src/models/models.dart';
import 'package:hn/src/services.dart';
import 'auth/auth.dart';

AngelConfigurer configureServer(Services services) {
  return (Angel app) async {
    // Grab the JWT secret from the environment.
    var pepper = app.configuration['jwt_secret'] as String;

    // Use `AngelAuth` to manage user authentication.
    var auth = new AngelAuth<User>(
      jwtKey: pepper,
      jwtLifeSpan: const Duration(days: 365).inMilliseconds,
      secureCookies: app.isProduction,
      //cookieDomain: 'localhost:3000',
    );

    // Decode JWT's sent to the server on each request.
    app.use(auth.decodeJwt);

    // A function that serializes a user for a JWT.
    auth.serializer = (u) => u.id;

    // A function that finds the user associated with a JWT.
    auth.deserializer = (id) {
      return services.userService
          .read(id)
          .then((map) => UserSerializer.fromMap(map));
    };

    await app.configure(auth.configureServer);

    auth.strategies
        .add(new LocalAuthStrategy(localAuthVerifier(services, pepper)));

    app.group('/auth', authRoutes(auth, pepper));
  };
}
