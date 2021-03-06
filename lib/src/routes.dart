import 'package:angel_framework/angel_framework.dart';
import 'package:angel_static/angel_static.dart';
import 'package:file/file.dart';
import 'package:hn/src/services.dart';
import 'routes/auth.dart' as auth;
import 'routes/post_list.dart' as post_list;
import 'routes/submit.dart' as submit;

AngelConfigurer configureServer(FileSystem fs) {
  return (Angel app) async {
    // Grab a reference to our services from the IoC container.
    var services = app.container.make(Services) as Services;

    await app.configure(auth.configureServer(services));
    await app.configure(post_list.configureServer(services));
    await app.configure(submit.configureServer(services));

    app.get('/login', (RequestContext req, ResponseContext res) async {
      await res.render('login', {
        'goto': req.query['goto'],
        'bad_login': req.query.containsKey('bad_login'),
        'bad_signup': req.query.containsKey('bad_signup'),
      });
    });

    // Sets up a static server.
    //
    // https://github.com/angel-dart/static
    var vDir = new VirtualDirectory(app, fs, source: fs.directory('web'));

    // Send requests through to the static file handler.
    app.use(vDir.handleRequest);

    // This route will only run if the request was not terminated by a prior handler.
    // Usually, this is a situation in which you'll want to throw a 404 error.
    //
    // On 404's, let's show the user the text "Unknown.", just like HackerNews.
    app.use((RequestContext req, ResponseContext res) async {
      if (req.accepts('text/html', strict: true)) {
        res
          ..statusCode = 404
          ..write('Unknown.');
      } else {
        throw new AngelHttpException.notFound();
      }
    });
  };
}
