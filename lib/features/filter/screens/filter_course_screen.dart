import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbschool/common/widgets/custom_title_panel.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/models/langue.dart';
import 'package:mbschool/models/niveau.dart';

class FilterCourseScreen extends StatefulWidget {
  const FilterCourseScreen({Key? key}) : super(key: key);

  static const routeName = '/filter-course-screen';

  @override
  State<FilterCourseScreen> createState() => _FilterCourseScreenState();
}

class _FilterCourseScreenState extends State<FilterCourseScreen> {
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
    setState(() {
      
    });
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

  int id_categorie = 0;
  int id_niveau = 0;
  int id_langue = 0;

  bool isCharging = false;

  @override
  Widget build(BuildContext context) {
    // String dropdownvalue_niveau = niveaux != null ? niveaux![0].id_niveau : "";

    // String dropdownvalue_langue = langues != null ? langues![0].id_langue : "";
    String dropdownvalue_categorie =
        categories != null ? categories![0].id_categorie : "";

    //Si dans le droplist rien n'a été choisi zero sera envoyé or zero ne figure pas comme id dans la table parente donc
    if (id_categorie == 0) id_categorie = int.parse(dropdownvalue_categorie); 
    // if (id_niveau == 0) id_niveau = int.parse(dropdownvalue_niveau); 
    // if (id_langue == 0) id_langue = int.parse(dropdownvalue_langue); 

    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(
                  bottom: BorderSide(
                color: textBlack,
                width: 0.2
              ))),
              child: Padding(
                padding: const EdgeInsets.all(appPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Filtrer les cours", style: TextStyle(fontSize: 20),),
                    IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.circleXmark))
                  ],
                ),
              ),
        ),
        preferredSize: Size.fromHeight(55),
      ),

      body: categories == null || isCharging == true
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
                                id_categorie =
                                    int.parse(dropdownvalue_categorie);
                              });
                            }),
                        SizedBox(
                          height: 15,
                        ),

                        // CustomTitlePanel(title: "Niveau"),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // // DROPDOWN BUTTON NIVEAU

                        // DropdownButtonFormField(
                        //     decoration: InputDecoration(
                        //       filled: true,
                        //       fillColor: textWhite,
                        //       hintText: "Selectionner",
                        //       hintStyle: TextStyle(color: Colors.grey.shade300),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide:
                        //             BorderSide(color: Colors.transparent),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide:
                        //             BorderSide(color: Colors.transparent),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //     ),
                        //     value: dropdownvalue_niveau,
                        //     items: niveaux!.map((Niveau item) {
                        //       return DropdownMenuItem(
                        //         child: Text(item.titre),
                        //         value: item.id_niveau,
                        //       );
                        //     }).toList(),
                        //     onChanged: (String? val) {
                        //       setState(() {
                        //         dropdownvalue_niveau = val!;
                        //         id_niveau = int.parse(dropdownvalue_niveau);
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
                        //       hintText: "Selectionner",
                        //       hintStyle: TextStyle(color: Colors.grey.shade300),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide:
                        //             BorderSide(color: Colors.transparent),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide:
                        //             BorderSide(color: Colors.transparent),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //     ),
                        //     value: dropdownvalue_langue,
                        //     items: langues!.map((Langue item) {
                        //       return DropdownMenuItem(
                        //         child: Text(item.nom),
                        //         value: item.id_langue,
                        //       );
                        //     }).toList(),
                        //     onChanged: (String? val) {
                        //       setState(() {
                        //         dropdownvalue_langue = val!;
                        //         id_langue = int.parse(dropdownvalue_langue);
                        //       });
                        //     }),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        
                      ],
                    ),
                  ),
                ),
              ),
      
    );
  }
}
