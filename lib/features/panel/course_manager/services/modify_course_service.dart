import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbschool/constants/error_handling.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/datas/user_profile.dart';
import 'package:mbschool/features/panel/course_manager/screens/course_manager_screen.dart';
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/langue.dart';
import 'package:mbschool/models/niveau.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModifyCourseService {
  void modifyCourseNewVignette(
      BuildContext context,
      String titre,
      String description,
      String description_courte,
      int categorie,
      int niveau,
      int langue,
      String prix,
      PlatformFile vignette,
      Cours cours,
      VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final cloudinary = CloudinaryPublic('dshli1qgh', 'lffwqjlm');
      String url;
      CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(vignette.path!, folder: titre.toLowerCase()));
      url = res.secureUrl;
      http.Response resModifyCourse =
          await http.post(Uri.parse('$uri/modifyCourse'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({
                'titre': titre,
                'description': description,
                'description_courte': description_courte,
                'id_categorie': categorie,
                'id_niveau': niveau,
                'id_langue': langue,
                'id_users': int.parse(userProvider.user.id),
                'prix': prix,
                'vignette': url,
                'id_cours': int.parse(cours.id_cours)
              }));

      httpErrorHandle(
          response: resModifyCourse,
          context: context,
          onSuccess: onSuccess,
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void modifyCourseOldVignette(
      BuildContext context,
      String titre,
      String description,
      String description_courte,
      int categorie,
      int niveau,
      int langue,
      String prix,
      String vignette,
      Cours cours,
      VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response resModifyCourse =
          await http.post(Uri.parse('$uri/modifyCourse'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({
                'titre': titre,
                'description': description,
                'description_courte': description_courte,
                'id_categorie': categorie,
                'id_niveau': niveau,
                'id_langue': langue,
                'id_users': int.parse(userProvider.user.id),
                'prix': prix,
                'vignette': vignette,
                'id_cours': int.parse(cours.id_cours)
              }));

      httpErrorHandle(
          response: resModifyCourse,
          context: context,
          onSuccess: onSuccess,
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
