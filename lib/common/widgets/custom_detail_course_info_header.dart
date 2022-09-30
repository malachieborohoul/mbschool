import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';

class CustomDetailCourseInfoHeader extends StatefulWidget {
  final Cours cours;
  bool isCourseInFav;
  final double averageRate;

  CustomDetailCourseInfoHeader(
      {Key? key,
      required this.cours,
      required this.isCourseInFav,
      required this.averageRate})
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
      padding: const EdgeInsets.only(
          right: appPadding, left: appPadding, top: appPadding / 2),
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
                  RatingBar.builder(
                    direction: Axis.horizontal,
                    itemSize: 15,
                    initialRating: widget.averageRate,
                    itemBuilder: (context, _) {
                      return Icon(
                        Icons.star,
                        size: 20,
                        color: third,
                      );
                    },
                    onRatingUpdate: (rating) {},
                  ),
                  // RatingBarIndicator(
                  //   direction: Axis.horizontal,
                  //   itemCount: 5,
                  //   rating: 5,
                  //   itemSize: 15,
                  //   itemBuilder: (BuildContext context, _) {
                  //     return Icon(
                  //       Icons.star,
                  //       size: 20,
                  //       color: third,
                  //     );
                  //   },
                  // ),
                  // Icon(
                  //   Icons.star,
                  //   size: 20,
                  //   color: third,
                  // ),
                  // Icon(
                  //   Icons.star,
                  //   size: 20,
                  //   color: third,
                  // ),
                  // Icon(
                  //   Icons.star,
                  //   size: 20,
                  //   color: third,
                  // ),
                  // Icon(
                  //   Icons.star,
                  //   size: 20,
                  //   color: third,
                  // ),
                  // Icon(
                  //   Icons.star,
                  //   size: 20,
                  //   color: third,
                  // ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("${widget.averageRate}"),
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
                                    Text(
                                      "Voulez vous l'ajouter aux favoris ?",
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
                                              Navigator.pop(context);
                                              addCoursToFavorite();
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
                                                style:
                                                    TextStyle(color: textWhite),
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
                                                style:
                                                    TextStyle(color: textWhite),
                                              ),
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
                                      "Voulez vous le retirer des favoris ?",
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
                                              Navigator.pop(context);
                                              removeCoursToFavorite();
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
                                                style:
                                                    TextStyle(color: textWhite),
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
                                                style:
                                                    TextStyle(color: textWhite),
                                              ),
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
