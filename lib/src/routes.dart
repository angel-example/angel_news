import 'package:angel_framework/angel_framework.dart';
import 'package:angel_static/angel_static.dart';
import 'package:file/file.dart';

AngelConfigurer configureServer(FileSystem fs) {
  return (Angel app) async {
    // Sets up a static server.
    //
    // https://github.com/angel-dart/static
    var vDir = new VirtualDirectory(app, fs, source: fs.directory('web'));

    // Send requests through to the static file handler.
    app.use(vDir.handleRequest);

    // This route will only run if the request was not terminated by a prior handler.
    // Usually, this is a situation in which you'll want to throw a 404 error.
    //
    // On 404's, let's show the user to a pretty error page.
    app.use((RequestContext req, ResponseContext res) async {
      if (req.accepts('text/html', strict: true)) {
        await res.render('404', {'title': '404'});
      } else {
        throw new AngelHttpException.notFound();
      }
    });
  };
}
