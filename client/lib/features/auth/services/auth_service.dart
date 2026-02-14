import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbschool/common/widgets/bottom_bar.dart';
import 'package:mbschool/constants/error_handling.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/auth/screens/auth_screen.dart';
import 'package:mbschool/features/intro/screens/verification_screen.dart';
import 'package:mbschool/models/user.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // SIGNUP USER
  void signUpUser({
    required BuildContext context,
    required String name,
    required String prenom,
    required String email,
    required String password,
    required VoidCallback onSuccess,
  }) async {
    try {
      User user = User(
        id: "",
        nom: name,
        prenom: prenom,
        email: email,
        password: password,
        role: '',
        photo: '',
        sexe: '',
        localisation: '',
        qualification: '',
        numCompte: '',
        cv: '',
        token: '',
        telephone: '',
        verify_code: '',
        statut_users: '',
      );
      http.Response res = await http.post(
          Uri.parse(
            '$uri/api/signup',
          ),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            onSuccess();
            showSnackBar(context, "Code envoyé");
            Navigator.pushNamedAndRemoveUntil(
                context, VerificationScreen.routeName, (route) => false);

            // showSnackBar(context, "Votre compte a été créé avec success");
          },
          onFailed: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser(
      {required BuildContext context,
      required String email,
      required String password,
      required VoidCallback onSuccess,
      required VoidCallback onFailed}) async {
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/signin"),
          body: jsonEncode({
            "email": email,
            "password": password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            onSuccess();
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          },
          onFailed: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<User> getUserData(BuildContext context) async {
    User user = User(
        id: "",
        nom: "",
        prenom: "",
        email: "",
        password: "",
        role: "",
        photo: "",
        sexe: "",
        localisation: "",
        telephone: "",
        qualification: "",
        numCompte: "",
        cv: "",
        token: "",
        verify_code: "",
        statut_users: '');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      // print("token $token");
      if (token != null) {
        var tokenRes = await http.post(Uri.parse("$uri/tokenIsValid"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });

        var response = jsonDecode(tokenRes.body);

        if (response == true) {
          http.Response userRes = await http.get(Uri.parse("$uri/"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': token
              });
          await Future.delayed(Duration(seconds: 3));

          Provider.of<UserProvider>(context, listen: false)
              .setUser(userRes.body);
          user = jsonDecode(userRes.body);
        }
      }

      await Future.delayed(Duration(seconds: 3));
      //  Provider.of<UserProvider>(context, listen: false).setUser(jsonEncode({
      //   "id": "",
      //   "nom": "",
      //   "prenom": "",
      //   "email": "",
      //   "password": "",
      //   "role": "",
      //   "photo": "",
      //   "sexe": "",
      //   "localisation": "",
      //   "telephone": "",
      //   "qualification": "",
      //   "numCompte": "",
      //   "cv": "",
      //   "token": "",
      //   "verify_code": ""
      // }));
    } catch (e) {
      // showSnackBar(context, e.toString());
    }
    return user;
  }

  // LOGOUT USER

  void logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');
    Navigator.pushNamedAndRemoveUntil(
        context, AuthScreen.routeName, (route) => false);
  }

  // EDIT USER PROFILE

  void editUserProfile(
      BuildContext context, String name, PlatformFile image) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('denfgaxvg', 'uszbstnu');
      String imageUrl;
      CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path!, folder: name.toLowerCase()));
      imageUrl = res.secureUrl;

      http.post(Uri.parse("$uri/api/editUserProfile"),
          body: jsonEncode(
              {'id': userProvider.user.id, 'name': name, 'image': imageUrl}));
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Code verification
  void codeVerification(
      {required BuildContext context,
      required String codeVerification,
      required VoidCallback onSuccess}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.post(
          Uri.parse(
            '$uri/codeVerification',
          ),
          body: jsonEncode({"id": userProvider.user.id}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
            // showSnackBar(context, "Votre compte a été créé avec success");
          },
          onFailed: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //Resend code
  void resendCode({
    required BuildContext context,
    
    required String email,
    required VoidCallback onSuccess,
  }) async {
    try {
      User user = User(
        id: "",
        nom: "",
        prenom: "",
        email: email,
        password: "",
        role: '',
        photo: '',
        sexe: '',
        localisation: '',
        qualification: '',
        numCompte: '',
        cv: '',
        token: '',
        telephone: '',
        verify_code: '',
        statut_users: '',
      );
      http.Response res = await http.post(
          Uri.parse(
            '$uri/resendCode',
          ),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            onSuccess();
            showSnackBar(context, "Code envoyé");
            Navigator.pushNamedAndRemoveUntil(
                context, VerificationScreen.routeName, (route) => false);

            // showSnackBar(context, "Votre compte a été créé avec success");
          },
          onFailed: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
