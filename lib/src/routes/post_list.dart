import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_paginate/angel_paginate.dart';
import 'package:hn/src/models/models.dart';
import 'package:hn/src/services.dart';

AngelConfigurer configureServer(Services services) {
  return (Angel app) async {
    app.get(
        '/',
        showPostList(
          'Top',
          (req) => {},
          filter: (users) => users..sort((a, b) => b.karma.compareTo(a.karma)),
        ));

    app.get(
        '/new',
        showPostList(
          'New',
          (req) => {},
          filter: (users) =>
              users..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
        ));
  };
}

Function showPostList(
    String title, Map<String, dynamic> Function(RequestContext) query,
    {Iterable<Post> Function(List<Post>) filter}) {
  return (Services services, RequestContext req, ResponseContext res,
      {user}) async {
    var paginator = await fetchPosts(query(req), req, services);
    await res.render('posts', {
      'title': title,
      'user': user,
      'paginator': paginator,
      'path': req.uri.path,
    });
  };
}

/// Fetches posts from the database, and paginates them.
Future<Paginator<Post>> fetchPosts(
    Map<String, dynamic> query, RequestContext req, Services services,
    {Iterable<Post> Function(List<Post>) filter}) async {
  Iterable<Post> posts = await services.postService
      .index({'query': query}).then((it) => it.map(PostSerializer.fromMap));

  if (filter != null) {
    posts = filter(posts.toList());
  }

  var paginator = new Paginator<Post>(
    posts,
    itemsPerPage: int.tryParse(req.query['items_per_page'].toString()) ?? 5,
  );

  paginator.goToPage(int.tryParse(req.query['page'].toString()) ?? 1);
  return paginator;
}
