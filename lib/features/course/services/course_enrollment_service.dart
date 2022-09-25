import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mbschool/constants/error_handling.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CourseEnrollmentService {
  void enrollToCourse(
      BuildContext context, Cours cours, VoidCallback success) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response resEnroll = await http.post(
        Uri.parse(
          '$uri/enrollToCourse',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            "users_id": int.parse(userProvider.user.id),
            "cours_id": int.parse(cours.id_cours),
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

  Future<bool> isCourseEnrolled(BuildContext context, Cours cours) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    late bool isCourseEnrolled;

    try {
      http.Response resIsEnrolled =
          await http.post(Uri.parse("$uri/isCourseEnrolled"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({
                "users_id": int.parse(userProvider.user.id),
                "cours_id": int.parse(cours.id_cours)
              }));

      httpErrorHandle(
        response: resIsEnrolled,
        context: context,
        onSuccess: () {
          isCourseEnrolled = jsonDecode(resIsEnrolled.body);
        },
        onFailed: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return isCourseEnrolled;
  }

  Future<List<Cours>> getAllEnrolledCourses(BuildContext context) async {
    List<Cours> coursList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response coursRes = await http.get(
        Uri.parse('$uri/getAllEnrolledCourses/${userProvider.user.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: coursRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(coursRes.body).length; i++) {
              coursList.add(
                Cours.fromJson(
                  jsonEncode(
                    jsonDecode(coursRes.body)[i],
                  ),
                ),
              );
            }
          },
          onFailed: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return coursList;
  }
}
