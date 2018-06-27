import 'dart:async';
import 'dart:io';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_hot/angel_hot.dart';
import 'package:logging/logging.dart';
import 'package:hn/src/pretty_logging.dart' as hn;
import 'package:hn/hn.dart' as hn;

main() async {
  Logger logger;

  Future<Angel> createServer() async {
    var app = new Angel()..lazyParseBodies = true;
    app.logger =
        logger ??= new Logger('hacker_news')..onRecord.listen(hn.prettyLog);
    await app.configure(hn.configureServer);
    return app;
  }

  var hot = new HotReloader(createServer, [
    // We can listen for changes at a multitude of paths.
    new Directory('bin'),
    new Directory('config'),
    new Directory('lib'),
    new File('pubspec.lock')
  ]);

  var server = await hot.startServer('127.0.0.1', 3000);
  server.defaultResponseHeaders.clear();

  print('Listening at http://${server.address.address}:${server.port}');
}
