import 'package:angel_model/angel_model.dart';
import 'package:angel_serialize/angel_serialize.dart';

part 'user.g.dart';

part 'user.serializer.g.dart';

@serializable
abstract class _User extends Model {
  String get username;

  String get password;

  String get salt;

  int get karma;
}
