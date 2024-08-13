import 'package:flutter/material.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/models/exigence.dart';

class CustomExigenceCours extends StatelessWidget {
  final Exigence exigence;
  const CustomExigenceCours({Key? key, required this.exigence}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          exigence.nom,
          style: const TextStyle(color: textWhite),
        ),
        const Divider(
          thickness: 0.5,
        ),
      ],
    );
  }
}
