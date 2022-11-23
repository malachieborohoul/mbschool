import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String assetImg = 'assets/images/';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(text)));
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}

// Future pickImage() async {
//   File image;

//   try {
//     FilePickerResult? file = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//     );
//     if (file != null && file.files.isNotEmpty) {
//       image = File(file.files.single.path!);
//     }
    
//   } catch (e) {
//     debugPrint(e.toString());
//   }
//   return image;
// }
