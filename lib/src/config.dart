import 'package:angel_configuration/angel_configuration.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_jael/angel_jael.dart';
import 'package:dart2_constant/io.dart';
import 'package:file/file.dart';

AngelConfigurer configureServer(FileSystem fs) {
  return (Angel app) async {
    app.container.singleton(fs, as: FileSystem);

    // Loads app configuration from 'config/'.
    // It supports loading from YAML files, and also supports loading a `.env` file.
    //
    // https://github.com/angel-dart/configuration
    await app.configure(configuration(fs));

    // All loaded configuration will be added to `app.configuration`.
    app.logger.config('Loaded configuration: ${app.configuration}');

    // Configure our application to render HTML templates using Jael,
    // a templating engine that supports expression literals, loops,
    // conditionals, and more.
    //
    // https://github.com/angel-dart/jael
    await app.configure(jael(fs.directory('views')));

    // Enable GZIP and DEFLATE compression (conserves bandwidth)
    // https://github.com/angel-dart/compress
    app.injectEncoders({
      'gzip': gzip.encoder,
      'deflate': zlib.encoder,
    });
  };
}
