import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FileUploadService {
  static Future<File?> getFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null || result.files.isEmpty) {
      // User canceled the picker
      return null;
    }

    return File(result.files.single.path!);
  }
}