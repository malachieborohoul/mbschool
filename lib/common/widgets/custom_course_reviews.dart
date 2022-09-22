import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/constants/colors.dart';

class CustomCourseReviews extends StatefulWidget {
  const CustomCourseReviews({Key? key}) : super(key: key);

  @override
  State<CustomCourseReviews> createState() => _CustomCourseReviewsState();
}

class _CustomCourseReviewsState extends State<CustomCourseReviews> {
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
                        ],
                      ),
                    
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
