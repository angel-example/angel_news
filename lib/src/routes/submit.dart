import 'dart:async';
import 'package:angel_auth/angel_auth.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_validate/server.dart';
import 'package:hn/src/models/models.dart';
import 'package:hn/src/services.dart';
import 'package:canonical_url/canonical_url.dart';


AngelConfigurer configureServer(Services services) {
  var submitValidator = new Validator({
    requireField(PostFields.title): isNonEmptyString,
    PostFields.link: isString,
    PostFields.text: isString,
  });

  return (Angel app) async {
    app.get(
      '/submit',
      waterfall([
        requireAuth,
        (ResponseContext res) => res.render('submit', {'title': 'Submit'}),
      ]),
    );

    app.post(
      '/submit',
      waterfall([
        requireAuth,
        validate(submitValidator),
        submit,
      ]),
    );
  };
}

Future submit(RequestContext req, ResponseContext res, Services services,
    User user) async {
  var canonicalizer = new UrlCanonicalizer(removeFragment: true);
  var rgxAskAN = new RegExp(r'^ask an:');
  var rgxShowAN = new RegExp(r'^show an:');

  String title = req.body[PostFields.title].trim(),
      canonicalTitle = title.trim().toLowerCase();
  String link = req.body[PostFields.link]?.trim();
  String text = req.body[PostFields.text]?.trim();

  var type = rgxAskAN.hasMatch(canonicalTitle)
      ? PostType.askAN
      : (rgxShowAN.hasMatch(canonicalTitle)
          ? PostType.showAN
          : PostType.normal);

  if (link?.isNotEmpty != true && text?.isNotEmpty != true) {
    throw new AngelHttpException.badRequest(
        errors: ['Either a link, or a text body is required.']);
  }

  Post post;

  // Make sure no links are repeated.
  if (link?.isNotEmpty == true) {
    var canonicalLink = canonicalizer.canonicalize(link);
    Iterable<Map> existing = await services.postService.index({
      'query': {PostFields.link: canonicalLink}
    });

    if (existing.isNotEmpty) {
      post = PostSerializer.fromMap(existing.first);
    } else {
      link = canonicalLink;
    }
  }

  if (post == null) {
    post = new Post(
        userId: user.id,
        type: type,
        title: title,
        text: text,
        link: link,
        karma: 0);

    // Insert the post into the database, and deserialize it.
    post = await services.postService
        .create(post.toJson())
        .then((map) => PostSerializer.fromMap(map));
  }

  // Take the user to view the post...
  res.redirect('/post/${post.id}');
}
