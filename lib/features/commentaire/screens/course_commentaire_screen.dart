import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbschool/common/widgets/alert_notification.dart';
import 'package:mbschool/common/widgets/custom_lesson_commentaires.dart';
import 'package:mbschool/common/widgets/custom_title_panel.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/commentaire/services/course_commentaire_service.dart';
import 'package:mbschool/features/course/screens/all_course_screen.dart';
import 'package:mbschool/features/course/screens/detail_course_screen.dart';
import 'package:mbschool/features/filter/services/filter_service.dart';
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/models/commentaire.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/langue.dart';
import 'package:mbschool/models/lecon.dart';
import 'package:mbschool/models/niveau.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mbschool/common/animations/opacity_tween.dart';
import 'package:mbschool/common/animations/slide_down_tween.dart';
import 'package:mbschool/common/animations/slide_up_tween.dart';
import 'package:provider/provider.dart';

class CourseCommentaireScreen extends StatefulWidget {
  const CourseCommentaireScreen(
      {Key? key, required this.controller, required this.lecon})
      : super(key: key);

  final ScrollController? controller;
  final Lecon lecon;
  static const routeName = '/filter-course-screen';

  @override
  State<CourseCommentaireScreen> createState() =>
      _CourseCommentaireScreenState();
}

class _CourseCommentaireScreenState extends State<CourseCommentaireScreen> {
  CourseCommentaireService _courseCommentaireService =
      CourseCommentaireService();

  final _addCourseCommentaire = GlobalKey<FormState>();

  TextEditingController _commentaireController = TextEditingController();
  bool _isFieldEmpty = true;
  bool _isloading = false;

  List<Commentaire> lessonCommentaires = [];

  @override
  void initState() {
    super.initState();
    getAllLessonCommentaires();
  }

  void getAllLessonCommentaires() async {
    lessonCommentaires =
        await _courseCommentaireService.getAllLessonCommentaires(context);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _commentaireController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void addLeconCommentaire() {
      _courseCommentaireService.addLeconCommentaire(
          context, _commentaireController.text, widget.lecon, () {
        setState(() {
          _isloading = false;
        });
        FocusScope.of(context).unfocus();
        _commentaireController.clear();
        getAllLessonCommentaires();
        showSnackBar(context, "Commentaire ajouté");
      });
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false).user;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: lessonCommentaires == null
            ? Loader()
            : SingleChildScrollView(
                controller: widget.controller,
                child: Padding(
                  padding: const EdgeInsets.all(appPadding / 2),
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
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Commentaires",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close))
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(userProvider.photo),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                key: _addCourseCommentaire,
                                child: TextFormField(
                                  controller: _commentaireController,
                                  onChanged: (val) {
                                    setState(() {
                                      val.isNotEmpty
                                          ? _isFieldEmpty = false
                                          : _isFieldEmpty = true;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Ajouter un commentaire",
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: primary,
                                      ),
                                    ),
                                    suffixIcon: _isloading == false
                                        ? IconButton(
                                            onPressed: _isFieldEmpty == true
                                                ? null
                                                : () {
                                                    if (_addCourseCommentaire
                                                        .currentState!
                                                        .validate()) {
                                                      setState(() {
                                                        _isloading = true;
                                                        addLeconCommentaire();
                                                      });
                                                    }
                                                  },
                                            icon: Icon(Icons.send),
                                          )
                                        : Loader(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // TextFormField(
                      //   onTap: () {
                      //     showModalBottomSheet(
                      //         context: context,
                      //         builder: (context) {
                      //           return Container();
                      //         });
                      //   },
                      //   decoration: InputDecoration(
                      //       hintText: "Ajouter un commentaire",
                      //       focusedBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(color: primary))),
                      // ),
                      for (var i = 0; i < lessonCommentaires.length; i++)
                        CustomLessonCommentaires(
                          icon: true,
                          commentaire: lessonCommentaires[i],
                        )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
