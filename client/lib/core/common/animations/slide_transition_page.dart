import 'package:flutter/material.dart';

class SlideTransitionPage extends StatelessWidget {
  final Widget page;
  final Animation<double> animation;

  const SlideTransitionPage({
    super.key,
    required this.page,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0), // Start from the left
        end: Offset.zero, // End at the original position
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut, // Adjust the curve as needed
      )),
      child: page,
    );
  }
}
