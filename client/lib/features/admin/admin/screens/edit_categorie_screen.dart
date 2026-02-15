import 'package:flutter/material.dart';
import 'package:mbschool/common/widgets/custom_textfield_panel.dart';
import 'package:mbschool/common/widgets/custom_title_panel.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/admin/admin/screens/categorie_screen.dart';
import 'package:mbschool/features/admin/admin/services/categorie_service.dart';
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/models/section.dart';

class EditCategorieScreen extends StatefulWidget {
  static const routeName = '/edit-categorie-screen';

  const EditCategorieScreen({Key? key, required this.categorie}) : super(key: key);
  final Categorie categorie;

  @override
  State<EditCategorieScreen> createState() => _EditCategorieScreenState();
}

class _EditCategorieScreenState extends State<EditCategorieScreen> {
  List<Section> sections = [];
  TextEditingController nomCategorieController = TextEditingController();
  final _editCategorieFormKey = GlobalKey<FormState>();
  CategorieService categorieService = CategorieService();
  bool isCharging = false;

  @override
  @override
  void dispose() {
    nomCategorieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    void editCategorie() {
      categorieService.editCategorie(
          context, widget.categorie, nomCategorieController.text, () {
        setState(() {
          isCharging = false;
          showSnackBar(context, "Catégorie modifiée");
          Navigator.of(context)
            ..pop()
            ..pop()
            ..pop()
            ..pushNamed(CategorieScreen.routeName);
        });
      });
    }

    

    if (isCharging == false) {
      nomCategorieController.text = widget.categorie.nom;
    } else {
      nomCategorieController.text = nomCategorieController.text;
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
                title: const Text('Modifier la catégorie'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _editCategorieFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTitlePanel(title: "Titre de la section"),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFieldPanel(
                          hintText: "Titre de la section",
                          prefixIcon: Icons.title_sharp,
                          controller: nomCategorieController),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_editCategorieFormKey.currentState!
                              .validate()) {
                            setState(() {
                              isCharging = true;
                            });
                            editCategorie();
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
                            "Modifier catégorie",
                            style: TextStyle(
                                color: textWhite,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
