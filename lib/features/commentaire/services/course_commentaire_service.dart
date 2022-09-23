import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mbschool/constants/error_handling.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/models/commentaire.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/lecon.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class CourseCommentaireService {

    void addLeconCommentaire(
      BuildContext context, String intitule, Lecon lecon, VoidCallback success) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response resFavorite = await http.post(
        Uri.parse(
          '$uri/addLeconCommentaire',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            "intitule": intitule,
            "users_id": int.parse(userProvider.user.id),
            "lecon_id": int.parse(lecon.id_lecon),
          },
        ),
      );

      httpErrorHandle(
          response: resFavorite,
          context: context,
          onSuccess: () {
            success();
          },
          onFailed: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //GEt all lesson commentaires
  Future<List<Commentaire>> getAllLessonCommentaires(BuildContext context) async {
    List<Commentaire> commentaireList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response commentaireRes = await http
          .get(Uri.parse("$uri/getAllLessonCommentaires"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
          response: commentaireRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(commentaireRes.body).length; i++) {
              commentaireList.add(
                Commentaire.fromJson(
                  jsonEncode(
                    jsonDecode(commentaireRes.body)[i],
                  ),
                ),
              );
            }
          },
          onFailed: () {});

      // Provider.of<LangueProvider>(context, listen: false).setLangue(langueRes.body);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return commentaireList;
  }


}
