
import 'package:flutter/material.dart';

import 'package:mbschool/common/widgets/custom_lesson_commentaires.dart';
import 'package:mbschool/common/widgets/custom_lesson_reponse_commentaires.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/commentaire/services/course_commentaire_service.dart';

import 'package:mbschool/models/commentaire.dart';

import 'package:mbschool/models/reponse_commentaire.dart';
import 'package:mbschool/providers/user_provider.dart';

import 'package:provider/provider.dart';

class CourseReponseCommentaireScreen extends StatefulWidget {
  const CourseReponseCommentaireScreen(
      {Key? key, required this.controller,  required this.commentaire})
      : super(key: key);

  final ScrollController? controller;
  final Commentaire commentaire;
  // static const routeName = '/filter-course-screen';

  @override
  State<CourseReponseCommentaireScreen> createState() =>
      _CourseReponseCommentaireScreenState();
}

class _CourseReponseCommentaireScreenState
    extends State<CourseReponseCommentaireScreen> {
  final CourseCommentaireService _courseCommentaireService =
      CourseCommentaireService();

  final _addCourseReponseCommentaire = GlobalKey<FormState>();

  final TextEditingController _reponseCommentaireController = TextEditingController();
  bool _isFieldEmpty = true;
  bool _isloading = false;

  List<ReponseCommentaire> lessonReponseCommentaires = [];

  @override
  void initState() {
    super.initState();
    getAllLessonReponseCommentaires();
  }

  void getAllLessonReponseCommentaires() async {
    lessonReponseCommentaires = await _courseCommentaireService
        .getAllLessonReponseCommentaires(context, widget.commentaire);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _reponseCommentaireController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void addLeconCommentaire() {
      _courseCommentaireService.addLeconReponseCommentaire(context,
          _reponseCommentaireController.text, widget.commentaire, () {
        setState(() {
          _isloading = false;
        });
        FocusScope.of(context).unfocus();
        _reponseCommentaireController.clear();
        getAllLessonReponseCommentaires();
        showSnackBar(context, "Reponse ajoutée");
      });
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false).user;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: lessonReponseCommentaires == null
            ? const Loader()
            : SingleChildScrollView(
                controller: widget.controller,
                child: Padding(
                  padding: const EdgeInsets.all(appPadding),
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
                     const  SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back_outlined)),
                              const Text(
                                "Reponses",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomLessonCommentaires(
                        icon: false,
                        commentaire: widget.commentaire,
                      ),

                      const Divider(thickness: 0.7),

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
                                key: _addCourseReponseCommentaire,
                                child: TextFormField(
                                  controller: _reponseCommentaireController,
                                  onChanged: (val) {
                                    setState(() {
                                      val.isNotEmpty
                                          ? _isFieldEmpty = false
                                          : _isFieldEmpty = true;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Ajouter une reponse",
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: primary,
                                      ),
                                    ),
                                    suffixIcon: _isloading == false
                                        ? IconButton(
                                            onPressed: _isFieldEmpty == true
                                                ? null
                                                : () {
                                                    if (_addCourseReponseCommentaire
                                                        .currentState!
                                                        .validate()) {
                                                      setState(() {
                                                        // _isloading = true;
                                                        addLeconCommentaire();
                                                      });
                                                    }
                                                  },
                                            icon: const Icon(Icons.send),
                                          )
                                        : const Loader(),
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
                      // for (var i = 0; i < lessonReponseCommentaires.length; i++)
                      //   CustomLessonCommentaires(
                      //     icon: true,
                      //     commentaire: lessonReponseCommentaires[i],
                      //   )

                      for (var i = 0; i < lessonReponseCommentaires.length; i++)
                        lessonReponseCommentaires.isNotEmpty
                            ? CustomLessonReponseCommentaires(
                                icon: false,
                                reponseCommentaire: lessonReponseCommentaires[i],
                              )
                            : Container()
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
