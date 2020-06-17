import 'dart:io';

import 'package:path_provider/path_provider.dart';

class MyStorage {
  final String settingsFilename = "settings.json";

  // GET DIRECTORY PATH
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // GET FILE
  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/$settingsFilename');
  }

  // READ FILE
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

  // WRITE
  Future<File> writeContent(String content) async {
    final file = await localFile;
    return file.writeAsString('$content');
  }

  Future<FileSystemEntity> removeUserSettingsFile() async {
    final file = await localFile;
    return file.delete();
  }

  Future<bool> settingsFileExists() async {
    File settingsFile = await localFile;
    if (await settingsFile.exists()) {
      return true;
    }
    return false;
  }
}