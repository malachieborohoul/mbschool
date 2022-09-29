import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RateCourseScreen extends StatefulWidget {
  const RateCourseScreen({Key? key}) : super(key: key);
  static const routeName = 'rate-course-screen';

  @override
  State<RateCourseScreen> createState() => _RateCourseScreenState();
}

class _RateCourseScreenState extends State<RateCourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Let's rate"),
    );
  }
}
