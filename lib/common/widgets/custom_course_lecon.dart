import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/constants/colors.dart';

class CustomCourseLecon extends StatefulWidget {
  const CustomCourseLecon({Key? key}) : super(key: key);

  @override
  State<CustomCourseLecon> createState() => _CustomCourseLeconState();
}

class _CustomCourseLeconState extends State<CustomCourseLecon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: textWhite,
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Comment manger le couscous"),
                  InkWell(child: Icon(Icons.edit)) 
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}