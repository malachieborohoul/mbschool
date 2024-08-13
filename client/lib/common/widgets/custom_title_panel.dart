import 'package:flutter/cupertino.dart';

class CustomTitlePanel extends StatelessWidget {
  final String title;
  const CustomTitlePanel({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(fontWeight: FontWeight.bold),);
  }
}
