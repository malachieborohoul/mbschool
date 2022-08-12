import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/custom_course_lecon.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/models/section.dart';

class CustomCourseSection extends StatefulWidget {
  final Section sections;
  const CustomCourseSection({Key? key, required this.sections}) : super(key: key);

  @override
  State<CustomCourseSection> createState() => _CustomCourseSectionState();
}

class _CustomCourseSectionState extends State<CustomCourseSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.sections.titre),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
              ],
            ),
            CustomCourseLecon(),
            CustomCourseLecon(),
          ],
        ),
      ),
    );
  }
}
