import 'package:flutter/material.dart';


class OpacityTween extends StatelessWidget {
  const OpacityTween(
      {Key? key,
      this.duration = const Duration(milliseconds: 750),
      required this.child,
      required this.begin})
      : super(key: key);
  final Duration duration;
  final Widget child;
  final double begin;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        tween: Tween(begin: begin, end: 1),
        duration: duration,
        child: child,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: child,
          );
        });
  }
}
