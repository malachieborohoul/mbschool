import 'package:flutter/material.dart';
import 'package:mbschool/core/constants/colors.dart';
import 'package:mbschool/models/exigence.dart';

class CustomExigenceCours extends StatelessWidget {
  final Exigence exigence;
  const CustomExigenceCours({super.key, required this.exigence});

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
