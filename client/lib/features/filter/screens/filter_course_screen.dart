import 'package:flutter/material.dart';

import 'package:mbschool/common/widgets/alert_notification.dart';
import 'package:mbschool/common/widgets/custom_title_panel.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';

import 'package:mbschool/features/course/screens/all_course_screen.dart';
import 'package:mbschool/features/filter/services/filter_service.dart';
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/langue.dart';
import 'package:mbschool/models/niveau.dart';

class FilterCourseScreen extends StatefulWidget {
  const FilterCourseScreen({Key? key, required this.controller})
      : super(key: key);

  final ScrollController? controller;
  static const routeName = '/filter-course-screen';

  @override
  State<FilterCourseScreen> createState() => _FilterCourseScreenState();
}

class _FilterCourseScreenState extends State<FilterCourseScreen> {
  final FilterService _filterService = FilterService();

  List<Langue>? langues;
  List<Categorie>? categories;
  List<Niveau>? niveaux;
  List<Cours> cours = [];
  late Future<List<Cours>> filterCours;

  bool isChecked = false;
  int selectedCategory = 0;
  int selectedNiveau = 0;
  int selectedLangue = 0;

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

  void filterCourses(int id_categorie, id_niveau, id_langue) async {
    cours = await _filterService.filterCourses(
        context, id_categorie, id_niveau, id_langue);
        filterCours =  _filterService.filterCourses(
        context, id_categorie, id_niveau, id_langue);
    setState(() {
      Navigator.pop(context);
      Future.delayed(const Duration(milliseconds: 200), () {
        Navigator.pushNamed(context, AllCourseScreen.routeName,
            arguments: filterCours);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  int id_categorie = 0;
  int id_niveau = 0;
  int id_langue = 0;

  bool isCharging = false;

  @override
  Widget build(BuildContext context) {
    // categories != null ? categories![0].id_categorie : "0";

    //Si dans le droplist rien n'a été choisi zero sera envoyé or zero ne figure pas comme id dans la table parente donc
    // if (id_categorie == 0) id_categorie = int.parse(dropdownvalue_categorie);
    // if (id_niveau == 0) id_niveau = int.parse(dropdownvalue_niveau);
    // if (id_langue == 0) id_langue = int.parse(dropdownvalue_langue);

    return Container(
      // appBar: PreferredSize(
      //   child: Container(
      //     decoration: BoxDecoration(
      //         color: Colors.transparent,
      //         border: Border(bottom: BorderSide(color: textBlack, width: 0.2))),
      //     child: Padding(
      //       padding: const EdgeInsets.all(appPadding),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Text(
      //             "Filtrer les cours",
      //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      //           ),
      //           IconButton(
      //               onPressed: () {
      //                 Navigator.pop(context);
      //               },
      //               icon: FaIcon(FontAwesomeIcons.circleXmark))
      //         ],
      //       ),
      //     ),
      //   ),
      //   preferredSize: Size.fromHeight(55),
      // ),
      child: categories == null || langues == null || niveaux == null
          ? const Loader()
          : SingleChildScrollView(
              controller: widget.controller,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 70,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(7)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = 0;
                              selectedLangue = 0;
                              selectedNiveau = 0;
                            });
                          },
                          child: const Text(
                            "Réintialiser",
                            style: TextStyle(
                                color: textBlack, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Text(
                          "Filtrer ",
                          style: TextStyle(
                              color: textBlack, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (selectedCategory == 0 &&
                                selectedLangue == 0 &&
                                selectedNiveau == 0) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertNotification(
                                      message: 'Aucune donnée choisie',
                                    );
                                  });
                            } else {
                              filterCourses(selectedCategory, selectedNiveau,
                                  selectedLangue);
                            }
                          },
                          child: cours == null
                              ? const Loader()
                              : const Text(
                                  "Terminé",
                                  style: TextStyle(
                                      color: primary,
                                      fontWeight: FontWeight.w500),
                                ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 0.1,
                      color: textBlack,
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    const CustomTitlePanel(title: "CATEGORIE"),
                    const SizedBox(
                      height: 15,
                    ),
                    // DropdownButtonFormField(
                    //     decoration: InputDecoration(
                    //       filled: true,
                    //       fillColor: textWhite,
                    //       hintStyle: TextStyle(color: Colors.grey.shade300),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.transparent),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.transparent),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //     ),
                    //     hint: Text("Sélectionner une catégorie"),
                    //     value: dropdownvalue_categorie,
                    //     items: categories!.map((Categorie item) {
                    //       return DropdownMenuItem(
                    //         child: Text(item.nom.toUpperCase()),
                    //         value: item.id_categorie,
                    //       );
                    //     }).toList(),
                    //     onChanged: (String? val) {
                    //       setState(() {
                    //         dropdownvalue_categorie = val!;
                    //         // id_categorie =
                    //         //     int.parse(dropdownvalue_categorie!);
                    //       });
                    //     }),

                    Wrap(
                        direction: Axis.horizontal,
                        spacing: 9.1,
                        alignment: WrapAlignment.center,
                        runSpacing: 6.0,
                        children: [
                          for (var i = 0; i < categories!.length; i++)
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedCategory =
                                      int.parse(categories![i].id_categorie);
                                });
                              },
                              child: Container(
                                // alignment: Alignment.center,
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  top: 5.0,
                                  bottom: 5.0,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    border: Border.all(
                                      color: selectedCategory ==
                                              int.parse(
                                                  categories![i].id_categorie)
                                          ? primary
                                          : Colors.grey.shade500,
                                    )),
                                child: Text(
                                  categories![i].nom,
                                  style: TextStyle(
                                    color: selectedCategory ==
                                            int.parse(
                                                categories![i].id_categorie)
                                        ? primary
                                        : Colors.grey.shade500,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            )
                        ]),

                    const SizedBox(
                      height: 25,
                    ),

                    const CustomTitlePanel(title: "NIVEAU"),
                    const SizedBox(
                      height: 15,
                    ),
                    Wrap(
                        direction: Axis.vertical,
                        spacing: 9.1,
                        alignment: WrapAlignment.center,
                        runSpacing: 6.0,
                        children: [
                          for (var i = 0; i < niveaux!.length; i++)
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedNiveau =
                                      int.parse(niveaux![i].id_niveau);
                                });
                              },
                              child: Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: Colors.grey.shade200,
                                  ))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        niveaux![i].titre,
                                        style: TextStyle(
                                          color: selectedNiveau ==
                                                  int.parse(
                                                      niveaux![i].id_niveau)
                                              ? primary
                                              : Colors.grey.shade600,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      selectedNiveau ==
                                              int.parse(niveaux![i].id_niveau)
                                          ? const Icon(
                                              Icons.check,
                                              color: primary,
                                            )
                                          : Container()
                                    ],
                                  )),
                            )
                        ]),

                    const SizedBox(
                      height: 25,
                    ),

                    const CustomTitlePanel(title: "LANGUE"),
                    const SizedBox(
                      height: 15,
                    ),
                    Wrap(
                        direction: Axis.vertical,
                        spacing: 9.1,
                        alignment: WrapAlignment.center,
                        runSpacing: 6.0,
                        children: [
                          for (var i = 0; i < langues!.length; i++)
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedLangue =
                                      int.parse(langues![i].id_langue);
                                });
                              },
                              child: Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: Colors.grey.shade200,
                                  ))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        langues![i].nom,
                                        style: TextStyle(
                                          color: selectedLangue ==
                                                  int.parse(
                                                      langues![i].id_langue)
                                              ? primary
                                              : Colors.grey.shade600,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      selectedLangue ==
                                              int.parse(langues![i].id_langue)
                                          ? const Icon(
                                              Icons.check,
                                              color: primary,
                                            )
                                          : Container()
                                    ],
                                  )),
                            )
                        ])

                    // DropdownButtonFormField(
                    //     decoration: InputDecoration(
                    //       filled: true,
                    //       fillColor: textWhite,
                    //       hintStyle: TextStyle(color: Colors.grey.shade300),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.transparent),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.transparent),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //     ),
                    //     hint: Text("Sélectionner un niveau"),
                    //     value: dropdownvalue_niveau,
                    //     items: niveaux!.map((Niveau item) {
                    //       return DropdownMenuItem(
                    //         child: Text(item.titre.toUpperCase()),
                    //         value: item.id_niveau,
                    //       );
                    //     }).toList(),
                    //     onChanged: (String? val) {
                    //       setState(() {
                    //         dropdownvalue_niveau = val!;
                    //         // id_niveau = int.parse(dropdownvalue_niveau);
                    //       });
                    //     }),
                    // SizedBox(
                    //   height: 15,
                    // ),

                    // CustomTitlePanel(title: "Langue"),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // // DROPDOWN BUTTON LANGUE

                    // DropdownButtonFormField(
                    //     decoration: InputDecoration(
                    //       filled: true,
                    //       fillColor: textWhite,
                    //       // hintText: "Sélectionner une langue",
                    //       hintStyle: TextStyle(color: Colors.grey.shade300),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.transparent),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.transparent),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //     ),
                    //     hint: Text("Sélectionner une langue"),
                    //     value: dropdownvalue_langue,
                    //     items: langues!.map((Langue item) {
                    //       return DropdownMenuItem(
                    //         child: Text(item.nom.toUpperCase()),
                    //         value: item.id_langue,
                    //       );
                    //     }).toList(),
                    //     onChanged: (String? val) {
                    //       setState(() {
                    //         dropdownvalue_langue = val!;
                    //         // id_langue = int.parse(dropdownvalue_langue);
                    //       });
                    //     }),
                    // SizedBox(
                    //   height: 15,
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}
