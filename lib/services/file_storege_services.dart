import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_storeged/model/models.dart';
import 'package:flutter_storeged/services/local_storege_services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileStoregeServices implements LocalStorageServices {
  _getFilePath() async {
    var filePath = await getApplicationDocumentsDirectory();
    return filePath.path;
  }

  FileStoregeServices() {
    _createFile();
  }
  Future<File> _createFile() async {
    var file = File(await _getFilePath() + '/info.json');
    return file;
  }

  @override
  Future<void> saveData(UserInformation userInformation) async {
    var file = await _createFile();
    await file.writeAsString(jsonEncode(userInformation));
  }

  @override
  Future<UserInformation> readData() async {
    try {
      var file = await _createFile();
      var fileString = await file.readAsString();
      var json = jsonDecode(fileString);
      return UserInformation.fromJson(json);
    } catch (e) {
      debugPrint(e.toString());
    }
    return UserInformation('', Cinsiyet.ERKEK, [], false);
  }
}
