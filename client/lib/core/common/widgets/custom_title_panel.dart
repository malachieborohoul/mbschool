import 'package:flutter/cupertino.dart';

class CustomTitlePanel extends StatelessWidget {
  final String title;
  const CustomTitlePanel({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(fontWeight: FontWeight.bold),);
  }
}
