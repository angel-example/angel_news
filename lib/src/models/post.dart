import 'package:angel_model/angel_model.dart';
import 'package:angel_serialize/angel_serialize.dart';

part 'post.g.dart';

part 'post.serializer.g.dart';

@serializable
abstract class _Post extends Model {
  String get userId;

  String get title;

  String get link;

  String get text;

  int get karma;
}
