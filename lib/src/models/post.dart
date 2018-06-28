import 'package:angel_model/angel_model.dart';
import 'package:angel_serialize/angel_serialize.dart';
import 'package:collection/collection.dart';
import 'package:timeago/timeago.dart';
import 'user.dart';

part 'post.g.dart';

part 'post.serializer.g.dart';

enum PostType { normal, askAN, showAN }

@serializable
abstract class _Post extends Model {
  String get userId;

  PostType get type;

  String get title;

  String get link;

  String get text;

  int get karma;

  User get user;

  String get linkTo => isLink ? link : '/post/$id';

  bool get isLink => link?.isNotEmpty == true;

  String get hostname =>  Uri.parse(link).host;

  String get fuzzyTime => timeAgo(createdAt.toLocal());
}
