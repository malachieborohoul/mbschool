import 'package:flutter/material.dart';
import 'package:mbschool/common/widgets/custom_textfield_panel.dart';
import 'package:mbschool/common/widgets/custom_title_panel.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/admin/admin/screens/langue_screen.dart';
import 'package:mbschool/features/admin/admin/services/langue_service.dart';
import 'package:mbschool/models/langue.dart';
import 'package:mbschool/models/section.dart';

class EditLangueScreen extends StatefulWidget {
  static const routeName = '/edit-langue-screen';

  const EditLangueScreen({Key? key, required this.langue}) : super(key: key);
  final Langue langue;

  @override
  State<EditLangueScreen> createState() => _EditLangueScreenState();
}

class _EditLangueScreenState extends State<EditLangueScreen> {
  List<Section> sections = [];
  TextEditingController nomLangueController = TextEditingController();
  final _editLangueFormKey = GlobalKey<FormState>();
  LangueService langueService = LangueService();
  bool isCharging = false;

  @override
  @override
  void dispose() {
    nomLangueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void editLangue() {
      langueService.editLangue(context, widget.langue, nomLangueController.text,
          () {
        setState(() {
          isCharging = false;
          showSnackBar(context, "Langue modifiée");
          Navigator.of(context)
            ..pop()
            ..pop()
            ..pop()
            ..pushNamed(LangueScreen.routeName);
        });
      });
    }

    if (isCharging == false) {
      nomLangueController.text = widget.langue.nom;
    } else {
      nomLangueController.text = nomLangueController.text;
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
                title: const Text('Modifier la langue'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _editLangueFormKey,
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
                          controller: nomLangueController),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_editLangueFormKey.currentState!.validate()) {
                            setState(() {
                              isCharging = true;
                            });
                            editLangue();
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
                            "Modifier langue",
                            style: TextStyle(
                                color: textWhite, fontWeight: FontWeight.bold),
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
