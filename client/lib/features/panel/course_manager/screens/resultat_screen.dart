import 'package:flutter/material.dart';

import 'package:mbschool/common/animations/slide_down_tween.dart';
import 'package:mbschool/common/widgets/custom_app_bar_panel.dart';

import 'package:mbschool/common/widgets/custom_textfield_exigence.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/panel/course_manager/services/resultat_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/resultat.dart';

class ResultatScreen extends StatefulWidget {
  static const routeName = 'resultat-screen';
  final Cours cours;
  const ResultatScreen({Key? key, required this.cours}) : super(key: key);

  @override
  State<ResultatScreen> createState() => _ResultatScreenState();
}

class _ResultatScreenState extends State<ResultatScreen> {
  TextEditingController resultatController = TextEditingController();
  bool isCharging = false;
  ResultatService resultatService = ResultatService();
  List<Resultat> resultats = [];
  final _addResultatFormKey = GlobalKey<FormState>();

  void addResultat() {
    resultatService.addResultat(context, resultatController.text, widget.cours,
        () {
      setState(() {
        resultatController.text = "";
        getAllResultats();
        isCharging = false;
      });
    });

    showSnackBar(context, "Resultat ajouté avec succès");
  }

  void deleteResultat(Resultat exigence) {
    resultatService.deleteResultat(context, exigence, () {
      setState(() {
        // resultatController.text = "";
        getAllResultats();
        isCharging = false;
      });
    });

    showSnackBar(context, "Resultat supprimé avec succès");
  }

  @override
  void initState() {
    super.initState();
    getAllResultats();
  }

  void getAllResultats() async {
    resultats = await resultatService.getAllResultats(context, widget.cours);
    setState(() {});
  }

  @override
  void dispose() {
    resultatController.dispose();
    super.dispose();
  }

 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBarPanel(texte: "Resultats"),
        body: isCharging == true || resultats == null
            ? const Loader()
            : Form(
                key: _addResultatFormKey,
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
                                hintText: "Resultat",
                                controller: resultatController),
                            IconButton(
                                onPressed: () {
                                  if (_addResultatFormKey.currentState!
                                      .validate()) {
                                    // print(_listResultats.length);
                                    setState(() {
                                      isCharging = true;
                                      addResultat();
                                      getAllResultats();
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.send_rounded,
                                  color: primary,
                                ))
                          ],
                        ),

                        for (int i = 0; i < resultats.length; i++)
                          SlideDownTween(
                            duration: Duration(milliseconds: (i + 1) * 500),
                            offset: 40,
                            child: Card(
                              color: third,
                              child: ListTile(
                                title: Text(
                                  resultats[i].titre,
                                  style: const TextStyle(color: textWhite),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isCharging = true;
                                        deleteResultat(resultats[i]);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline_rounded,
                                      color: textWhite,
                                    )),
                              ),
                            ),
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
