import 'package:flutter/material.dart';

import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/course/screens/detail_course_screen.dart';
import 'package:mbschool/features/panel/course_manager/screens/course_manager_screen.dart';
import 'package:mbschool/features/panel/course_manager/screens/exigence_screen.dart';
import 'package:mbschool/features/panel/course_manager/screens/modify_course_screen.dart';
import 'package:mbschool/features/panel/course_manager/screens/plan_screen.dart';
import 'package:mbschool/features/panel/course_manager/screens/resultat_screen.dart';
import 'package:mbschool/features/panel/create_course/services/create_course_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/providers/course_plan_provider.dart';
import 'package:provider/provider.dart';

class CustomCard extends StatefulWidget {
  final Cours cours;
  const CustomCard({Key? key, required this.cours}) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

bool isCharging = false;

class _CustomCardState extends State<CustomCard> {
  CreateCourseService createCourseService = CreateCourseService();
  final items = ["ok", "ak"];
  @override
  Widget build(BuildContext context) {
    void deleteCours() {
      courseManagerService.deleteCours(context, widget.cours, () {
        setState(() {
          isCharging = false;

          Navigator.of(context)
            ..pop()
            ..pop()
            ..pushNamed(CourseManagerScreen.routeName);       

          showSnackBar(context, "Cours supprimé");
        });
      });
    }

    bool? isCourseExigence;
    bool? isCourseResultat;
    void publishCours() async {
      isCourseExigence = await courseManagerService.verifyCourseHasExigence(
          context, widget.cours);

      isCourseResultat = await courseManagerService.verifyCourseHasResultat(
          context, widget.cours);
          setState(() {
            
          });

      if (isCourseExigence == false && isCourseResultat==false) {
        Navigator.pop(context);
        isCharging = false;
        showSnackBar(context, "Veuillez compléter la procédure");
      } else {
        courseManagerService.publishCours(context, widget.cours, () {
          setState(() {
            isCharging = false;

            Navigator.of(context)
              ..pop()
              ..pop()
              ..pushNamed(CourseManagerScreen.routeName);

            showSnackBar(context, "Cours publié");
          });
        });
      }
    }

    void deactivateCours() {
      courseManagerService.deactivateCours(context, widget.cours, () {
        setState(() {
          isCharging = false;

          Navigator.of(context)
            ..pop()
            ..pop()
            ..pushNamed(CourseManagerScreen.routeName);

          showSnackBar(context, "Cours désactivé");
        });
      });
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 100,
      decoration: const BoxDecoration(
          color: textWhite,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.5,
                blurRadius: 2,
                offset: Offset(0, 5))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 80,
              decoration: BoxDecoration(
                color: widget.cours.statut == 0 ? Colors.red : Colors.green,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Center(
                  child: widget.cours.statut == 0
                      ? const Text(
                          "N",
                          style: TextStyle(color: textWhite, fontSize: 30),
                        )
                      : const Text(
                          "P",
                          style: TextStyle(color: textWhite, fontSize: 30),
                        )),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(child: Text(widget.cours.titre)),
            GestureDetector(
              child: PopupMenuButton(onSelected: (value) {
                if (value == 1) {
                  Navigator.pushNamed(context, PlanScreen.routeName,
                      arguments: widget.cours);

                  Provider.of<CoursPlanProvider>(context, listen: false)
                      .set_cours(widget.cours);
                } else if (value == 2) {
                  Navigator.pushNamed(context, ModifyCourseScreen.routeName,
                      arguments: widget.cours);
                } else if (value == 3) {
                  Navigator.pushNamed(context, ExigenceScreen.routeName,
                      arguments: widget.cours);
                } else if (value == 4) {
                  Navigator.pushNamed(context, ResultatScreen.routeName,
                      arguments: widget.cours);
                } else if (value == 5) {
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
                                          "Voulez vous supprimer le cours?",
                                          style: TextStyle(fontSize: 15),
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
                                                    deleteCours();
                                                    isCharging = true;
                                                  });
                                                },
                                                splashColor:
                                                    Colors.grey.shade200,
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
                                                splashColor:
                                                    Colors.grey.shade200,
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
                } else if (value == 6) {
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
                                          "Voulez vous publier le cours?",
                                          style: TextStyle(fontSize: 15),
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
                                                    publishCours();
                                                    isCharging = true;
                                                  });
                                                },
                                                splashColor:
                                                    Colors.grey.shade200,
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
                                                splashColor:
                                                    Colors.grey.shade200,
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
                } else if (value == 7) {
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
                                          "Voulez vous désactiver le cours?",
                                          style: TextStyle(fontSize: 15),
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
                                                    deactivateCours();
                                                    isCharging = true;
                                                  });
                                                },
                                                splashColor:
                                                    Colors.grey.shade200,
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
                                                splashColor:
                                                    Colors.grey.shade200,
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
                    child: const Text("Plan"),
                    onTap: () {},
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: const Text("Modifier cours"),
                    onTap: () {},
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: const Text("Exigences"),
                    onTap: () {},
                  ),
                  PopupMenuItem(
                    value: 4,
                    child: const Text("Resultats"),
                    onTap: () {},
                  ),
                  PopupMenuItem(
                    value: 5,
                    child: const Text("Supprimer cours"),
                    onTap: () {},
                  ),
                  widget.cours.statut == 0
                      ? PopupMenuItem(
                          value: 6,
                          child: const Text("Publier cours"),
                          onTap: () {},
                        )
                      : PopupMenuItem(
                          value: 7,
                          child: const Text("Désactiver cours"),
                          onTap: () {},
                        ),
                ];
              }),
            )
          ],
        ),
      ),
    );
  }
}
