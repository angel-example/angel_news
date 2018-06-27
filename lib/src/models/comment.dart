import 'package:angel_model/angel_model.dart';
import 'package:angel_serialize/angel_serialize.dart';

part 'comment.g.dart';

part 'comment.serializer.g.dart';

@serializable
abstract class _Comment extends Model {
  String get userId;

  String get postId;

  String get parentId;

  String get text;

  int get karma;
}
