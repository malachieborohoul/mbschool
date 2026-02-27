import 'package:flutter/cupertino.dart';

class SlideDownTween extends StatelessWidget {
  const SlideDownTween({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 750),

    this.curve = Curves.easeOut,
    required this.offset,
    this.delay = 1.0,
  });
  final Widget child;
  final double offset;
  final Duration duration;
  final Curve curve;
  final double delay;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        tween: Tween(begin: 1.0, end: 0),
        duration: duration,
        curve: curve,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, -value * offset),
            child: child,
          );
        },
        child: child);
  }
}
