import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/animations/slide_down_tween.dart';
import 'package:mbschool/common/widgets/custom_app_bar_panel.dart';
import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/common/widgets/custom_button_box_panel.dart';
import 'package:mbschool/common/widgets/custom_textfield_exigence.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/admin/admin/screens/edit_categorie_screen.dart';
import 'package:mbschool/features/admin/admin/services/categorie_service.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/features/panel/course_manager/services/exigence_service.dart';
import 'package:mbschool/features/panel/course_manager/services/resultat_service.dart';
import 'package:mbschool/features/panel/create_course/services/create_course_service.dart';
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/exigence.dart';
import 'package:mbschool/models/resultat.dart';

class CategorieScreen extends StatefulWidget {
  static const routeName = 'categorie-screen';
  const CategorieScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CategorieScreen> createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  TextEditingController categorieController = TextEditingController();
  TextEditingController modifyCategorieController = TextEditingController();
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  bool isCharging = false;
  CategorieService categorieService = CategorieService();
  CreateCourseService createCourseService = CreateCourseService();
  List<Categorie> categories = [];
  final _addCategorieFormKey = GlobalKey<FormState>();

  void addCategorie() {
    categorieService.addCategorie(context, categorieController.text, () {
      setState(() {
        categorieController.text = "";
        getAllCategories();
        isCharging = false;
      });
    });

    showSnackBar(context, "Categorie ajout?? avec succ??s");
  }

  void deleteCategorie(Categorie categorie) {
    categorieService.deleteCategorie(context, categorie, () {
      setState(() {
        // categorieController.text = "";
        Navigator.pop(context);
        getAllCategories();
        isCharging = false;
      });
    });

    showSnackBar(context, "Categorie supprim?? avec succ??s");
  }

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  void getAllCategories() async {
    categories = await createCourseService.getAllCategorieData(context);
    setState(() {});
  }

  @override
  void dispose() {
    categorieController.dispose();
    modifyCategorieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBarPanel(texte: "categories"),
        body: isCharging == true || categories == null
            ? Loader()
            : Form(
                key: _addCategorieFormKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(appPadding - 15),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextFieldExigence(
                                hintText: "Cat??gorie",
                                controller: categorieController),
                            IconButton(
                                onPressed: () {
                                  if (_addCategorieFormKey.currentState!
                                      .validate()) {
                                    // print(_listcategories.length);
                                    setState(() {
                                      isCharging = true;
                                      addCategorie();
                                      getAllCategories();
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.send_rounded,
                                  color: primary,
                                ))
                          ],
                        ),
                        for (int i = 0; i < categories.length; i++)
                          SlideDownTween(
                            duration: Duration(milliseconds: (i + 1) * 500),
                            offset: 40,
                            child: Container(
                                margin: EdgeInsets.only(top: 8.0),
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: third,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        categories[i].nom,
                                        style: TextStyle(color: textWhite),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) =>
                                                            AlertDialog(
                                                              title: Text(
                                                                  "Notification"),
                                                              content:
                                                                  isCharging ==
                                                                          true
                                                                      ? Loader()
                                                                      : Container(
                                                                          height:
                                                                              90,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Text(
                                                                                "Voulez vous supprimer la cat??gorie?",
                                                                                style: TextStyle(fontSize: 14),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: appPadding,
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                children: [
                                                                                  InkWell(
                                                                                      onTap: () {
                                                                                        // Navigator.pop(context);
                                                                                        setState(() {
                                                                                          isCharging = true;
                                                                                          deleteCategorie(categories[i]);
                                                                                        });
                                                                                      },
                                                                                      splashColor: Colors.grey.shade200,
                                                                                      child: Container(
                                                                                        alignment: Alignment.center,
                                                                                        width: 40,
                                                                                        height: 30,
                                                                                        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(15)),
                                                                                        child: Text(
                                                                                          "Oui",
                                                                                          style: TextStyle(color: textWhite),
                                                                                        ),
                                                                                      )),
                                                                                  InkWell(
                                                                                      onTap: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      splashColor: Colors.grey.shade200,
                                                                                      child: Container(
                                                                                        alignment: Alignment.center,
                                                                                        width: 40,
                                                                                        height: 30,
                                                                                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                                                                                        child: Text(
                                                                                          "Non",
                                                                                          style: TextStyle(color: textWhite),
                                                                                        ),
                                                                                      )),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                            ));
                                              },
                                              icon: Icon(
                                                Icons.delete_outline_rounded,
                                                color: textWhite,
                                              )),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  EditCategorieScreen
                                                      .routeName, arguments: categories[i]);
                                            },
                                            icon: Icon(
                                              Icons.edit_outlined,
                                              color: textWhite,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
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
