import 'package:flutter/material.dart';
import 'package:mbschool/common/animations/slide_down_tween.dart';
import 'package:mbschool/common/widgets/custom_app_bar_panel.dart';
import 'package:mbschool/common/widgets/custom_textfield_exigence.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/admin/admin/screens/edit_categorie_screen.dart';
import 'package:mbschool/features/admin/admin/services/categorie_service.dart';
import 'package:mbschool/features/panel/create_course/services/create_course_service.dart';
import 'package:mbschool/models/categorie.dart';

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
  bool isCharging = false;
  CategorieService categorieService = CategorieService();
  CreateCourseService createCourseService = CreateCourseService();
  late Future<List<Categorie>> categories;
  final _addCategorieFormKey = GlobalKey<FormState>();

  void addCategorie() {
    categorieService.addCategorie(context, categorieController.text, () {
      setState(() {
        categorieController.text = "";
        getAllCategories();
        isCharging = false;
      });
    });

    showSnackBar(context, "Categorie ajouté avec succès");
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

    showSnackBar(context, "Categorie supprimé avec succès");
  }

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  void getAllCategories() {
    categories = createCourseService.getAllCategorieData(context);
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
            ? const Loader()
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
                                hintText: "Catégorie",
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
                                icon: const Icon(
                                  Icons.send_rounded,
                                  color: primary,
                                ))
                          ],
                        ),
                        FutureBuilder(
                            future: categories,
                            builder: (context,
                                AsyncSnapshot<List<Categorie>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, i) {
                                      return SlideDownTween(
                                        duration: Duration(
                                            milliseconds: (i + 1) * 500),
                                        offset: 40,
                                        child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 8.0),
                                            height: 50,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: third,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data![i].nom,
                                                    style: const TextStyle(
                                                        color: textWhite),
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        AlertDialog(
                                                                          title:
                                                                              const Text("Notification"),
                                                                          content: isCharging == true
                                                                              ? const Loader()
                                                                              : SizedBox(
                                                                                  height: 90,
                                                                                  child: Column(
                                                                                    children: [
                                                                                      const Text(
                                                                                        "Voulez vous supprimer la catégorie?",
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
                                                                                                  deleteCategorie(snapshot.data![i]);
                                                                                                });
                                                                                              },
                                                                                              splashColor: Colors.grey.shade200,
                                                                                              child: Container(
                                                                                                alignment: Alignment.center,
                                                                                                width: 40,
                                                                                                height: 30,
                                                                                                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(15)),
                                                                                                child: const Text(
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
                                                                                                child: const Text(
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
                                                          icon: const Icon(
                                                            Icons
                                                                .delete_outline_rounded,
                                                            color: textWhite,
                                                          )),
                                                      IconButton(
                                                        onPressed: () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              EditCategorieScreen
                                                                  .routeName,
                                                              arguments: snapshot
                                                                  .data![i]);
                                                        },
                                                        icon: const Icon(
                                                          Icons.edit_outlined,
                                                          color: textWhite,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )),
                                      );
                                    });
                              } else {
                                return const Loader();
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
