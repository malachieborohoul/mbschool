import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';

class CustomDetailCourseInfoHeader extends StatefulWidget {
  const CustomDetailCourseInfoHeader({Key? key}) : super(key: key);

  @override
  State<CustomDetailCourseInfoHeader> createState() => _CustomDetailCourseInfoHeaderState();
}

class _CustomDetailCourseInfoHeaderState extends State<CustomDetailCourseInfoHeader>  {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Développement Web",
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            width: 15,
          ),
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
              Text("(4.0)")
            ],
          ),
          
        ],
      ),
    );
  }
}
