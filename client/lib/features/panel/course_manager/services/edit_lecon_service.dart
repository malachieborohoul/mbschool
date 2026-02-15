import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbschool/constants/error_handling.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';

import 'package:mbschool/models/lecon.dart';
import 'package:mbschool/providers/lecon_provider.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

class EditLeconService {
  // EDIT USER PROFILE

  void editLecon(
      BuildContext context,
      Lecon lecon,
      String titre,
      String resume,
      String id_cours,
      int id_section,
      PlatformFile fichier,
      VoidCallback onSuccess) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final leconProvider =
        Provider.of<LeconProvider>(context, listen: false).lecon;
    final cloudinary = CloudinaryPublic('dshli1qgh', 'lffwqjlm');
    String url;
    try {
      if (fichier != null) {
        url = leconProvider.url;
      } else {
        CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(fichier.path!,
                folder: titre.toLowerCase()));
        url = res.secureUrl;
      }

      http.Response resCreateLesson = await http.post(
        Uri.parse("$uri/editLecon"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode(
          {
            'id_lecon': int.parse(lecon.id_lecon),
            'titre': titre,
            'resume': resume,
            'id_cours': int.parse(id_cours),
            'id_section': id_section,
            'url': url
          },
        ),
      );

     httpErrorHandle(
          response: resCreateLesson,
          context: context,
          onSuccess: () {
            Provider.of<LeconProvider>(context, listen: false).setLecon(resCreateLesson.body);
            onSuccess();
          },
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


    // DELETE LECOn

  void deleteLecon(BuildContext context, Lecon lecon,
      VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resDelete = await http.post(
        Uri.parse('$uri/deleteLecon'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id_lecon': int.parse(lecon.id_lecon),
          },
        ),
      );

      httpErrorHandle(
          response: resDelete,
          context: context,
          onSuccess: () {
            
            onSuccess();
          },
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
