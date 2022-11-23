import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbschool/common/widgets/custom_textfield_exigence.dart';
import 'package:mbschool/constants/error_handling.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/datas/user_profile.dart';
import 'package:mbschool/features/panel/course_manager/screens/course_manager_screen.dart';
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/exigence.dart';
import 'package:mbschool/models/langue.dart';
import 'package:mbschool/models/niveau.dart';
import 'package:mbschool/models/resultat.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultatService {
  void addResultat(BuildContext context, String titre, Cours cours,
      VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resAddResultat =
          await http.post(Uri.parse('$uri/addResultat'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({'titre': titre, 'id_cours': cours.id_cours}));

      httpErrorHandle(
          response: resAddResultat,
          context: context,
          onSuccess: onSuccess,
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Resultat>> getAllResultats(
      BuildContext context, Cours cours) async {
    List<Resultat> resultatList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response resultatRes = await http.get(
        Uri.parse('$uri/getAllResultats/${cours.id_cours}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: resultatRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(resultatRes.body).length; i++) {
              resultatList.add(
                Resultat.fromJson(
                  jsonEncode(
                    jsonDecode(resultatRes.body)[i],
                  ),
                ),
              );
            }
          },
          onFailed: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return resultatList;
  }


   void deleteResultat(BuildContext context,  Resultat exigence,
      VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resAddResultat =
          await http.post(Uri.parse('$uri/deleteResultat'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({'id_resultat': exigence.id_resultat}));

      httpErrorHandle(
          response: resAddResultat,
          context: context,
          onSuccess: onSuccess,
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
