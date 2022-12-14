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
import 'package:mbschool/features/admin/admin/screens/edit_langue_screen.dart';
import 'package:mbschool/features/admin/admin/services/langue_service.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/features/panel/course_manager/services/exigence_service.dart';
import 'package:mbschool/features/panel/course_manager/services/resultat_service.dart';
import 'package:mbschool/features/panel/create_course/services/create_course_service.dart';
import 'package:mbschool/models/langue.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/exigence.dart';
import 'package:mbschool/models/resultat.dart';

class LangueScreen extends StatefulWidget {
  static const routeName = 'langue-screen';
  const LangueScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LangueScreen> createState() => _LangueScreenState();
}

class _LangueScreenState extends State<LangueScreen> {
  TextEditingController langueController = TextEditingController();
  TextEditingController modifyLangueController = TextEditingController();
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  bool isCharging = false;
  LangueService langueService = LangueService();
  CreateCourseService createCourseService = CreateCourseService();
  List<Langue> langues = [];
  final _addLangueFormKey = GlobalKey<FormState>();

  void addLangue() {
    langueService.addLangue(context, langueController.text, () {
      setState(() {
        langueController.text = "";
        getAllLangues();
        isCharging = false;
      });
    });

    showSnackBar(context, "Langue ajout?? avec succ??s");
  }

  void deleteLangue(Langue langue) {
    langueService.deleteLangue(context, langue, () {
      setState(() {
        // langueController.text = "";
        Navigator.pop(context);
        getAllLangues();
        isCharging = false;
      });
    });

    showSnackBar(context, "Langue supprim?? avec succ??s");
  }

  @override
  void initState() {
    super.initState();
    getAllLangues();
  }

  void getAllLangues() async {
    langues = await createCourseService.getAllLangueData(context);
    setState(() {});
  }

  @override
  void dispose() {
    langueController.dispose();
    modifyLangueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBarPanel(texte: "langues"),
        body: isCharging == true || langues == null
            ? Loader()
            : Form(
                key: _addLangueFormKey,
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
                                hintText: "Langue",
                                controller: langueController),
                            IconButton(
                                onPressed: () {
                                  if (_addLangueFormKey.currentState!
                                      .validate()) {
                                    // print(_listlangues.length);
                                    setState(() {
                                      isCharging = true;
                                      addLangue();
                                      getAllLangues();
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.send_rounded,
                                  color: primary,
                                ))
                          ],
                        ),
                        for (int i = 0; i < langues.length; i++)
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
                                        langues[i].nom,
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
                                                                                "Voulez vous supprimer la langue?",
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
                                                                                          deleteLangue(langues[i]);
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
                                                  EditLangueScreen
                                                      .routeName, arguments: langues[i]);
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
