import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbschool/constants/error_handling.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';

import 'package:mbschool/models/user.dart';
import 'package:mbschool/providers/search_user_provider.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UsersManagerService {
  // MODIFY USERS

  void modifyRole(
      BuildContext context, User user, int role, VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resModify = await http.post(
        Uri.parse('$uri/modifyRole'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'role': role,
            'id_users': int.parse(user.id),
          },
        ),
      );

      httpErrorHandle(
          response: resModify,
          context: context,
          onSuccess: () {
            onSuccess();
          },
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void activateUser(
      BuildContext context, User user, VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resModify = await http.post(
        Uri.parse('$uri/activateUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id_users': int.parse(user.id),
          },
        ),
      );

      httpErrorHandle(
          response: resModify,
          context: context,
          onSuccess: () {
            Provider.of<SearchUserProvider>(context, listen: false)
                .setUser(resModify.body);

            onSuccess();
          },
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void desactivateUser(
      BuildContext context, User user, VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resModify = await http.post(
        Uri.parse('$uri/desactivateUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id_users': int.parse(user.id),
          },
        ),
      );

      httpErrorHandle(
          response: resModify,
          context: context,
          onSuccess: () {
            Provider.of<SearchUserProvider>(context, listen: false)
                .setUser(resModify.body);

            onSuccess();
          },
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void deleteUser(
      BuildContext context, User user, VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resModify = await http.post(
        Uri.parse('$uri/deleteUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id_users': int.parse(user.id),
          },
        ),
      );

      httpErrorHandle(
          response: resModify,
          context: context,
          onSuccess: () {
            // Provider.of<SearchUserProvider>(context, listen: false)
            //     .setUser(resModify.body);

            onSuccess();
          },
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
