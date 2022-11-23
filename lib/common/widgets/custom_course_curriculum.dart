import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:mbschool/common/arguments/course_lesson_arguments.dart';
import 'package:mbschool/common/widgets/custom_course_curriculum_lecon.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/course/screens/detail_lesson_screen.dart';
import 'package:mbschool/features/course/services/video_settings_service.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/lecon.dart';
import 'package:mbschool/models/section.dart';

class CustomCourseCurriculum extends StatefulWidget {
  final Section section;
  final Cours cours;
  final bool isCourseEnrolled;
  const CustomCourseCurriculum(
      {Key? key,
      required this.section,
      required this.cours,
      this.isCourseEnrolled = false})
      : super(key: key);

  @override
  State<CustomCourseCurriculum> createState() => _CustomCourseCurriculumState();
}

class _CustomCourseCurriculumState extends State<CustomCourseCurriculum> {
  List<Lecon> lecons = [];
  CourseManagerService courseManagerService = CourseManagerService();

  @override
  void initState() {
    super.initState();
    getAllLecons();
  }

  void getAllLecons() async {
    lecons = await courseManagerService.getAllLecons(context, widget.section);
    setState(() {
      print(lecons.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        // width: double.infinity,
        // height: 300,
        // decoration: BoxDecoration(
        //   color: Colors.transparent,
        //   borderRadius: BorderRadius.all(Radius.circular(15)),
        // ),
        child: Padding(
      padding: const EdgeInsets.all(appPadding - 20),
      child: ExpandablePanel(
          header: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.section.titre),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(Icons.keyboard_arrow_up_rounded))
                ],
              ),
            ],
          ),
          collapsed: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.green.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                        child:
                            Text("00:20:30", style: TextStyle(fontSize: 12))),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 20,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.red.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                        child: Text(
                      "10 leçons",
                      style: TextStyle(fontSize: 12),
                    )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          expanded: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.green.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                        child:
                            Text("00:20:30", style: TextStyle(fontSize: 12))),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 20,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.red.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                        child: Text(
                      "10 leçons",
                      style: TextStyle(fontSize: 12),
                    )),
                  ),
                ],
              ),
              for (int i = 0; i < lecons.length; i++)
                widget.isCourseEnrolled == true
                    ? InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, DetailLessonScreen.routeName,
                              arguments: CourseLessonArguments(
                                  widget.cours, lecons[i]));
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return VideoDisplay(videoUrl: lecons[i].url);
                          // }));
                        },
                        splashColor: Colors.grey,
                        child: CustomCourseCurriculumLecon(
                          lecon: lecons[i],
                          isCourseEnrolled: widget.isCourseEnrolled,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          showSnackBar(context, "Enrôlez vous!");
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return VideoDisplay(videoUrl: lecons[i].url);
                          // }));
                        },
                        splashColor: Colors.grey,
                        child: CustomCourseCurriculumLecon(
                          lecon: lecons[i],
                          isCourseEnrolled: widget.isCourseEnrolled,
                        ),
                      ),
            ],
          )),
    ));
  }
}
