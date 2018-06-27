import 'package:angel_model/angel_model.dart';
import 'package:angel_serialize/angel_serialize.dart';
part 'vote.g.dart';
part 'vote.serializer.g.dart';

@serializable
abstract class _Vote extends Model {
  String get userId;

  String get postId;

  String get commentId;

  bool isUpvote;
}
