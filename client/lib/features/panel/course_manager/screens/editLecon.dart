import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:mbschool/common/widgets/custom_textfield_panel.dart';
import 'package:mbschool/common/widgets/custom_title_panel.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/panel/course_manager/screens/plan_screen.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/features/panel/course_manager/services/edit_lecon_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/lecon.dart';
import 'package:mbschool/models/section.dart';
import 'package:mbschool/providers/course_plan_provider.dart';
import 'package:mbschool/providers/lecon_provider.dart';
import 'package:provider/provider.dart';

class EditLecon extends StatefulWidget {
  static const routeName = '/edit_lecon';
  final Lecon lecon;
  final Cours cours;
  const EditLecon({Key? key, required this.lecon, required this.cours})
      : super(key: key);

  @override
  State<EditLecon> createState() => _EditLeconState();
}

class _EditLeconState extends State<EditLecon> {
  List<Section> sections = [];
  CourseManagerService courseManagerService = CourseManagerService();
  TextEditingController titreEditingController = TextEditingController();
  TextEditingController resumeEditingController = TextEditingController();
  final _editLeconFormKey = GlobalKey<FormState>();
  EditLeconService editLeconService = EditLeconService();

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
    // print(widget.cours.titre);
    // print(widget.lecon.titre);
    final leconProvider =
        Provider.of<LeconProvider>(context, listen: false).lecon;
    final coursProvider =
        Provider.of<CoursPlanProvider>(context, listen: false).cours;
    String? dropdownvalue_section;
    // sections != null ? sections[0].id_section : "";

    //Si dans le droplist rien n'a été choisi zero sera envoyé or zero ne figure pas comme id dans la table parente donc
    // if (id_section == 0) id_section = int.parse(dropdownvalue_section);

    void editLecon() {
      editLeconService.editLecon(
          context,
          leconProvider,
          titreEditingController.text,
          resumeEditingController.text,
          widget.cours.id_cours,
          int.parse(dropdownvalue_section!),
          video!, () {
        setState(() {
          isCharging = false;

          Navigator.of(context)
            ..pop()
            ..pop()
            ..pushNamed(PlanScreen.routeName, arguments: coursProvider);

          showSnackBar(context, "Leçon modifiée avec succès");
        });
      });
    }

    void deleteLecon() {
      editLeconService.deleteLecon(context, leconProvider, () {
        setState(() {
          isCharging = false;
          showSnackBar(context, "Leçon supprimée");
          Navigator.of(context)
            ..pop()
            ..pop()
            ..pushNamed(PlanScreen.routeName, arguments: coursProvider);
        });
      });
    }

    if (isCharging == false) {
      titreEditingController.text = leconProvider.titre;
      resumeEditingController.text = leconProvider.resume;
      dropdownvalue_section = leconProvider.id_section;
    } else {
      titreEditingController.text = titreEditingController.text;
      resumeEditingController.text = resumeEditingController.text;
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        foregroundColor: textBlack,
        backgroundColor: textWhite,
        title: const Text(
          "Modifier une leçon",
          style: TextStyle(color: textBlack),
        ),
        elevation: 1,
      ),
      body: isCharging == true || sections == null
          ? const Loader()
          : GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Form(
                  key: _editLeconFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(appPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Modifier une leçon",
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
                            hint: const Text("Selectionner une section"),
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
                                // id_section = int.parse(dropdownvalue_section);
                              });
                            }),

                        const SizedBox(
                          height: appPadding,
                        ),
                        const CustomTitlePanel(title: "Télécharger une vidéo"),
                        const SizedBox(
                          height: appPadding - 20,
                        ),

                        InkWell(
                          splashColor: textBlack,
                          onTap: selectVideo,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 100,
                                decoration: const BoxDecoration(
                                    color: textWhite,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),

                                // child: video != null ? Text(video!.path!) : Text(""),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  video != null ? Text(video!.path!) : const Text(""),
                                  Container(
                                    height: 30,
                                    width: 150,
                                    decoration: const BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.all(
                                             Radius.circular(8))),
                                    child:  const Center(
                                        child: Text(
                                      "Choisir une video",
                                      style: TextStyle(
                                          color: textWhite,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isCharging = true;
                                });
                                deleteLecon();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: secondary,
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Text(
                                  "Supprimer leçon",
                                  style: TextStyle(
                                      color: textWhite,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_editLeconFormKey.currentState!
                                    .validate()) {
                                  setState(() {
                                    isCharging = true;
                                  });
                                  editLecon();
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
                                  "Modifier leçon",
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
            ),
    );
  }
}
