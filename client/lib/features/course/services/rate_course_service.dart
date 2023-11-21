import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mbschool/constants/error_handling.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/notation_cours.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class RateCourseService {
  void rateCourse(
      BuildContext context, Cours cours,double rating,String testimonial , VoidCallback success) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response resEnroll = await http.post(
        Uri.parse(
          '$uri/rateCourse',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            "id_users": int.parse(userProvider.user.id),
            "id_cours": int.parse(cours.id_cours),
            "rating": rating,
            "testimonial": testimonial,
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

  Future<List<NotationCours>> getAllNotationCours(BuildContext context, Cours cours) async {
    List<NotationCours> notationList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response notationRes = await http.get(
        Uri.parse('$uri/getAllNotationCours/${int.parse(cours.id_cours)}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: notationRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(notationRes.body).length; i++) {
              notationList.add(
                NotationCours.fromJson(
                  jsonEncode(
                    jsonDecode(notationRes.body)[i],
                  ),
                ),
              );
            }
          },
          onFailed: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return notationList;
  }
}
