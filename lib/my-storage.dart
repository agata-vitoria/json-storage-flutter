import 'dart:io';

import 'package:path_provider/path_provider.dart';

class MyStorage {
  final String settingsFilename = "settings.json";

  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/$settingsFilename');
  }

  Future<String> readContent() async {
    String contents;

    try {
      final file = await localFile;
      contents = await file.readAsString();
    } catch (e) {
      print(e);
    }

    return contents;
  }

  Future<File> writeContent(String content) async {
    final file = await localFile;
    return file.writeAsString('$content');
  }
}
