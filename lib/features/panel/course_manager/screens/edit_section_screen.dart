import 'package:flutter/material.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/models/section.dart';

class EditSectionScreen extends StatefulWidget {
  static const routeName = '/edit_section';

  const EditSectionScreen({Key? key, required this.section}) : super(key: key);
  final Section section;

  @override
  State<EditSectionScreen> createState() => _EditSectionScreenState();
}

class _EditSectionScreenState extends State<EditSectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: textBlack,
          backgroundColor: textWhite,
          elevation: 0,
          shadowColor: Colors.transparent,
          centerTitle: true,
          title: Text('Modifier la section'),
        ),
    );
  }
}
