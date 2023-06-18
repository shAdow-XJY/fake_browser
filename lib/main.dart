import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_static/shelf_static.dart';

void main() async {
  final staticHandler = createStaticHandler('E:/AndroidStudioProjects/custom_search_page/docs',
      defaultDocument: 'index.html');

  final handler = (Request request) {
    // 在这里可以添加其他自定义路由逻辑
    return staticHandler(request);
  };

  final server = await serve(handler, InternetAddress.anyIPv4, 8080);
  print('Local server running on ${server.address}:${server.port}');
}
