import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/custom_course_card.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/admin/users/screens/modify_role.dart';
import 'package:mbschool/features/admin/users/screens/users_screen.dart';
import 'package:mbschool/features/admin/users/services/users_manager_service.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/user.dart';
import 'package:mbschool/providers/search_user_provider.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  static const routeName = "user-details-screen";
  const UserDetailsScreen({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  CourseManagerService _courseManagerService = CourseManagerService();
  UsersManagerService _usersManagerService = UsersManagerService();
  List<Cours> courseTaking = [];
  List<Cours> courseTeaching = [];
  List<User> totalStudents = [];

  int role = 1;
  bool isCharging = false;
  late final searchUserProvider;

  @override
  void initState() {
    searchUserProvider =
        Provider.of<SearchUserProvider>(context, listen: false).user;
    getAllTakingCourses();
    getAllTeachingCourses();
    getTotalStudents();
    super.initState();
  }

  void getAllTakingCourses() async {
    courseTaking = await _courseManagerService.getAllTakingCourses(
        context, searchUserProvider);
    setState(() {});
  }

  void getAllTeachingCourses() async {
    courseTeaching = await _courseManagerService.getAllTeachingCourses(
        context, searchUserProvider);
    setState(() {});
  }

  void getTotalStudents() async {
    totalStudents = await _courseManagerService.getTotalStudents(
        context, searchUserProvider);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print(' stat ${searchUserProvider.statut_users}');

    void activateUser() {
      _usersManagerService.activateUser(context, searchUserProvider, () {
        setState(() {
          isCharging = false;
          Navigator.of(context)
            ..pop()
            ..pop()
            ..pop()
            ..pop()
            ..pushNamed(UserDetailsScreen.routeName,
                arguments: searchUserProvider);
          showSnackBar(context, "Utilisateur activé");
        });
      });
    }

    void desactivateUser() {
      _usersManagerService.desactivateUser(context, searchUserProvider, () {
        setState(() {
          isCharging = false;

          Navigator.of(context)
            ..pop()
            ..pop()
            ..pop()
            ..pushNamed(UserDetailsScreen.routeName,
                arguments: searchUserProvider);
          showSnackBar(context, "Utilisateur désactivé");
        });
      });
    }

    void deleteUser() {
      _usersManagerService.deleteUser(context, searchUserProvider, () {
        setState(() {
          isCharging = false;

          Navigator.of(context)
          ..pop()
          ..pop()
          ..pop()
          ..pushNamed(UsersScreen.routeName)
          ;
          showSnackBar(context, "Utilisateur supprimé");
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: textBlack,
        backgroundColor: textWhite,
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text("${searchUserProvider.nom} ${searchUserProvider.prenom}"),
        actions: [
          GestureDetector(
            child: PopupMenuButton(onSelected: (value) {
              if (value == 1) {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ModifyRole(
                        user: searchUserProvider,
                      );
                    });
              } else if (value == 2) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Notification"),
                          content: isCharging == true
                              ? Loader()
                              : Container(
                                  height: 90,
                                  child: Column(
                                    children: [
                                      searchUserProvider.statut_users == "0"
                                          ? Text(
                                              "Voulez vous activer l'utilisateur?",
                                              style: TextStyle(fontSize: 14),
                                            )
                                          : searchUserProvider.statut_users ==
                                                  "1"
                                              ? Text(
                                                  "Voulez vous désactiver l'utilisateur?",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                )
                                              : Container(),
                                      const SizedBox(
                                        height: appPadding,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                // Navigator.pop(context);
                                                setState(() {
                                                  // deleteCours();
                                                  if (searchUserProvider
                                                          .statut_users ==
                                                      "0") {
                                                    activateUser();
                                                  }
                                                  if (searchUserProvider
                                                          .statut_users ==
                                                      "1") {
                                                    desactivateUser();
                                                  }
                                                  isCharging = true;
                                                });
                                              },
                                              splashColor: Colors.grey.shade200,
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 40,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Text(
                                                  "Oui",
                                                  style: TextStyle(
                                                      color: textWhite),
                                                ),
                                              )),
                                          InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              splashColor: Colors.grey.shade200,
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 40,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Text(
                                                  "Non",
                                                  style: TextStyle(
                                                      color: textWhite),
                                                ),
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                        ));
              } else if (value == 3) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Notification"),
                          content: isCharging == true
                              ? Loader()
                              : Container(
                                  height: 90,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Voulez vous supprimer l'utilisateur?",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: appPadding,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                // Navigator.pop(context);
                                                setState(() {
                                                  deleteUser();

                                                  isCharging = true;
                                                });
                                              },
                                              splashColor: Colors.grey.shade200,
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 40,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Text(
                                                  "Oui",
                                                  style: TextStyle(
                                                      color: textWhite),
                                                ),
                                              )),
                                          InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              splashColor: Colors.grey.shade200,
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 40,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Text(
                                                  "Non",
                                                  style: TextStyle(
                                                      color: textWhite),
                                                ),
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                        ));
              }
            }, itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 1,
                  child: Text("Modifier rôle"),
                  onTap: () {},
                ),
                PopupMenuItem(
                  value: 2,
                  child: searchUserProvider.statut_users == "0"
                      ? Text("Activer l'utilisateur")
                      : searchUserProvider.statut_users == "1"
                          ? Text("Désactiver l'utilisateur")
                          : Text(""),
                  onTap: () {},
                ),
                PopupMenuItem(
                  value: 3,
                  child: Text("Supprimer l'utilisateur"),
                  onTap: () {},
                ),
              ];
            }),
          )
        ],
      ),
      body: courseTaking == null ||
              courseTeaching == null ||
              totalStudents == null
          ? Loader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: Image.network(searchUserProvider.photo),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(appPadding),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cours suivis",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              Text("${courseTaking.length}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                            ],
                          ),
                          Divider(
                            thickness: 0.8,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cours enseignés",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              Text("${courseTeaching.length}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                            ],
                          ),
                          Divider(
                            thickness: 0.8,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Etudiants enrôlés",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              Text("${totalStudents.length}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                            ],
                          ),
                          SizedBox(
                            height: appPadding,
                          ),
                          Text(
                            "Cours suivis:",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          for (int i = 0; i < courseTaking.length; i++)
                            CustomCourseCardShrink(
                                thumbNail: courseTaking[i].vignette,
                                title: courseTaking[i].titre,
                                nom: courseTaking[i].nom,
                                prenom: courseTaking[i].prenom,
                                price: courseTaking[i].prix),
                          SizedBox(
                            height: appPadding,
                          ),
                          Text(
                            "Cours enseignés:",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          for (int i = 0; i < courseTeaching.length; i++)
                            CustomCourseCardShrink(
                                thumbNail: courseTeaching[i].vignette,
                                title: courseTeaching[i].titre,
                                nom: courseTeaching[i].nom,
                                prenom: courseTeaching[i].prenom,
                                price: courseTeaching[i].prix)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
