import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/lecon.dart';
import 'package:mbschool/models/section.dart';

class CustomCourseCurriculumLecon extends StatefulWidget {
  final Lecon lecon;
  final bool isCourseEnrolled;
  const CustomCourseCurriculumLecon(
      {Key? key, required this.lecon, required this.isCourseEnrolled})
      : super(key: key);

  @override
  State<CustomCourseCurriculumLecon> createState() =>
      _CustomCourseCurriculumLeconState();
}

class _CustomCourseCurriculumLeconState
    extends State<CustomCourseCurriculumLecon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Row(
              children: [
                Icon(
                  Icons.play_arrow,
                  size: 15,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(widget.lecon.titre),
              ],
            ),
            widget.isCourseEnrolled==false? Icon(Icons.lock_outline, size: 15,): Container()
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Divider(
          thickness: 0.5,
        ),
      ],
    );
  }
}
