import 'dart:async';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_paginate/angel_paginate.dart';
import 'package:dart2_tryparse/dart2_tryparse.dart';
import 'package:hn/src/models/models.dart';
import 'package:hn/src/services.dart';

AngelConfigurer configureServer(Services services) {
  return (Angel app) async {
    app.get('/post/:id', (String id, ResponseContext res) async {
      var post = await services.postService
          .read(id)
          .then((map) => PostSerializer.fromMap(map));
      var user = await services.userService
          .read(post.userId)
          .then((map) => UserSerializer.fromMap(map));

      await res.render('post', {
        'title': post.title,
        'post': post.copyWith(user: user),
      });
    });

    app.get(
        '/',
        showPostList(
          null,
          (req) => {},
          filter: filterTopPosts,
        ));

    app.get(
        '/new',
        showPostList(
          'New Links',
          (req) => {},
          filter: (users) =>
              users..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
        ));

    app.get(
        '/show',
        showPostList(
          'Show',
          (req) => queryByType(PostType.showAN),
          filter: filterTopPosts,
        ));

    app.get(
        '/ask',
        showPostList(
          'Ask',
          (req) => queryByType(PostType.askAN),
          filter: filterTopPosts,
        ));
  };
}

Map<String, dynamic> queryByType(PostType type) =>
    {PostFields.type: PostType.values.indexOf(type)};

Iterable<Post> filterTopPosts(List<Post> posts) => posts..sort(sortTopPosts);

int sortTopPosts(Post a, Post b) {
  return b.karma.compareTo(a.karma);
}

Function showPostList(
    String title, Map<String, dynamic> Function(RequestContext) query,
    {Iterable<Post> Function(List<Post>) filter}) {
  return (Services services, RequestContext req, ResponseContext res,
      {user}) async {
    var paginator = await fetchPosts(query(req), req, services, filter: filter);
    await res.render('posts', {'title': title, 'paginator': paginator});
  };
}

/// Fetches posts from the database, and paginates them.
Future<Paginator<Post>> fetchPosts(
    Map<String, dynamic> query, RequestContext req, Services services,
    {Iterable<Post> Function(List<Post>) filter}) async {
  Future index;

  if (query.isEmpty) {
    index = services.postService.index();
  } else {
    index = services.postService.index({'query': query});
  }

  Iterable<Post> posts =
      await index.then((it) => it.map(PostSerializer.fromMap));

  // Fetch the user
  var users = <String, User>{};

  posts = await Future.wait<Post>(posts.map((post) async {
    var user = users[post.userId] ??= await services.userService
        .read(post.userId)
        .then((map) => UserSerializer.fromMap(map));
    return post.copyWith(user: user);
  }));

  if (filter != null) {
    posts = filter(posts.toList());
  }

  var paginator = new Paginator<Post>(
    posts,
    itemsPerPage: tryParseInt(req.query['items_per_page'].toString()) ?? 30,
  );

  paginator.goToPage(tryParseInt(req.query['page'].toString()) ?? 1);
  return paginator;
}
