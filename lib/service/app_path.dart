import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class AppPath {
  /// 电脑文档目录路径
  late final String _deviceDocPath;
  /// 根文件夹名称
  final String _rootName = "FakeBrowser";
  /// web网页文件夹名称
  final String _webName = "web";

  static AppPath? _instance;

  factory AppPath() {
    _instance ??= AppPath._internal();
    return _instance!;
  }

  AppPath._internal();

  Future<void> init() async {
    Directory deviceDocDir = await getApplicationDocumentsDirectory();
    _deviceDocPath = deviceDocDir.path;
    Directory appRootDir = Directory('$_deviceDocPath${Platform.pathSeparator}$_rootName');
    if (!appRootDir.existsSync()) {
      appRootDir.createSync();
    }
    Directory appWebDir = Directory('$_deviceDocPath${Platform.pathSeparator}$_rootName${Platform.pathSeparator}$_webName');
    if (!appWebDir.existsSync()) {
      appWebDir.createSync();
    }
  }

  String getWebFilePath() {
    return path.join(_deviceDocPath, _rootName, _webName);
  }

}
