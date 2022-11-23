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
import 'package:mbschool/common/widgets/navigation_drawer_admin.dart';
import 'package:mbschool/common/widgets/navigation_drawer_teacher.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/panel/course_manager/screens/course_manager_screen.dart';
import 'package:mbschool/features/panel/create_course/services/create_course_service.dart';
import 'package:mbschool/features/panel/panel.dart';
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/models/langue.dart';
import 'package:mbschool/models/niveau.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CreateCourseScreen extends StatefulWidget {
  static const routeName = '/create_course';
  const CreateCourseScreen({Key? key}) : super(key: key);

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  final _createCourseFormKey = GlobalKey<FormState>();
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

  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    getAllNiveauData();

    getAllLangueData();
    getAllCategorieData();
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
    String? dropdownvalue_niveau;

    String? dropdownvalue_langue;
    String? dropdownvalue_categorie;
    // return ListView.builder(
    //     itemCount: langues!.length,
    //     itemBuilder: (BuildContext context, int i) {
    //       return Text("data");
    //     });
    // String dropdownvalue_niveau = niveaux != null ? niveaux[0].id_niveau : "";

    // String dropdownvalue_langue = langues != null ? langues[0].id_langue : "";
    // String dropdownvalue_categorie =
    //     categories != null ? categories[0].id_categorie : "";

    //Si dans le droplist rien n'a été choisi zero sera envoyé or zero ne figure pas comme id dans la table parente donc
    // if (id_categorie == 0) id_categorie = int.parse(dropdownvalue_categorie);
    // if (id_niveau == 0) id_niveau = int.parse(dropdownvalue_niveau);
    // if (id_langue == 0) id_langue = int.parse(dropdownvalue_langue);

    createCourse() {
      createCourseService.createCourse(
          context,
          titreCoursController.text,
          descriptionCoursController.text,
          descriptionCourteCoursController.text,
          id_categorie,
          id_niveau,
          id_langue,
          prixCoursController.text,
          isChecked,
          vignette!, 
          () {
        setState(() {
          isCharging = false;
          showSnackBar(context, "Le cours a été avec succès");
          Navigator.pushNamed(context, CourseManagerScreen.routeName);
        });
      });
    }
    final user = Provider.of<UserProvider>(context).user;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        drawer: user.role == "1"
            ? Container()
            : user.role == "2"
                ? const NavigatorDrawerTeacher()
                : NavigatorDrawerAdmin(),
        appBar: AppBar(
          title: const Text("Créer un nouveau cours"),
          elevation: 0,
          backgroundColor: primary,
        ),
        body: langues == null || isCharging == true
            ? const Loader()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _createCourseFormKey,
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
                            value: dropdownvalue_categorie,
                            items: categories.map((Categorie item) {
                              return DropdownMenuItem(
                                child: Text(item.nom.toUpperCase()),
                                value: item.id_categorie,
                              );
                            }).toList(),
                            onChanged: (String? val) {
                              setState(() {
                                dropdownvalue_categorie = val!;
                                id_categorie =
                                    int.parse(dropdownvalue_categorie!);
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
                            value: dropdownvalue_niveau,
                            items: niveaux.map((Niveau item) {
                              return DropdownMenuItem(
                                child: Text(item.titre.toUpperCase()),
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
                              // hintText: "Sélectionner une langue",
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
                            value: dropdownvalue_langue,
                            items: langues.map((Langue item) {
                              return DropdownMenuItem(
                                child: Text(item.nom.toUpperCase()),
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
                        Row(
                          children: [
                            Checkbox(
                                fillColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return primary;
                                  }
                                  return primary;
                                }),
                                value: isChecked,
                                onChanged: (val) {
                                  setState(() {
                                    isChecked = val!;
                                  });
                                }),
                            Text("Cocher si le cours est gratuit")
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        isChecked == false
                            ? CustomTextFieldPanel(
                                hintText: "Prix du cours",
                                prefixIcon: Icons.price_change,
                                controller: prixCoursController,
                                keyboardType: TextInputType.number,
                              )
                            : Text(""),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                            splashColor: textBlack,
                            borderRadius: BorderRadius.circular(17.5),
                            onTap: () {
                              if (_createCourseFormKey.currentState!
                                  .validate()) {
                                if (vignette == null) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialogError(
                                          texte: "Veuillez choisir une image"));
                                } else {
                                  setState(() {
                                    isCharging = true;
                                  });
                                  createCourse();
                                }
                              }
                            },
                            child: CustomButtonBox(title: "Créer")),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
