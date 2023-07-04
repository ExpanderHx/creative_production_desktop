

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

import '../config/const_app.dart';

class Utils{

  static var uuid = Uuid();

  static Future<String?> fileCopy(String sourcePath,{String? secondaryDirectory}) async{

    secondaryDirectory ??=ConstApp.projectBackgroundImageNameKey;
    final dir = await getApplicationDocumentsDirectory();
    String projectImagePath = path.join(dir.path , ConstApp.projectNameKey, ConstApp.projectImageNameKey,secondaryDirectory);
    await Directory(projectImagePath).create(recursive: true);

    String fileExtension = path.extension(sourcePath);
    print('File extension: $fileExtension');

    String destinationPath = projectImagePath +  uuid.v4() + fileExtension ;

    File sourceFile = File(sourcePath);
    File destinationFile = File(destinationPath);

    try {
      // 复制文件
      sourceFile.copySync(destinationFile.path);
      print('File copied successfully');
      return destinationPath;
    } catch (e) {
      print('An error occurred while copying the file: $e');
    }
    return null;
  }

}