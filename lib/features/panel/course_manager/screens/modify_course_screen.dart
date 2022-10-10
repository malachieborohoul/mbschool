import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/alert_dialog_error.dart';
import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/common/widgets/custom_dropdown_button_langue.dart';
import 'package:mbschool/common/widgets/custom_textfield_panel.dart';
import 'package:mbschool/common/widgets/custom_title_panel.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/panel/course_manager/screens/course_manager_screen.dart';
import 'package:mbschool/features/panel/course_manager/services/modify_course_service.dart';
import 'package:mbschool/features/panel/create_course/services/create_course_service.dart';
import 'package:mbschool/features/panel/panel.dart';
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/langue.dart';
import 'package:mbschool/models/niveau.dart';
import 'package:provider/provider.dart';

class ModifyCourseScreen extends StatefulWidget {
  static const routeName = '/modify-course';
  final Cours cours;
  const ModifyCourseScreen({Key? key, required this.cours}) : super(key: key);

  @override
  State<ModifyCourseScreen> createState() => _ModifyCourseScreenState();
}

class _ModifyCourseScreenState extends State<ModifyCourseScreen> {
  final _modifyCourseFormKey = GlobalKey<FormState>();
  ModifyCourseService modifyCourseService = ModifyCourseService();
  TextEditingController titreCoursController = TextEditingController();
  TextEditingController prixCoursController = TextEditingController();
  TextEditingController descriptionCoursController = TextEditingController();
  TextEditingController descriptionCourteCoursController =
      TextEditingController();

  // List<String> items = [
  //   'bsm',
  //   'abc',
  //   'bbc',
  // ];

  List<Langue> langues = [];
  List<Categorie> categories = [];
  List<Niveau> niveaux = [];

  @override
  void initState() {
    super.initState();
    getAllNiveauData();

    getAllLangueData();
    getAllCategorieData();

    titreCoursController.text = widget.cours.titre;
    descriptionCoursController.text = widget.cours.description;
    descriptionCourteCoursController.text = widget.cours.description_courte;
  }

  getAllLangueData() async {
    langues = await createCourseService.getAllLangueData(context);
    setState(() {});
  }

  getAllCategorieData() async {
    categories = await createCourseService.getAllCategorieData(context);
    setState(() {});
  }

  getAllNiveauData() async {
    niveaux = await createCourseService.getAllNiveauData(context);
    setState(() {});
  }

  //SELECTIONNER UNE VIGNETTE
  PlatformFile? vignette;
  Future selectVignette() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result == null) return;

    setState(() {
      vignette = result.files.first;
    });
  }

  @override
  void dispose() {
    super.dispose();
    titreCoursController.dispose();
    prixCoursController.dispose();
    descriptionCoursController.dispose();
    descriptionCourteCoursController.dispose();
  }

  int id_categorie = 0;
  int id_niveau = 0;
  int id_langue = 0;

  bool isCharging = false;

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //     itemCount: langues!.length,
    //     itemBuilder: (BuildContext context, int i) {
    //       return Text("data");
    //     });

    // String dropdownvalue_niveau = widget.cours.id_niveau;

    // String dropdownvalue_langue = widget.cours.id_langue;
    // String dropdownvalue_categorie = widget.cours.id_categorie;
    String? dropdownvalue_niveau;

    String? dropdownvalue_langue;
    String? dropdownvalue_categorie;

    String urlVignette = widget.cours.vignette;
    bool isVignetteNull = false;

    if (widget.cours.titre == titreCoursController.text) {
      titreCoursController.text = widget.cours.titre;
    } else {
      titreCoursController.text = titreCoursController.text;
    }
    if (descriptionCoursController.text == widget.cours.description) {
      descriptionCoursController.text = widget.cours.description;
    } else {
      descriptionCoursController.text = descriptionCoursController.text;
    }

    if (descriptionCourteCoursController.text ==
        widget.cours.description_courte) {
      descriptionCourteCoursController.text = widget.cours.description_courte;
    } else {
      descriptionCourteCoursController.text =
          descriptionCourteCoursController.text;
    }
    modifyCourse() {
      modifyCourseService.modifyCourse(
          context,
          titreCoursController.text,
          descriptionCoursController.text,
          descriptionCourteCoursController.text,
          id_categorie,
          id_niveau,
          id_langue,
          prixCoursController.text,
          vignette!,
          widget.cours,
          vignette != null ? isVignetteNull = false : isVignetteNull = true,
          urlVignette, () {
        setState(() {
          isCharging = false;
          showSnackBar(context, "Le cours a été modifié avec succès");
          Navigator.pushNamed(context, CourseManagerScreen.routeName);
        });
      });
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Modifier cours"),
          elevation: 0,
          backgroundColor: primary,
        ),
        body: langues == null ||
                categories == null ||
                niveaux == null ||
                isCharging == true
            ? const Loader()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _modifyCourseFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTitlePanel(title: "Titre du cours"),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextFieldPanel(
                            hintText: "Titre du cours",
                            prefixIcon: Icons.title_sharp,
                            controller: titreCoursController),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTitlePanel(title: "Description du cours"),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextFieldPanel(
                          hintText: "Description du cours",
                          prefixIcon: Icons.details_rounded,
                          controller: descriptionCoursController,
                          maxLines: 4,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTitlePanel(title: "Courte description du cours"),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextFieldPanel(
                          hintText: "Courte description du cours",
                          prefixIcon: Icons.details_outlined,
                          controller: descriptionCourteCoursController,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        CustomTitlePanel(title: "Categorie"),
                        const SizedBox(
                          height: 15,
                        ),
                        DropdownButtonFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: textWhite,
                              hintStyle: TextStyle(color: Colors.grey.shade300),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            hint: Text("Sélectionner une catégorie"),
                            value: widget.cours.id_categorie,
                            items: categories.map((Categorie item) {
                              return DropdownMenuItem(
                                child: Text(item.nom),
                                value: item.id_categorie,
                              );
                            }).toList(),
                            onChanged: (String? val) {
                              setState(() {
                                dropdownvalue_categorie = val!;
                                id_categorie =
                                    int.parse(dropdownvalue_categorie!);

                                // titreCoursController.text =
                                //     titreCoursController.text;
                                // descriptionCoursController.text =
                                //     descriptionCoursController.text;
                                // descriptionCourteCoursController.text =
                                //     descriptionCourteCoursController.text;
                              });
                            }),
                        SizedBox(
                          height: 15,
                        ),

                        CustomTitlePanel(title: "Niveau"),
                        const SizedBox(
                          height: 15,
                        ),
                        // DROPDOWN BUTTON NIVEAU

                        DropdownButtonFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: textWhite,
                              hintStyle: TextStyle(color: Colors.grey.shade300),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            hint: Text("Sélectionner un niveau"),
                            value: widget.cours.id_niveau,
                            items: niveaux.map((Niveau item) {
                              return DropdownMenuItem(
                                child: Text(item.titre),
                                value: item.id_niveau,
                              );
                            }).toList(),
                            onChanged: (String? val) {
                              setState(() {
                                dropdownvalue_niveau = val!;
                                id_niveau = int.parse(dropdownvalue_niveau!);
                              });
                            }),
                        SizedBox(
                          height: 15,
                        ),

                        CustomTitlePanel(title: "Langue"),
                        const SizedBox(
                          height: 15,
                        ),
                        // DROPDOWN BUTTON LANGUE

                        DropdownButtonFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: textWhite,
                              hintStyle: TextStyle(color: Colors.grey.shade300),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            hint: Text("Sélectionner une langue"),
                            value: widget.cours.id_langue,
                            items: langues.map((Langue item) {
                              return DropdownMenuItem(
                                child: Text(item.nom),
                                value: item.id_langue,
                              );
                            }).toList(),
                            onChanged: (String? val) {
                              setState(() {
                                dropdownvalue_langue = val!;
                                id_langue = int.parse(dropdownvalue_langue!);
                              });
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTitlePanel(title: "Vignette du cours"),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          splashColor: textBlack,
                          onTap: selectVignette,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 100,
                                decoration: const BoxDecoration(
                                    color: textWhite,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),

                                // child: vignette != null ? Text(vignette!.path!) : Text(""),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  vignette != null
                                      ? Image.file(
                                          File(vignette!.path!),
                                          width: 100,
                                          height: 100,
                                        )
                                      : urlVignette.isNotEmpty
                                          ? Container(
                                              width: 150,
                                              height: 150,
                                              child: Image.network(
                                                urlVignette,
                                                width: 20,
                                                height: 20,
                                              ))
                                          : Text(""),
                                  Container(
                                    height: 30,
                                    width: 150,
                                    decoration: const BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.all(
                                            const Radius.circular(8))),
                                    child: const Center(
                                        child: const Text(
                                      "Choisir une vignette",
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
                        SizedBox(
                          height: 15,
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                            splashColor: textBlack,
                            borderRadius: BorderRadius.circular(17.5),
                            onTap: () {
                              if (_modifyCourseFormKey.currentState!
                                  .validate()) {
                                // if (vignette == null) {
                                //   showDialog(
                                //       context: context,
                                //       builder: (context) => AlertDialogError(
                                //           texte: "Veuillez choisir une image"));
                                // } else {
                                setState(() {
                                  isCharging = true;
                                  if (id_categorie == 0)
                                    id_categorie =
                                        int.parse(widget.cours.id_categorie);
                                  if (id_niveau == 0)
                                    id_niveau =
                                        int.parse(widget.cours.id_niveau);
                                  if (id_langue == 0)
                                    id_langue =
                                        int.parse(widget.cours.id_langue);
                                });
                                modifyCourse();
                                // }
                                //Si dans le droplist rien n'a été choisi zero sera envoyé or zero ne figure pas comme id dans la table parente donc

                                print("cat $id_categorie");
                                print("lan $id_langue");
                                print("niv $id_niveau");
                              }
                            },
                            child: CustomButtonBox(title: "Modifier")),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
