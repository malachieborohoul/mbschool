import 'package:flutter/material.dart';
import 'package:mbschool/core/constants/colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: primary,
      ),
    );
  }
}
