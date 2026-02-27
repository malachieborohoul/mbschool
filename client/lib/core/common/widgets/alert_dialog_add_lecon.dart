import 'package:flutter/material.dart';
import 'package:mbschool/core/common/arguments/select_file_arguments.dart';

import 'package:mbschool/core/common/widgets/custom_button_box.dart';
import 'package:mbschool/core/constants/colors.dart';
import 'package:mbschool/features/panel/course_manager/screens/select_file.dart';
import 'package:mbschool/features/panel/course_manager/screens/youtube_link.dart';
import 'package:mbschool/features/panel/course_manager/services/plan.service.dart';
import 'package:mbschool/models/cours.dart';

class AlertDialogAddLecon extends StatefulWidget {
  final Cours cours;
  const AlertDialogAddLecon({super.key, required this.cours});

  @override
  State<AlertDialogAddLecon> createState() => _AlertDialogAddLeconState();
}

enum TypeLecon { video, document }

class _AlertDialogAddLeconState extends State<AlertDialogAddLecon> {
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
          child: AlertDialog(
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
  builder: (BuildContext context, StateSetter setLocalState) {
    return RadioGroup<int>(
      // 1. Move the state management to the parent RadioGroup
      groupValue: selectedRadio,
      onChanged: (int? value) {
        // Use the local state setter to update the dialog UI
        setLocalState(() => selectedRadio = value);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          // 2. Simply define the values for each tile
          RadioListTile<int>(
            value: 1,
            title: Text("Fichier Vidéo"),
          ),
          RadioListTile<int>(
            value: 2,
            title: Text("Vidéo Youtube"),
          ),
        ],
      ),
    );
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
                  child: const CustomButtonBox(title: "Suivant"))
            ],
          ),
        ));
  }
}
