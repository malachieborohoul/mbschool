import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbschool/constants/error_handling.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/datas/user_profile.dart';
import 'package:mbschool/features/panel/course_manager/screens/course_manager_screen.dart';
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/models/langue.dart';
import 'package:mbschool/models/niveau.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateCourseService {
  Future<List<Langue>> getAllLangueData(BuildContext context) async {
    List<Langue> langueList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response langueRes = await http
          .get(Uri.parse("$uri/getAllLangueData"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
          response: langueRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(langueRes.body).length; i++) {
              langueList.add(
                Langue.fromJson(
                  jsonEncode(
                    jsonDecode(langueRes.body)[i],
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
    return langueList;
  }

  //get All Categories Data

  Future<List<Categorie>> getAllCategorieData(BuildContext context) async {
    List<Categorie> categorieList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response categorieRes = await http
          .get(Uri.parse("$uri/getAllCategorieData"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
          response: categorieRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(categorieRes.body).length; i++) {
              categorieList.add(
                Categorie.fromJson(
                  jsonEncode(
                    jsonDecode(categorieRes.body)[i],
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
    return categorieList;
  }

  //get All Categories Data

  Future<List<Niveau>> getAllNiveauData(BuildContext context) async {
    List<Niveau> niveauList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response niveauRes = await http
          .get(Uri.parse("$uri/getAllNiveauData"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
          response: niveauRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(niveauRes.body).length; i++) {
              niveauList.add(
                Niveau.fromJson(
                  jsonEncode(
                    jsonDecode(niveauRes.body)[i],
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
    return niveauList;
  }

  void createCourse(
      BuildContext context,
      String titre,
      String description,
      String description_courte,
      int categorie,
      int niveau,
      int langue,
      String prix,
      bool isChecked,
      PlatformFile vignette,
      VoidCallback onnSuccess) async {
    if (isChecked == true) {
      try {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final cloudinary = CloudinaryPublic('dshli1qgh', 'lffwqjlm');
        String url;
        CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(vignette.path!,
                folder: titre.toLowerCase()));
        url = res.secureUrl;
        http.Response resCreateCourse =
            await http.post(Uri.parse('$uri/createCourse'),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                  'x-auth-token': userProvider.user.token,
                },
                body: jsonEncode({
                  'titre': titre,
                  'description': description,
                  'description_courte': description_courte,
                  'id_categorie': categorie,
                  'id_niveau': niveau,
                  'id_langue': langue,
                  'id_users': int.parse(userProvider.user.id),
                  'vignette': url
                }));

        httpErrorHandle(
            response: resCreateCourse,
            context: context,
            onSuccess: () {
              onnSuccess();
            },
            onFailed: () {});
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }
  }
}
