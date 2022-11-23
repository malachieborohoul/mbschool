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
import 'package:mbschool/models/langue.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/langue.dart';
import 'package:mbschool/models/langue.dart';
import 'package:mbschool/models/niveau.dart';
import 'package:mbschool/models/langue.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangueService {
  void addLangue(
      BuildContext context, String nom, VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resaddLangue =
          await http.post(Uri.parse('$uri/addLangue'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({
                'nom': nom,
              }));

      httpErrorHandle(
          response: resaddLangue,
          context: context,
          onSuccess: onSuccess,
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void deleteLangue(
      BuildContext context, Langue langue, VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resaddLangue =
          await http.post(Uri.parse('$uri/deleteLangue'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({'id_langue': langue.id_langue}));

      httpErrorHandle(
          response: resaddLangue,
          context: context,
          onSuccess: onSuccess,
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  
  void editLangue(BuildContext context, Langue langue, String nom,
      VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resaddLangue = await http.post(
        Uri.parse('$uri/editLangue'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id_langue': langue.id_langue,
            'nom': nom,
          },
        ),
      );

      httpErrorHandle(
          response: resaddLangue,
          context: context,
          onSuccess: onSuccess,
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
