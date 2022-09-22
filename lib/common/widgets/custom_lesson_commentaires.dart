import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/constants/colors.dart';

class CustomLessonCommentaires extends StatefulWidget {
  const CustomLessonCommentaires({Key? key}) : super(key: key);

  @override
  State<CustomLessonCommentaires> createState() => _CustomLessonCommentairesState();
}

class _CustomLessonCommentairesState extends State<CustomLessonCommentaires> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      // color: primary,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Row(
                children: [
                   CircleAvatar(
                  backgroundColor: secondary,
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sosso", style: TextStyle(fontWeight: FontWeight.bold),),
                      
                    ],
                  ),
                ),
                ],
               ),
                Text("1 mois")
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text("Failed host lookup: 'res.cloudinary.com' (OS Error: No address associated with hostname"),
            )
          ],
        ),
      ),
    );
  }
}
