import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/models/exigence.dart';
import 'package:mbschool/models/section.dart';

class CustomExigenceCours extends StatelessWidget {
  final Exigence exigence;
  const CustomExigenceCours({Key? key, required this.exigence}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          exigence.nom,
          style: TextStyle(color: textWhite),
        ),
        Divider(
          thickness: 0.5,
        ),
      ],
    );
  }
}
