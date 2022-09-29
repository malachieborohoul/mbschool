import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/models/notation_cours.dart';

class CustomCourseReviews extends StatefulWidget {
  const CustomCourseReviews({Key? key, required this.notationCours})
      : super(key: key);
  final NotationCours notationCours;
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
        padding: const EdgeInsets.only(top: appPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.notationCours.photo),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${widget.notationCours.nom} ${widget.notationCours.prenom}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10,),
                          RatingBar.builder(
                            direction: Axis.horizontal,
                            itemSize: 15,
                            initialRating: double.parse(widget.notationCours.note),
                            itemBuilder: (context,_){
                             return Icon(
                                Icons.star,
                                size: 20,
                                color: third,
                              );

                          }, onRatingUpdate: (rating){})
                        ],
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text("${widget.notationCours.testimonial}")),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
