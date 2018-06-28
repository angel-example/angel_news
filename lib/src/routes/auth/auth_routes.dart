import 'package:angel_auth/angel_auth.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_validate/server.dart';
import 'package:hn/src/models/models.dart';
import 'auth_callback.dart';
import 'create_account.dart';

void Function(Router) authRoutes(AngelAuth<User> auth, String pepper) {
  // Create the /auth/login route; we'll point a form here.
  var loginHandler = auth.authenticate(
    'local',
    new AngelAuthOptions(
      callback: authCallback,
      failureRedirect: '/login?bad_login=1',
    ),
  );

  var logoutHandler = waterfall([
    auth.logout,
    (ResponseContext res) => res.redirect('/'),
  ]);

  // We also want to sign users up, at /auth/create_account.
  //
  // Let's create a `Validator`, which enforces that:
  // * username and password are both present
  // * username and password are both strings, and not the empty string.
  // * goto is optional, but it must be a string.
  var createAccountValidator = new Validator({
    requireFields(['username', 'password']): isNonEmptyString,
    'goto': isString
  });

  var createAccountHandler = waterfall([
    validate(createAccountValidator),
    createAccount(auth, pepper),
  ]);

  return (router) {
    router.post('/create_account', createAccountHandler);
    router.post('/login', loginHandler);
    router.get('/logout', logoutHandler);
  };
}
