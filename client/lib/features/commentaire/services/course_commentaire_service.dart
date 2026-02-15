import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mbschool/constants/error_handling.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/models/commentaire.dart';
import 'package:mbschool/models/lecon.dart';
import 'package:mbschool/models/reponse_commentaire.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class CourseCommentaireService {
  void addLeconCommentaire(BuildContext context, String intitule, Lecon lecon,
      VoidCallback success) async {
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

  //add response to commentaire for a lesson
  void addLeconReponseCommentaire(BuildContext context, String intitule,
      Commentaire commentaire, VoidCallback success) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse(
          '$uri/addLeconReponseCommentaire',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            "intitule": intitule,
            "users_id": int.parse(userProvider.user.id),
            "commentaire_id": int.parse(commentaire.id_commentaire),
          },
        ),
      );

      httpErrorHandle(
          response: res,
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
  Future<List<Commentaire>> getAllLessonCommentaires(
      BuildContext context, Lecon lecon) async {
    List<Commentaire> commentaireList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response commentaireRes = await http.get(
          Uri.parse(
              "$uri/getAllLessonCommentaires/${int.parse(lecon.id_lecon)}"),
          headers: <String, String>{
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

  //GEt all lesson commentaires
  Future<String> getAllLessonNumberReponses(
      BuildContext context, Commentaire commentaire) async {
    String? numberReponse;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response commentaireRes = await http.get(
          Uri.parse(
              "$uri/getAllLessonNumberReponses/${int.parse(commentaire.id_commentaire)}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });

      httpErrorHandle(
          response: commentaireRes,
          context: context,
          onSuccess: () {
            numberReponse = jsonDecode(commentaireRes.body);
          },
          onFailed: () {});

      // Provider.of<LangueProvider>(context, listen: false).setLangue(langueRes.body);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return numberReponse!;
  }

  //GEt all lesson reponses commentaire
  Future<List<ReponseCommentaire>> getAllLessonReponseCommentaires(
      BuildContext context, Commentaire commentaire) async {
    List<ReponseCommentaire> reponseCommentaireList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response commentaireRes = await http.get(
          Uri.parse(
              "$uri/getAllLessonReponseCommentaires/${int.parse(commentaire.id_commentaire)}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });

      httpErrorHandle(
          response: commentaireRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(commentaireRes.body).length; i++) {
              reponseCommentaireList.add(
                ReponseCommentaire.fromJson(
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
    return reponseCommentaireList;
  }

  //GEt all lesson commentaires
  Future<String> countAllLessonReponseAndCommentaires(
      BuildContext context, Lecon lecon) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String number_discussions = "";
    try {
      http.Response commentaireRes = await http.get(
          Uri.parse(
              "$uri/countAllLessonReponseAndCommentaires/${int.parse(lecon.id_lecon)}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });

      httpErrorHandle(
          response: commentaireRes,
          context: context,
          onSuccess: () {
            number_discussions = jsonDecode(commentaireRes.body);
          },
          onFailed: () {});

      // Provider.of<LangueProvider>(context, listen: false).setLangue(langueRes.body);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return number_discussions;
  }

  void markLessonAsDone(
      BuildContext context, Lecon lecon, VoidCallback success) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response resEnroll = await http.post(
        Uri.parse(
          '$uri/markLessonAsDone',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            "users_id": int.parse(userProvider.user.id),
            "lecon_id": int.parse(lecon.id_lecon),
          },
        ),
      );

      httpErrorHandle(
          response: resEnroll,
          context: context,
          onSuccess: () {
            success();
          },
          onFailed: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
