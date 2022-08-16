import 'package:flutter/material.dart';
import 'package:mbschool/common/arguments/select_file_arguments.dart';

import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/common/widgets/custom_textfield.dart';
import 'package:mbschool/common/widgets/custom_textfield_panel.dart';
import 'package:mbschool/common/widgets/custom_title_panel.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/features/panel/course_manager/screens/course_manager_screen.dart';
import 'package:mbschool/features/panel/course_manager/screens/plan_screen.dart';
import 'package:mbschool/features/panel/course_manager/screens/select_file.dart';
import 'package:mbschool/features/panel/course_manager/services/plan.service.dart';
import 'package:mbschool/models/cours.dart';

class AlertDialogError extends StatefulWidget {
  final String texte;
  const AlertDialogError({Key? key,  required this.texte}) : super(key: key);

  @override
  State<AlertDialogError> createState() => _AlertDialogErrorState();
}

enum type_lecon { video, document }

class _AlertDialogErrorState extends State<AlertDialogError> {
  final _addSectionFormKey = GlobalKey<FormState>();

  TextEditingController titreSectionController = TextEditingController();

  PlanService planService = PlanService();
  bool _isCharging = false;

  @override
  void dispose() {
    super.dispose();
    titreSectionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
 

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.warning, color: Colors.red,),
              const Text("Attention", style: TextStyle(color: Colors.red),),
              
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red),
                      child: Center(
                        child: Icon(
                          Icons.close,
                          color: textWhite,
                        ),
                      )))
            ],
          ),
          content: Container(
            height: 80,
            child: Column(
              children: [
                Flexible(
                    child: Text(
                  widget.texte,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )),
               
              ],
            ),
          ),
          
        ));
  }
}
