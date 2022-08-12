import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/common/widgets/custom_dropdown_button_langue.dart';
import 'package:mbschool/common/widgets/custom_textfield_panel.dart';
import 'package:mbschool/common/widgets/custom_title_panel.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/features/panel/create_course/services/create_course_service.dart';
import 'package:mbschool/features/panel/panel.dart';
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/models/langue.dart';
import 'package:mbschool/models/niveau.dart';
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

  List<Langue>? langues;
  List<Categorie>? categories;
  List<Niveau>? niveaux;

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
  }

  getAllNiveauData() async {
    niveaux = await createCourseService.getAllNiveauData(context);
  }

  @override
  void dispose() {
    super.dispose();
    titreCoursController.dispose();
    prixCoursController.dispose();
    descriptionCoursController.dispose();
    descriptionCourteCoursController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //     itemCount: langues!.length,
    //     itemBuilder: (BuildContext context, int i) {
    //       return Text("data");
    //     });
    String dropdownvalue_niveau = niveaux != null ? niveaux![0].id_niveau : "";

    String dropdownvalue_langue = langues != null ? langues![0].id_langue : "";
    String dropdownvalue_categorie =
        categories != null ? categories![0].id_categorie : "";

    createCourse() {
      createCourseService.createCourse(
          context,
          titreCoursController.text,
          descriptionCoursController.text,
          descriptionCourteCoursController.text,
          dropdownvalue_categorie,
          dropdownvalue_niveau,
          dropdownvalue_langue,
          prixCoursController.text,
          isChecked);
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: const Text("Créer un nouveau cours"),
          elevation: 0,
          backgroundColor: primary,
        ),
        body: langues == null
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
                              hintText: "Selectionner",
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
                            value: dropdownvalue_categorie,
                            items: categories!.map((Categorie item) {
                              return DropdownMenuItem(
                                child: Text(item.nom),
                                value: item.id_categorie,
                              );
                            }).toList(),
                            onChanged: (String? val) {
                              setState(() {
                                dropdownvalue_categorie = val!;
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
                              hintText: "Selectionner",
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
                            value: dropdownvalue_niveau,
                            items: niveaux!.map((Niveau item) {
                              return DropdownMenuItem(
                                child: Text(item.titre),
                                value: item.id_niveau,
                              );
                            }).toList(),
                            onChanged: (String? val) {
                              setState(() {
                                dropdownvalue_niveau = val!;
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
                              hintText: "Selectionner",
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
                            value: dropdownvalue_langue,
                            items: langues!.map((Langue item) {
                              return DropdownMenuItem(
                                child: Text(item.nom),
                                value: item.id_langue,
                              );
                            }).toList(),
                            onChanged: (String? val) {
                              setState(() {
                                dropdownvalue_langue = val!;
                              });
                            }),
                        const SizedBox(
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
                                createCourse();
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
