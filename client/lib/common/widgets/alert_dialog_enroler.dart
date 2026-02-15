import 'package:flutter/material.dart';
import 'package:mbschool/common/arguments/select_file_arguments.dart';

import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/features/panel/course_manager/screens/plan_screen.dart';
import 'package:mbschool/features/panel/course_manager/screens/select_file.dart';
import 'package:mbschool/features/panel/course_manager/services/plan.service.dart';
import 'package:mbschool/models/cours.dart';

class AlertDialogEnroler extends StatefulWidget {
  final Cours cours;
  const AlertDialogEnroler({Key? key, required this.cours}) : super(key: key);

  @override
  State<AlertDialogEnroler> createState() => _AlertDialogEnrolerState();
}

enum type_lecon { video, document }

class _AlertDialogEnrolerState extends State<AlertDialogEnroler> {
  final _addSectionFormKey = GlobalKey<FormState>();

  TextEditingController titreSectionController = TextEditingController();

  PlanService planService = PlanService();

  @override
  void dispose() {
    super.dispose();
    titreSectionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
//Radio value

    int? selectedRadio = 1;


    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _addSectionFormKey,
          child: 
          AlertDialog(
            title: Row(
              children: [
                const Flexible(
                    child: Text(
                  "Ajouter une nouvelle leçon",
                  style: TextStyle(fontSize: 20),
                )),
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
                        child: const Center(
                          child: Icon(
                            Icons.close,
                            color: textWhite,
                          ),
                        )))
              ],
            ),
            content: SizedBox(
              height: 150,
              child: Column(
                children: [
                  const Flexible(
                      child: Text(
                    "Selectionner le type de la leçon",
                    style: TextStyle(fontSize: 15),
                  )),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Column(mainAxisSize: MainAxisSize.min, children: [
                        RadioListTile<int>(
                          value: 1,
                          groupValue: selectedRadio,
                          title: const Text("Vidéo"),
                          onChanged: (int? value) {
                            setState(() => selectedRadio = value);
                          },
                        ),
                        RadioListTile<int>(
                          value: 2,
                          groupValue: selectedRadio,
                          title: const Text("Document"),
                          onChanged: (int? value) {
                            setState(() => selectedRadio = value);
                          },
                        ),
                      ]);
                    },
                  ),
                ],
              ),
            ),
            actions: [
              InkWell(
                  splashColor: textBlack,
                  borderRadius: BorderRadius.circular(17.5),
                  onTap: () {
                    if (selectedRadio == 1) {
                      Navigator.pushNamed(context, SelectFile.routeName,
                          arguments: SelectFileArguments(1, widget.cours));
                    } else {
                      Navigator.pushNamed(context, SelectFile.routeName,
                          arguments: SelectFileArguments(2, widget.cours));
                    }
                  },
                  child: const CustomButtonBox(title: "Suivant"))
            ],
          ),
        ));
  }
}
