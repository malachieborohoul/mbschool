import 'package:flutter/material.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';

class CustomMyCoursesCard extends StatefulWidget {
  const CustomMyCoursesCard({
    Key? key,
    required this.image,
    required this.title,
    required this.instructor,
    required this.videoAmount,
    this.percentage = 0,
    required this.cours,
  }) : super(key: key);

  final String image;
  final String title;
  final String instructor;
  final String videoAmount;
  final double percentage;
  final Cours cours;

  @override
  _CustomMyCoursesCardState createState() => _CustomMyCoursesCardState();
}

class _CustomMyCoursesCardState extends State<CustomMyCoursesCard> {
  CourseManagerService courseManagerService = CourseManagerService();
  String numberLecon="0";
  String numberLeconDone="0";

  @override
  void initState() {
    super.initState();
    getNumberLeconCours();
    getNumberLeconCoursDone();
  }

  void getNumberLeconCours() async {
    numberLecon =
        await courseManagerService.getNumberLeconCours(context, widget.cours);
    setState(() {});
  }

  void getNumberLeconCoursDone() async {
    numberLeconDone = await courseManagerService.getNumberLeconCoursDone(
        context, widget.cours);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // int poucentage = (((100 * double.parse(numberLeconDone)) / double.parse(numberLecon)).floor());

    return
         Container(
            width: size.width,
            height: size.width * .3,
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: textWhite,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: size.width * .13,
                  child: Row(
                    children: [
                      SizedBox(
                        height: size.width * .13,
                        width: size.width * .13,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            widget.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: miniSpacer),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: secondary,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Enseignant: ${widget.instructor}',
                                  style: const TextStyle(
                                    fontSize: 11.0,
                                    color: grey,
                                  ),
                                ),
                                Text(
                                  '$numberLeconDone/$numberLecon',
                                  style: const TextStyle(
                                    fontSize: 11.0,
                                    color: grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: size.width,
                            height: 5.0,
                            decoration: BoxDecoration(
                              color: secondary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          ),
                          Container(
                            width:  numberLecon == "0"? 0: (((100 * double.parse(numberLeconDone)) / double.parse(numberLecon)).floor()).toDouble()*2.1,
                            height: 7.0,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(100.0),
                              boxShadow: [
                                BoxShadow(
                                  color: primary.withOpacity(0.5),
                                  blurRadius: 6.0,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: miniSpacer * 2),
                    Container(
                      width: 50,
                      alignment: Alignment.centerRight,
                      child:  Text(
                       numberLecon == "0"? "0": '${((100 * double.parse(numberLeconDone)) / double.parse(numberLecon)).floor()}%',
                        style: const TextStyle(
                            fontSize: 13.0,
                            color: primary,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
