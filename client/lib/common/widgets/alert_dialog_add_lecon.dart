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
import 'package:mbschool/features/panel/course_manager/screens/youtube_link.dart';
import 'package:mbschool/features/panel/course_manager/services/plan.service.dart';
import 'package:mbschool/models/cours.dart';

class AlertDialogAddLecon extends StatefulWidget {
  final Cours cours;
  const AlertDialogAddLecon({Key? key, required this.cours}) : super(key: key);

  @override
  State<AlertDialogAddLecon> createState() => _AlertDialogAddLeconState();
}

enum type_lecon { video, document }

class _AlertDialogAddLeconState extends State<AlertDialogAddLecon> {
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
    type_lecon? type_lecon_value = type_lecon.video; //Radio value

    int? selectedRadio = 1;

    void addSection() {
      planService.addSection(context, titreSectionController.text, widget.cours,
          () {
        setState(() {
          _isCharging = false;
          Navigator.popAndPushNamed(context, PlanScreen.routeName,
              arguments: widget.cours);
        });
      });
    }

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _addSectionFormKey,
          child: AlertDialog(
            title: Row(
              children: [
                Flexible(
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
                        child: Center(
                          child: Icon(
                            Icons.close,
                            color: textWhite,
                          ),
                        )))
              ],
            ),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  Flexible(
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
                          title: const Text("Fichier Vidéo"),
                          onChanged: (int? value) {
                            setState(() => selectedRadio = value);
                          },
                        ),
                        RadioListTile<int>(
                          value: 2,
                          groupValue: selectedRadio,
                          title: const Text("Vidéo Youtube"),
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
                      Navigator.pushNamed(context, YoutubeLink.routeName,
                          arguments: widget.cours);
                    }
                  },
                  child: CustomButtonBox(title: "Suivant"))
            ],
          ),
        ));
  }
}
