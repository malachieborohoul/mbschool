import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SlideRightTween extends StatelessWidget {
  const SlideRightTween({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 750),
    this.curve = Curves.easeOut,
    required this.offset,
  }) : super(key: key);
  final Widget child;
  final double offset;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        tween: Tween(begin: 1.0, end: 0),
        duration: duration,
        child: child,
        curve: curve,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(value * offset, 0),
            child: child,
          );
        });
  }
}