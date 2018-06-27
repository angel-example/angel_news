import 'package:angel_auth/angel_auth.dart';
import 'package:hn/src/services.dart';
import 'find_user.dart';
import 'hash_user_password.dart';

LocalAuthVerifier localAuthVerifier(Services services, String pepper) {
  return (username, password) async {
    var user = await findUser(username, services);
    if (user == null) return null;

    // Don't sign a user in, if they have the wrong password, of course.
    var hash = hashUserPassword(password, user.salt, pepper);
    print('Hash $hash vs ${user.password} from ${user.username}');
    if (user.password != hash) return null;

    return user;
  };
}
