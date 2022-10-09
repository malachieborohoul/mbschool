import 'package:flutter/material.dart';
import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/common/widgets/custom_textfield_panel.dart';
import 'package:mbschool/common/widgets/custom_title_panel.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/panel/course_manager/screens/plan_screen.dart';
import 'package:mbschool/features/panel/course_manager/services/edit_section_service.dart';
import 'package:mbschool/models/section.dart';
import 'package:mbschool/providers/course_plan_provider.dart';
import 'package:mbschool/providers/section_provider.dart';
import 'package:provider/provider.dart';

class EditSectionScreen extends StatefulWidget {
  static const routeName = '/edit_section';

  const EditSectionScreen({Key? key, required this.section}) : super(key: key);
  final Section section;

  @override
  State<EditSectionScreen> createState() => _EditSectionScreenState();
}

class _EditSectionScreenState extends State<EditSectionScreen> {
  List<Section> sections = [];
  TextEditingController titreSectionController = TextEditingController();
  final _editSectionFormKey = GlobalKey<FormState>();
  EditSectionService editSectionService = EditSectionService();
  bool isCharging = false;

  @override
  @override
  void dispose() {
    titreSectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sectionProvider =
        Provider.of<SectionProvider>(context, listen: false).section;

    final coursProvider =
        Provider.of<CoursPlanProvider>(context, listen: false).cours;


    void editSection() {
      editSectionService.editSection(
          context, sectionProvider, titreSectionController.text, () {
        setState(() {
          isCharging = false;
          showSnackBar(context, "Section modifiée");
          Navigator.of(context)
            ..pop()
            ..pop()
            ..pushNamed(PlanScreen.routeName, arguments: coursProvider);
        });
      });
    }

    void deleteSection() {
      editSectionService.deleteSection(context, sectionProvider, () {
        setState(() {
          isCharging = false;
          showSnackBar(context, "Section supprimée");
          Navigator.of(context)
            ..pop()
            ..pop()
            ..pushNamed(PlanScreen.routeName, arguments: coursProvider);
        });
      });
    }

    if (isCharging == false) {
      titreSectionController.text = sectionProvider.titre;
    } else {
      titreSectionController.text = titreSectionController.text;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: sections == null || isCharging == true
          ? const Loader()
          : Scaffold(
              appBar: AppBar(
                foregroundColor: textBlack,
                backgroundColor: textWhite,
                elevation: 0,
                shadowColor: Colors.transparent,
                centerTitle: true,
                title: Text('Modifier la section'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _editSectionFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTitlePanel(title: "Titre de la section"),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFieldPanel(
                          hintText: "Titre de la section",
                          prefixIcon: Icons.title_sharp,
                          controller: titreSectionController),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isCharging = true;
                              });
                              deleteSection();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: secondary,
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Text(
                                "Supprimer section",
                                style: TextStyle(
                                    color: textWhite,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_editSectionFormKey.currentState!
                                  .validate()) {
                                setState(() {
                                  isCharging = true;
                                });
                                editSection();
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Text(
                                "Modifier section",
                                style: TextStyle(
                                    color: textWhite,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      )
                    
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
