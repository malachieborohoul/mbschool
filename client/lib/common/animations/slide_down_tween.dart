import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SlideDownTween extends StatelessWidget {
  const SlideDownTween({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 750),

    this.curve = Curves.easeOut,
    required this.offset,
    this.delay = 1.0,
  }) : super(key: key);
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
        child: child,
        curve: curve,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, -value * offset),
            child: child,
          );
        });
  }
}
