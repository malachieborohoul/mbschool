import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/models/cours.dart';

class CustomDetailCourseInfoHeader extends StatefulWidget {
  final Cours cours;
  const CustomDetailCourseInfoHeader({Key? key, required this.cours})
      : super(key: key);

  @override
  State<CustomDetailCourseInfoHeader> createState() =>
      _CustomDetailCourseInfoHeaderState();
}

class _CustomDetailCourseInfoHeaderState
    extends State<CustomDetailCourseInfoHeader> {
   bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.cours.titre,
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            width: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                  Text("(4.0)"),
                ],
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
                icon: Icon(
                  color: Color.fromARGB(255, 255, 0, 0),
                  _isFavorite == false? Icons.favorite_outline_rounded : Icons.favorite_rounded,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
