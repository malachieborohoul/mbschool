import 'package:flutter/material.dart';

import 'package:mbschool/common/widgets/custom_course_card.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/datas/user_profile.dart';
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
  final CourseManagerService _courseManagerService = CourseManagerService();
  final UsersManagerService _usersManagerService = UsersManagerService();
  late Future<List<Cours>> courseTaking;
  late Future<List<Cours>> courseTeaching;
  late Future<List<User>> totalStudents;

  int role = 1;
  bool isCharging = false;
  late User searchUserProvider;

  @override
  void initState() {
    searchUserProvider =
        Provider.of<SearchUserProvider>(context, listen: false).user;
    getAllTakingCourses();
    getAllTeachingCourses();
    getTotalStudents();
    super.initState();
  }

  void getAllTakingCourses() {
    courseTaking =
        _courseManagerService.getAllTakingCourses(context, searchUserProvider);
    setState(() {});
  }

  void getAllTeachingCourses() {
    courseTeaching = _courseManagerService.getAllTeachingCourses(
        context, searchUserProvider);
    setState(() {});
  }

  void getTotalStudents() {
    totalStudents =
        _courseManagerService.getTotalStudents(context, searchUserProvider);
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
            ..pushNamed(UsersScreen.routeName);
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
                          title: const Text("Notification"),
                          content: isCharging == true
                              ? const Loader()
                              : SizedBox(
                                  height: 90,
                                  child: Column(
                                    children: [
                                      searchUserProvider.statut_users == "0"
                                          ? const Text(
                                              "Voulez vous activer l'utilisateur?",
                                              style: TextStyle(fontSize: 14),
                                            )
                                          : searchUserProvider.statut_users ==
                                                  "1"
                                              ? const Text(
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
                                                child: const Text(
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
                                                child: const Text(
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
                          title: const Text("Notification"),
                          content: isCharging == true
                              ? const Loader()
                              : SizedBox(
                                  height: 90,
                                  child: Column(
                                    children: [
                                      const Text(
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
                                                child: const Text(
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
                                                child: const Text(
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
                  child: const Text("Modifier rôle"),
                  onTap: () {},
                ),
                PopupMenuItem(
                  value: 2,
                  child: searchUserProvider.statut_users == "0"
                      ? const Text("Activer l'utilisateur")
                      : searchUserProvider.statut_users == "1"
                          ? const Text("Désactiver l'utilisateur")
                          : const Text(""),
                  onTap: () {},
                ),
                PopupMenuItem(
                  value: 3,
                  child: const Text("Supprimer l'utilisateur"),
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
          ? const Loader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  searchUserProvider.photo.isNotEmpty
                      ? SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: Image.network(searchUserProvider.photo),
                        )
                      : SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: Image.asset(
                            UserProfile['image'].toString(),
                            width: 50,
                            height: 50,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(appPadding),
                    child: Column(
                      children: [
                        FutureBuilder(
                            future: courseTaking,
                            builder:
                                (context, AsyncSnapshot<List<Cours>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Cours suivis",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text("${snapshot.data!.length}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700)),
                                  ],
                                );
                              } else {
                                return const Loader();
                              }
                            }),
                        const Divider(
                          thickness: 0.8,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        FutureBuilder(
                            future: courseTeaching,
                            builder:
                                (context, AsyncSnapshot<List<Cours>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Cours enseignés",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text("${snapshot.data!.length}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700)),
                                  ],
                                );
                              } else {
                                return const Loader();
                              }
                            }),
                        const Divider(
                          thickness: 0.8,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        FutureBuilder(
                            future: totalStudents,
                            builder:
                                (context, AsyncSnapshot<List<User>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Etudiants enrôlés",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text("${snapshot.data!.length}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700)),
                                  ],
                                );
                              } else {
                                return const Loader();
                              }
                            }),
                        const SizedBox(
                          height: appPadding,
                        ),
                        const Text(
                          "Cours suivis:",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        FutureBuilder(
                            future: courseTaking,
                            builder:
                                (context, AsyncSnapshot<List<Cours>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, i) {
                                      return CustomCourseCardShrink(
                                          thumbNail: snapshot.data![i].vignette,
                                          title: snapshot.data![i].titre,
                                          nom: snapshot.data![i].nom,
                                          prenom: snapshot.data![i].prenom,
                                          price: snapshot.data![i].prix);
                                    });
                              } else {
                                return const Loader();
                              }
                            }),
                        const SizedBox(
                          height: appPadding,
                        ),
                        const Text(
                          "Cours enseignés:",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        FutureBuilder(
                            future: courseTeaching,
                            builder:
                                (context, AsyncSnapshot<List<Cours>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, i) {
                                      return CustomCourseCardShrink(
                                          thumbNail: snapshot.data![i].vignette,
                                          title: snapshot.data![i].titre,
                                          nom: snapshot.data![i].nom,
                                          prenom: snapshot.data![i].prenom,
                                          price: snapshot.data![i].prix);
                                    });
                              } else {
                                return const Loader();
                              }
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
