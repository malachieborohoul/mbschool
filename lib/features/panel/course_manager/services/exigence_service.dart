import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbschool/constants/error_handling.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';

import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/exigence.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ExigenceService {
  void addExigence(BuildContext context, String nom, Cours cours,
      VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resAddExigence =
          await http.post(Uri.parse('$uri/addExigence'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({'nom': nom, 'id_cours': cours.id_cours}));

      httpErrorHandle(
          response: resAddExigence,
          context: context,
          onSuccess: onSuccess,
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Exigence>> getAllExigences(
      BuildContext context, Cours cours) async {
    List<Exigence> exigenceList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response exigenceRes = await http.get(
        Uri.parse('$uri/getAllExigences/${cours.id_cours}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: exigenceRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(exigenceRes.body).length; i++) {
              exigenceList.add(
                Exigence.fromJson(
                  jsonEncode(
                    jsonDecode(exigenceRes.body)[i],
                  ),
                ),
              );
            }
          },
          onFailed: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return exigenceList;
  }


   void deleteExigence(BuildContext context,  Exigence exigence,
      VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resAddExigence =
          await http.post(Uri.parse('$uri/deleteExigence'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({'id_exigence': exigence.id_exigence}));

      httpErrorHandle(
          response: resAddExigence,
          context: context,
          onSuccess: onSuccess,
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
