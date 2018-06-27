import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

// Create a hash of a password...
String hashUserPassword(String password, String salt, String pepper) {
  var bytes = sha256.convert('$password.$salt:$pepper'.codeUnits).bytes;
  return hex.encode(bytes);
}
