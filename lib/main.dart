import 'dart:io';
import 'package:fake_browser/service/app_path.dart';
import 'package:flutter/material.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_static/shelf_static.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppPath appPath = AppPath();
  await appPath.init();

  final cascade = Cascade().add((Request request) {
    final uriPath = request.requestedUri.path;
    if (uriPath.startsWith('/custom_search_page/')
        || (uriPath.startsWith('/custom_search_page') && uriPath.endsWith('/custom_search_page'))
        || uriPath.startsWith('/noteview/')
        || (uriPath.startsWith('/noteview') && uriPath.endsWith('/noteview'))
    ) {
      final staticHandler = createStaticHandler(appPath.getWebFilePath(),
          defaultDocument: 'index.html');
      return staticHandler(request);
    } else {
      return Response.notFound('Not Found');
    }
  });

  final server = await serve(cascade.handler, InternetAddress.anyIPv4, 8080);

  // final server = await serve(handler, InternetAddress.anyIPv4, 8080);
  print('Local server running on ${server.address}:${server.port}');
}
