import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbschool/constants/error_handling.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/auth/screens/auth_screen.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountService {
  // LOGOUT USER

  void logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');
    Navigator.pushNamedAndRemoveUntil(
        context, AuthScreen.routeName, (route) => false);
  }

  // EDIT USER PROFILE

  void editUserProfile(
      BuildContext context,
      String name,
      String prenom,
      String phone,
      String sexe,
      String localisation,
      PlatformFile image,
      VoidCallback onSuccess) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dshli1qgh', 'lffwqjlm');
      String imageUrl;
      CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path!, folder: name.toLowerCase()));
      imageUrl = res.secureUrl;

      http.Response resEdit =
          await http.post(Uri.parse("$uri/api/editUserProfile"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token
              },
              body: jsonEncode({
                'nom': name,
                'photo': imageUrl,
                'prenom': prenom,
                'telephone': phone,
                'sexe': sexe,
                'localisation': localisation
              }));

      var response = jsonDecode(resEdit.body);
      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse("$uri/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
        );

        httpErrorHandle(
            response: userRes,
            context: context,
            onSuccess: () {
              Provider.of<UserProvider>(context, listen: false)
                  .setUser(userRes.body);
              onSuccess();

              showSnackBar(context, "Profil modifié");
            },
            onFailed: () {});
      }
      onSuccess();
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}