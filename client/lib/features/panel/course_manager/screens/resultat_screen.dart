import 'package:flutter/material.dart';

import 'package:mbschool/core/common/animations/slide_down_tween.dart';
import 'package:mbschool/core/common/widgets/custom_app_bar_panel.dart';

import 'package:mbschool/core/common/widgets/custom_textfield_exigence.dart';
import 'package:mbschool/core/common/widgets/loader.dart';
import 'package:mbschool/core/constants/colors.dart';
import 'package:mbschool/core/constants/padding.dart';
import 'package:mbschool/core/constants/utils.dart';
import 'package:mbschool/features/panel/course_manager/services/resultat_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/resultat.dart';

class ResultatScreen extends StatefulWidget {
  static const routeName = 'resultat-screen';
  final Cours cours;
  const ResultatScreen({super.key, required this.cours});

  @override
  State<ResultatScreen> createState() => _ResultatScreenState();
}

class _ResultatScreenState extends State<ResultatScreen> {
  TextEditingController resultatController = TextEditingController();
  bool isCharging = false;
  ResultatService resultatService = ResultatService();
  late Future<List<Resultat>> resultats;
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

  void getAllResultats() {
    resultats = resultatService.getAllResultats(context, widget.cours);
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
        appBar: customAppBarPanel(texte: "Resultats"),
        body: isCharging == true
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
                        FutureBuilder(
                            future: resultats,
                            builder: (context,
                                AsyncSnapshot<List<Resultat>> snapshot) {
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
                                        child: Card(
                                          color: third,
                                          child: ListTile(
                                            title: Text(
                                              snapshot.data![i].titre,
                                              style: const TextStyle(
                                                  color: textWhite),
                                            ),
                                            trailing: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    isCharging = true;
                                                    deleteResultat(
                                                        snapshot.data![i]);
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.delete_outline_rounded,
                                                  color: textWhite,
                                                )),
                                          ),
                                        ),
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
