import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbschool/constants/error_handling.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/enseignant_cours.dart';
import 'package:mbschool/models/lecon.dart';
import 'package:mbschool/models/section.dart';
import 'package:mbschool/models/user.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CourseManagerService {
  Future<List<Cours>> getAllCourses(BuildContext context) async {
    List<Cours> coursList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response coursRes = await http.get(
        Uri.parse('$uri/getAllCourses'),
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

  Future<List<Cours>> getAllPublishedCourses(BuildContext context) async {
    List<Cours> coursList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response coursRes = await http.get(
        Uri.parse('$uri/getAllPublishedCourses'),
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

  Future<List<Cours>> getAllCoursesTeacher(BuildContext context) async {
    List<Cours> coursList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response coursRes = await http.get(
        Uri.parse(
            '$uri/getAllCoursesTeacher/${int.parse(userProvider.user.id)}'),
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

  Future<List<Section>> getAllSections(
      BuildContext context, Cours cours) async {
    List<Section> sectionList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response sectionRes = await http.get(
        Uri.parse('$uri/getAllSections/${cours.id_cours}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: sectionRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(sectionRes.body).length; i++) {
              sectionList.add(
                Section.fromJson(
                  jsonEncode(
                    jsonDecode(sectionRes.body)[i],
                  ),
                ),
              );
            }
          },
          onFailed: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return sectionList;
  }

  Future<List<Lecon>> getAllLecons(
      BuildContext context, Section section) async {
    List<Lecon> leconList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response leconRes = await http.get(
        Uri.parse(
            '$uri/getAllLecons/${section.id_cours}/${section.id_section}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: leconRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(leconRes.body).length; i++) {
              leconList.add(
                Lecon.fromJson(
                  jsonEncode(
                    jsonDecode(leconRes.body)[i],
                  ),
                ),
              );
            }
          },
          onFailed: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return leconList;
  }

  Future<List<Cours>> getAllCoursesByCategory(
      BuildContext context, Categorie categorie) async {
    List<Cours> coursList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response coursRes = await http.get(
        Uri.parse('$uri/getAllCoursesByCategory/${categorie.id_categorie}'),
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

  Future<List<EnseignantCours>> getAllEnseignantPopulaire(
      BuildContext context) async {
    List<EnseignantCours> enseignantPopList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response enseignantPopRes = await http.get(
        Uri.parse('$uri/getAllEnseignantPopulaire'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: enseignantPopRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(enseignantPopRes.body).length; i++) {
              enseignantPopList.add(EnseignantCours.fromJson(
                jsonEncode(
                  jsonDecode(enseignantPopRes.body)[i],
                ),
              ));
            }
          },
          onFailed: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return enseignantPopList;
  }

  void addCourseToFavorite(
      BuildContext context, Cours cours, VoidCallback success) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response resFavorite = await http.post(
        Uri.parse(
          '$uri/addCourseToFavorite',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            "id_users": int.parse(userProvider.user.id),
            "id_cours": int.parse(cours.id_cours),
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

  void removeCoursToFavorite(
      BuildContext context, Cours cours, VoidCallback success) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response resFavorite = await http.post(
        Uri.parse(
          '$uri/removeCoursToFavorite',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            "id_users": int.parse(userProvider.user.id),
            "id_cours": int.parse(cours.id_cours),
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

  Future<bool> isCourseInFavorite(BuildContext context, Cours cours) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    late bool isCourseInFavorite;

    try {
      http.Response resIsFav =
          await http.post(Uri.parse("$uri/isCourseInFavorite"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({
                "id_users": int.parse(userProvider.user.id),
                "id_cours": int.parse(cours.id_cours)
              }));

      httpErrorHandle(
        response: resIsFav,
        context: context,
        onSuccess: () {
          isCourseInFavorite = jsonDecode(resIsFav.body);
        },
        onFailed: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return isCourseInFavorite;
  }

  void markLessonAsDone(
      BuildContext context, Lecon lecon, VoidCallback success) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response resFavorite = await http.post(
        Uri.parse(
          '$uri/markLessonAsDone',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            "id_users": int.parse(userProvider.user.id),
            "id_lecon": int.parse(lecon.id_lecon),
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

  Future<bool> isLeconDone(BuildContext context, Lecon lecon) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    late bool isLeconDone;

    try {
      http.Response resIsDone = await http.post(Uri.parse("$uri/isLeconDone"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            "users_id": int.parse(userProvider.user.id),
            "lecon_id": int.parse(lecon.id_lecon)
          }));

      httpErrorHandle(
        response: resIsDone,
        context: context,
        onSuccess: () {
          isLeconDone = jsonDecode(resIsDone.body);
        },
        onFailed: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return isLeconDone;
  }

  Future<String> getNumberLeconCours(BuildContext context, Cours cours) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    late String numberLecon;

    try {
      http.Response numLeconRes =
          await http.post(Uri.parse("$uri/getNumberLeconCours"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({"cours_id": int.parse(cours.id_cours)}));

      httpErrorHandle(
        response: numLeconRes,
        context: context,
        onSuccess: () {
          numberLecon = jsonDecode(numLeconRes.body);
        },
        onFailed: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return numberLecon;
  }

  Future<String> getNumberLeconCoursDone(
      BuildContext context, Cours cours) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    late String numberLeconDone;

    try {
      http.Response numLeconDoneRes =
          await http.post(Uri.parse("$uri/getNumberLeconCoursDone"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({
                "cours_id": int.parse(cours.id_cours),
                "users_id": int.parse(userProvider.user.id),
              }));

      httpErrorHandle(
        response: numLeconDoneRes,
        context: context,
        onSuccess: () {
          numberLeconDone = jsonDecode(numLeconDoneRes.body);
        },
        onFailed: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return numberLeconDone;
  }

  Future<List<Lecon>> getTotalLecons(BuildContext context, Cours cours) async {
    List<Lecon> leconTotalList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response leconRes = await http.get(
        Uri.parse('$uri/getTotalLecons/${int.parse(cours.id_cours)}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: leconRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(leconRes.body).length; i++) {
              leconTotalList.add(
                Lecon.fromJson(
                  jsonEncode(
                    jsonDecode(leconRes.body)[i],
                  ),
                ),
              );
            }
          },
          onFailed: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return leconTotalList;
  }

  // DELETE COURS

  void deleteCours(
      BuildContext context, Cours cours, VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resDelete = await http.post(
        Uri.parse('$uri/deleteCours'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id_cours': int.parse(cours.id_cours),
          },
        ),
      );

      httpErrorHandle(
          response: resDelete,
          context: context,
          onSuccess: () {
            onSuccess();
          },
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // PUBLISH COURS

  void publishCours(
      BuildContext context, Cours cours, VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response resDelete = await http.post(
        Uri.parse('$uri/publishCours'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id_cours': int.parse(cours.id_cours),
          },
        ),
      );

      httpErrorHandle(
          response: resDelete,
          context: context,
          onSuccess: () {
            onSuccess();
          },
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void deactivateCours(
      BuildContext context, Cours cours, VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resDelete = await http.post(
        Uri.parse('$uri/deactivateCours'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id_cours': int.parse(cours.id_cours),
          },
        ),
      );

      httpErrorHandle(
          response: resDelete,
          context: context,
          onSuccess: () {
            onSuccess();
          },
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<bool> verifyCourseHasExigence(
      BuildContext context, Cours cours) async {
    bool? isCourseHasExigence;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response usersRes = await http.get(
        Uri.parse('$uri/verifyCourseHasExigence/${cours.id_cours}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: usersRes,
          context: context,
          onSuccess: () {
            isCourseHasExigence = jsonDecode(usersRes.body);
          },
          onFailed: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return isCourseHasExigence!;
  }

    Future<bool> verifyCourseHasResultat(
      BuildContext context, Cours cours) async {
    bool? isCourseHasResultat;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response usersRes = await http.get(
        Uri.parse('$uri/verifyCourseHasResultat/${cours.id_cours}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: usersRes,
          context: context,
          onSuccess: () {
            isCourseHasResultat = jsonDecode(usersRes.body);
          },
          onFailed: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return isCourseHasResultat!;
  }

  Future<List<User>> getAllUsers(BuildContext context) async {
    List<User> usersList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response usersRes = await http.get(
        Uri.parse('$uri/getAllUsers'),
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

  Future<List<Cours>> getAllTakingCourses(
      BuildContext context, User user) async {
    List<Cours> coursList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response coursRes = await http.get(
        Uri.parse('$uri/getAllTakingCourses/${user.id}'),
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

  Future<List<Cours>> getAllTeachingCourses(
      BuildContext context, User user) async {
    List<Cours> coursList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response coursRes = await http.get(
        Uri.parse('$uri/getAllTeachingCourses/${user.id}'),
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

  Future<List<User>> getTotalStudents(BuildContext context, User user) async {
    List<User> usersList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response usersRes = await http.get(
        Uri.parse('$uri/getTotalStudents/${user.id}'),
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
