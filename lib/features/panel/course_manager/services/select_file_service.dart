import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbschool/common/widgets/bottom_bar.dart';
import 'package:mbschool/constants/error_handling.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/account/screens/account_screen.dart';
import 'package:mbschool/features/auth/screens/auth_screen.dart';
import 'package:mbschool/features/panel/course_manager/screens/plan_screen.dart';
import 'package:mbschool/models/user.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectFileService {
  // EDIT USER PROFILE

  void createLesson(
      BuildContext context,
      String titre,
      String resume,
      String id_cours,
      int id_section,
      int id_type_lecon,
      PlatformFile fichier,
      VoidCallback onSuccess) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dshli1qgh', 'lffwqjlm');
      String url;
      CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(fichier.path!, folder: titre.toLowerCase()));
      url = res.secureUrl;

      http.Response resCreateLesson =
          await http.post(Uri.parse("$uri/createLesson"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token
              },
              body: jsonEncode({
                'titre': titre,
                'resume': resume,
                'id_cours': int.parse(id_cours),
                'id_section': id_section,
                'id_type_lecon': id_type_lecon,
                'url': url
              }));

      var response = jsonDecode(resCreateLesson.body);
      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse("$uri/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
        );

        httpErrorHandle(
            response: userRes,
            context: context,
            onSuccess: () {
              // Provider.of<UserProvider>(context, listen: false)
              //     .setUser(userRes.body);
              onSuccess();
              
            },
            onFailed: () {});
      }
      onSuccess();
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
