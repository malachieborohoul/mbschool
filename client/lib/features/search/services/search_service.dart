import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mbschool/constants/error_handling.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/user.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class SearchService {
  Future<List<Cours>> searchCourses(BuildContext context, String titre) async {
    List<Cours> coursList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response coursRes = await http.get(
        Uri.parse('$uri/searchCourses/$titre'),
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

  Future<List<User>> searchUsers(BuildContext context, String nom) async {
    List<User> usersList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response usersRes = await http.get(
        Uri.parse('$uri/searchUsers/$nom'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: usersRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(usersRes.body).length; i++) {
              usersList.add(
                User.fromJson(
                  jsonEncode(
                    jsonDecode(usersRes.body)[i],
                  ),
                ),
              );
            }
          },
          onFailed: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return usersList;
  }
}
