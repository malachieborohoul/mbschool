import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbschool/core/constants/error_handling.dart';
import 'package:mbschool/core/constants/global.dart';
import 'package:mbschool/core/constants/utils.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SelectFileService {
  // EDIT USER PROFILE

  void createLesson(
      BuildContext context,
      String titre,
      String resume,
      String idCours,
      int idSection,
      int idTypeLecon,
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
                'idCours': int.parse(idCours),
                'idSection': idSection,
                'idTypeLecon': idTypeLecon,
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

   void createLessonLinkYoutube(
      BuildContext context,
      String titre,
      String resume,
      String idCours,
      int idSection,
      int idTypeLecon,
      String lienYoutube,
      VoidCallback onSuccess) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      

      http.Response resCreateLesson =
          await http.post(Uri.parse("$uri/createLesson"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token
              },
              body: jsonEncode({
                'titre': titre,
                'resume': resume,
                'idCours': int.parse(idCours),
                'idSection': idSection,
                'idTypeLecon': idTypeLecon,
                'url': lienYoutube
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
