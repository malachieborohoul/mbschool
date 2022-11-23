import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/arguments/course_lesson_arguments.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/features/panel/course_manager/screens/editLecon.dart';
import 'package:mbschool/models/lecon.dart';
import 'package:mbschool/providers/course_plan_provider.dart';
import 'package:mbschool/providers/lecon_provider.dart';
import 'package:provider/provider.dart';

class CustomCourseLecon extends StatefulWidget {
  final Lecon lecon;
  const CustomCourseLecon({Key? key, required this.lecon}) : super(key: key);

  @override
  State<CustomCourseLecon> createState() => _CustomCourseLeconState();
}

class _CustomCourseLeconState extends State<CustomCourseLecon> {
  @override
  Widget build(BuildContext context) {
    final coursProvider =
        Provider.of<CoursPlanProvider>(context, listen: false).cours;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: textWhite,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.lecon.titre),
                  InkWell(
                      onTap: () {
                        Provider.of<LeconProvider>(context, listen: false)
                            .set_lecon(widget.lecon);
                        Navigator.pushNamed(context, EditLecon.routeName,
                            arguments: CourseLessonArguments(coursProvider, widget.lecon));
                      },
                      child: Icon(Icons.edit))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
