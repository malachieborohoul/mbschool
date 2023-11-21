import 'package:flutter/material.dart';
import 'package:mbschool/models/lecon.dart';

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
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Row(
              children: [
                const Icon(
                  Icons.play_arrow,
                  size: 15,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(widget.lecon.titre),
              ],
            ),
            widget.isCourseEnrolled==false? const Icon(Icons.lock_outline, size: 15,): Container()
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const Divider(
          thickness: 0.5,
        ),
      ],
    );
  }
}
