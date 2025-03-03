
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/common/widgets/custom_textfield_panel.dart';
import 'package:mbschool/common/widgets/custom_title_panel.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/panel/course_manager/screens/plan_screen.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/features/panel/course_manager/services/select_file_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/section.dart';
import 'package:mbschool/providers/course_plan_provider.dart';
import 'package:provider/provider.dart';

class YoutubeLink extends StatefulWidget {
  static const routeName = '/youtube-link';
  final Cours cours;
  const YoutubeLink({Key? key, required this.cours}) : super(key: key);

  @override
  State<YoutubeLink> createState() => _YoutubeLinkState();
}

class _YoutubeLinkState extends State<YoutubeLink> {
  List<Section> sections = [];
  CourseManagerService courseManagerService = CourseManagerService();
  TextEditingController titreEditingController = TextEditingController();
  TextEditingController resumeEditingController = TextEditingController();
  TextEditingController lienEditingController = TextEditingController();
  final _createLessonFormKey = GlobalKey<FormState>();
  SelectFileService selectFileService = SelectFileService();

  @override
  void initState() {
    super.initState();
    getAllSections();
  }

  void getAllSections() async {
    sections = await courseManagerService.getAllSections(context, widget.cours);
    setState(() {});
  }

  //SELECTIONNER UNE VIDEO
  PlatformFile? video;
  Future selectVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);

    if (result == null) return;

    setState(() {
      video = result.files.first;
    });
  }

  //SELECTIONNER UN DOCUMENT

  PlatformFile? document;
  Future selectDocument() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);

    if (result == null) return;

    setState(() {
      video = result.files.first;
    });
  }

  bool isCharging = false;
  int id_section = 0;

  @override
  Widget build(BuildContext context) {
    String? dropdownvalue_section;
    // String dropdownvalue_section =
    //     sections != null ? sections[0].id_section : "";

    //Si dans le droplist rien n'a été choisi zero sera envoyé or zero ne figure pas comme id dans la table parente donc
    // if (id_section == 0) id_section = int.parse(dropdownvalue_section);

    final coursProvider =
        Provider.of<CoursPlanProvider>(context, listen: false).cours;
    void createLesson() {
      selectFileService.createLessonLinkYoutube(
          context,
          titreEditingController.text,
          resumeEditingController.text,
          widget.cours.id_cours,
          id_section,
          2,
          lienEditingController.text, () {
        setState(() {
          isCharging = false;

          Navigator.of(context)
            ..pop()
            ..pop()
            ..pop()
            ..pushNamed(PlanScreen.routeName, arguments: coursProvider);

          showSnackBar(context, "Leçon ajoutée avec succès");
        });
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        foregroundColor: textBlack,
        backgroundColor: textWhite,
        title: const Text(
          "Ajouter une nouvelle leçon",
          style: TextStyle(color: textBlack),
        ),
        elevation: 1,
      ),
      body: isCharging == true
          ? const Loader()
          : GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Form(
                  key: _createLessonFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(appPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Créer une leçon: Lien Youtube",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          height: appPadding,
                        ),
                        const CustomTitlePanel(title: "Titre"),
                        const SizedBox(
                          height: appPadding - 20,
                        ),

                        CustomTextFieldPanel(
                            hintText: "Titre",
                            prefixIcon: Icons.title,
                            controller: titreEditingController),
                        const SizedBox(
                          height: appPadding,
                        ),
                        const CustomTitlePanel(title: "Section"),
                        const SizedBox(
                          height: appPadding - 20,
                        ),

                        // DROPDOWN BUTTON SECTION

                        DropdownButtonFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: textWhite,
                              hintText: "Selectionner section",
                              hintStyle: TextStyle(color: Colors.grey.shade300),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            value: dropdownvalue_section,
                            items: sections.map((Section item) {
                              return DropdownMenuItem(
                                value: item.id_section,
                                child: Text(item.titre),
                              );
                            }).toList(),
                            onChanged: (String? val) {
                              setState(() {
                                //On ne peut pas envoyer cette valeur car elle prend à chaque compilation l'id du premier element
                                dropdownvalue_section = val!;
                                id_section = int.parse(dropdownvalue_section!);
                              });
                            }),

                        const SizedBox(
                          height: appPadding,
                        ),
                        const CustomTitlePanel(title: "Lien Youtube"),
                        const SizedBox(
                          height: appPadding - 20,
                        ),
                        CustomTextFieldPanel(
                            hintText: "Lien Youtube",
                            prefixIcon: Icons.info,
                            controller: lienEditingController),
                        const SizedBox(
                          height: appPadding,
                        ),
                        const CustomTitlePanel(title: "Resumé"),
                        const SizedBox(
                          height: appPadding - 20,
                        ),
                        CustomTextFieldPanel(
                            hintText: "Resumé",
                            prefixIcon: Icons.info,
                            controller: resumeEditingController),
                        const SizedBox(
                          height: appPadding,
                        ),

                        InkWell(
                            splashColor: textBlack,
                            onTap: () {
                              if (_createLessonFormKey.currentState!
                                  .validate()) {
                                setState(() {
                                  isCharging = true;
                                });
                                createLesson();
                              }
                            },
                            child: const CustomButtonBox(title: "Ajouter leçon"))
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
