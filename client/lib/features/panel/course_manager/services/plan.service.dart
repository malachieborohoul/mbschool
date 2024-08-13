import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbschool/constants/error_handling.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

class PlanService {
  void addSection(BuildContext context, String titreSection, Cours cours,
      VoidCallback onSuccess) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/addSection'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'titre': titreSection,
          'id_cours': double.parse(cours.id_cours),
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
         
            showSnackBar(context, "La section a été ajoutée avec succès");

            onSuccess();
          },
          onFailed: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
