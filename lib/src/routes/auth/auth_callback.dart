// If the user was signed in successfully, then take them to /,
// OR to the "goto" value from the request body.
import 'package:angel_framework/angel_framework.dart';

authCallback(RequestContext req, ResponseContext res, [String jwt]) async {
  await req.parse();
  var goto = req.body['goto']?.toString() ?? '';
  res.redirect(goto.isNotEmpty ? goto : '/');
  return false;
}
