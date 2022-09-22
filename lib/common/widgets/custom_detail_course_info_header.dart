import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';

class CustomDetailCourseInfoHeader extends StatefulWidget {
  final Cours cours;
  bool isCourseInFav;

  CustomDetailCourseInfoHeader(
      {Key? key, required this.cours, required this.isCourseInFav})
      : super(key: key);

  @override
  State<CustomDetailCourseInfoHeader> createState() =>
      _CustomDetailCourseInfoHeaderState();
}

class _CustomDetailCourseInfoHeaderState
    extends State<CustomDetailCourseInfoHeader> {
  bool _isFavorite = false;

  CourseManagerService _courseManagerService = CourseManagerService();

  void addCoursToFavorite() {
    _courseManagerService.addCourseToFavorite(context, widget.cours, () {
      setState(() {
        widget.isCourseInFav = true;
      });
      showSnackBar(context, "Cours ajouté aux favoris");
    });
  }

  void removeCoursToFavorite() {
    _courseManagerService.removeCoursToFavorite(context, widget.cours, () {
      setState(() {
        widget.isCourseInFav = false;
      });
      showSnackBar(context, "Cours retiré des favoris");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:appPadding, left:appPadding, top: appPadding/2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.cours.titre,
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            width: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 20,
                    color: third,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: third,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: third,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: third,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: third,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("(4.0)"),
                ],
              ),
              
              IconButton(
                onPressed: () {
                  if (widget.isCourseInFav == false) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Notification"),
                              content: Container(
                                height: 90,
                                child: Column(
                                  children: [
                                    Text("Voulez vous l'ajouter aux favoris ?",style: TextStyle(fontSize: 15),),
                                    const SizedBox(
                                      height: appPadding,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              addCoursToFavorite();
                                            },
                                            splashColor: Colors.grey.shade200,
                                            child: Text(
                                              "Oui",
                                              style: TextStyle(
                                                  color: Colors.green),
                                            )),
                                        InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            splashColor: Colors.grey.shade200,
                                            child: Text(
                                              "Non",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Notification"),
                              content: Container(
                                height: 90,
                                child: Column(
                                  children: [
                                    Text(
                                        "Voulez vous le retirer des favoris ?", style: TextStyle(fontSize: 15),),
                                    const SizedBox(
                                      height: appPadding,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              removeCoursToFavorite();
                                            },
                                            splashColor: Colors.grey.shade200,
                                            child: Text(
                                              "Oui",
                                              style: TextStyle(
                                                  color: Colors.green),
                                            )),
                                        InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            splashColor: Colors.grey.shade200,
                                            child: Text(
                                              "Non",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ));
                  
                  }
                },
                icon: Icon(
                  color: Color.fromARGB(255, 255, 0, 0),
                  widget.isCourseInFav == false
                      ? Icons.favorite_outline_rounded
                      : Icons.favorite_rounded,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
