import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/common/widgets/custom_textfield.dart';
import 'package:mbschool/common/widgets/custom_textfield_panel.dart';
import 'package:mbschool/common/widgets/custom_title_panel.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/features/panel/course_manager/screens/course_manager_screen.dart';
import 'package:mbschool/features/panel/course_manager/screens/plan_screen.dart';
import 'package:mbschool/features/panel/course_manager/services/plan.service.dart';
import 'package:mbschool/models/cours.dart';

class AlertDialogAddSection extends StatefulWidget {
  final Cours cours;
  const AlertDialogAddSection({Key? key, required this.cours})
      : super(key: key);

  @override
  State<AlertDialogAddSection> createState() => _AlertDialogAddSectionState();
}

class _AlertDialogAddSectionState extends State<AlertDialogAddSection> {
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
          backgroundColor: Colors.grey.shade100,
          title: Row(
            children: [
              Flexible(
                  child: Text(
                "Ajouter une nouvelle section",
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
          content: _isCharging == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: primary,
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    children: [
                      CustomTitlePanel(title: "Titre"),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFieldPanel(
                          hintText: "Titre de la section",
                          prefixIcon: Icons.title_sharp,
                          controller: titreSectionController)
                    ],
                  ),
                ),
          actions: [
            InkWell(
                splashColor: textBlack,
                borderRadius: BorderRadius.circular(17.5),
                onTap: () {
                  if (_addSectionFormKey.currentState!.validate()) {
                    setState(() {
                      _isCharging = true;
                    });
                    addSection();
                  }
                },
                child: CustomButtonBox(title: "Enregistrer"))
          ],
        ),
      ),
    );
  }
}
