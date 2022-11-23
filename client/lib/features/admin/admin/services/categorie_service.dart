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
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/models/langue.dart';
import 'package:mbschool/models/niveau.dart';
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategorieService {
  void addCategorie(
      BuildContext context, String nom, VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resaddCategorie =
          await http.post(Uri.parse('$uri/addCategorie'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({
                'nom': nom,
              }));

      httpErrorHandle(
          response: resaddCategorie,
          context: context,
          onSuccess: onSuccess,
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void deleteCategorie(
      BuildContext context, Categorie categorie, VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resaddCategorie =
          await http.post(Uri.parse('$uri/deleteCategorie'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({'id_categorie': categorie.id_categorie}));

      httpErrorHandle(
          response: resaddCategorie,
          context: context,
          onSuccess: onSuccess,
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void modifyCategorie(BuildContext context, Categorie categorie, String nom,
      VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resaddCategorie = await http.post(
        Uri.parse('$uri/deleteCategorie'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id_categorie': categorie.id_categorie,
            'nom': nom,
          },
        ),
      );

      httpErrorHandle(
          response: resaddCategorie,
          context: context,
          onSuccess: onSuccess,
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void editCategorie(BuildContext context, Categorie categorie, String nom,
      VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resaddCategorie = await http.post(
        Uri.parse('$uri/editCategorie'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id_categorie': categorie.id_categorie,
            'nom': nom,
          },
        ),
      );

      httpErrorHandle(
          response: resaddCategorie,
          context: context,
          onSuccess: onSuccess,
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
