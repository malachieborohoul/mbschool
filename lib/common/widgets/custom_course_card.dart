import 'package:flutter/material.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/home/screens/detail_teacher_course_screen.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';

class CustomCourseCardExpand extends StatefulWidget {
  const CustomCourseCardExpand({
    Key? key,
    required this.thumbNail,
    required this.videoAmount,
    required this.title,
    required this.userProfile,
    required this.userName,
    required this.price,
    required this.cours,
  }) : super(key: key);

  final Widget thumbNail;
  final String videoAmount;
  final String title;
  final String userProfile;
  final String userName;
  final String price;
  final Cours cours;

  @override
  _CustomCourseCardExpandState createState() => _CustomCourseCardExpandState();
}

class _CustomCourseCardExpandState extends State<CustomCourseCardExpand> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .6,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        color: textWhite,
        borderRadius: BorderRadius.circular(17.0),
        boxShadow: [
          BoxShadow(
            color: textBlack.withOpacity(0.1),
            blurRadius: 10.0,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                height: size.width * .6,
                width: size.width * .6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: widget.thumbNail,
                ),
              ),
              Positioned(
                bottom: 7.0,
                left: 7.0,
                child: Container(
                  width: 90.0,
                  height: 30.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: textWhite.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(100.0)),
                  child: Text(
                    '${widget.videoAmount} Videos',
                    style: TextStyle(
                        color: secondary,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Container(
            padding: const EdgeInsets.only(
              left: 7.0,
              right: 7.0,
            ),
            child: Text(
              widget.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: secondary,
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.only(
              left: 7.0,
              right: 7.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 30.0,
                  width: 30.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, DetailTeacherCourseScreen.routeName,
                          arguments: widget.cours),
                      child: Image.network(
                        widget.userProfile,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Container(
                    width: size.width,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.userName,
                      style: TextStyle(
                        color: secondary,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
                Text(
                  '${widget.price}',
                  style: TextStyle(
                    color: primary,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}

class CustomCourseCardShrink extends StatefulWidget {
  const CustomCourseCardShrink({
    Key? key,
    required this.thumbNail,
    required this.title,
    required this.nom,
    required this.prenom,
    required this.price,
  }) : super(key: key);

  final String thumbNail;
  final String title;
  final String nom;
  final String prenom;
  final String price;

  @override
  _CustomCourseCardShrinkState createState() => _CustomCourseCardShrinkState();
}

class _CustomCourseCardShrinkState extends State<CustomCourseCardShrink> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.width * .25,
      padding: const EdgeInsets.all(15.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: textWhite,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Container(
            height: size.width * .125,
            width: size.width * .125,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                widget.thumbNail,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 15.0),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Instructor: ' + widget.nom + ' ' + widget.prenom,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: grey,
                      ),
                    ),
                    Text(
                      '' + widget.price,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 15,
                      color: third,
                    ),
                    Icon(
                      Icons.star,
                      size: 15,
                      color: third,
                    ),
                    Icon(
                      Icons.star,
                      size: 15,
                      color: third,
                    ),
                    Icon(
                      Icons.star,
                      size: 15,
                      color: third,
                    ),
                    Icon(
                      Icons.star,
                      size: 15,
                      color: third,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text("(4.0)"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFavoriteCourseCard extends StatefulWidget {
  const CustomFavoriteCourseCard({Key? key, required this.cours})
      : super(key: key);

  final Cours cours;

  @override
  _CustomFavoriteCourseCardState createState() =>
      _CustomFavoriteCourseCardState();
}

class _CustomFavoriteCourseCardState extends State<CustomFavoriteCourseCard> {
  CourseManagerService _courseManagerService = CourseManagerService();
  void removeCoursToFavorite(Cours cours) {
    _courseManagerService.removeCoursToFavorite(context, cours, () {
      setState(() {});
      showSnackBar(context, "Cours retiré des favoris");
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: size.width * 0.32),
          width: size.width * 0.8,
          height: size.height * .19,
          padding: const EdgeInsets.all(15.0),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: textWhite,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.cours.titre,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: secondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      width: size.width * 0.5,
                      height: size.height * 0.05,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: InkWell(
                        onTap: () {
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
                                                    removeCoursToFavorite(
                                                        widget.cours);
                                                  },
                                                  splashColor:
                                                      Colors.grey.shade200,
                                                  child: Text(
                                                    "Oui",
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  )),
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  splashColor:
                                                      Colors.grey.shade200,
                                                  child: Text(
                                                    "Non",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.close,
                              size: 15,
                            ),
                            Text(
                              "Rétirer des favoris",
                              style: TextStyle(fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: size.height * 0.190,
          width: size.width * 0.35,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              widget.cours.vignette,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
