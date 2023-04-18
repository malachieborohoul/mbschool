
import 'package:flutter/material.dart';

import 'package:mbschool/common/widgets/custom_lesson_commentaires.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/commentaire/services/course_commentaire_service.dart';

import 'package:mbschool/models/commentaire.dart';

import 'package:mbschool/models/lecon.dart';
import 'package:mbschool/providers/user_provider.dart';

import 'package:provider/provider.dart';

class CourseCommentaireScreen extends StatefulWidget {
  const CourseCommentaireScreen(
      {Key? key, required this.controller, required this.lecon})
      : super(key: key);

  final ScrollController? controller;
  final Lecon lecon;
  // static const routeName = '/filter-course-screen';

  @override
  State<CourseCommentaireScreen> createState() =>
      _CourseCommentaireScreenState();
}

class _CourseCommentaireScreenState extends State<CourseCommentaireScreen> {
  final CourseCommentaireService _courseCommentaireService =
      CourseCommentaireService();

  final _addCourseCommentaire = GlobalKey<FormState>();

  final TextEditingController _commentaireController = TextEditingController();
  bool _isFieldEmpty = true;
  bool _isloading = false;

  List<Commentaire> lessonCommentaires = [];
  List<Commentaire> lessonNumberReponses = [];

  @override
  void initState() {
    super.initState();
    getAllLessonCommentaires();
    // getAllLessonNumberReponses();
  }

  void getAllLessonCommentaires() async {
    lessonCommentaires =
        await _courseCommentaireService.getAllLessonCommentaires(context, widget.lecon);
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
        showSnackBar(context, "Discussion ajoutée");
      });
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false).user;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: lessonCommentaires == null
            ? const Loader()
            : SingleChildScrollView(
                controller: widget.controller,
                child: Padding(
                  padding: const EdgeInsets.all(appPadding ),
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
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Discussions",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                                    hintText: "Ajouter une discussion",
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
                                                    if (_addCourseCommentaire
                                                        .currentState!
                                                        .validate()) {
                                                      setState(() {
                                                        _isloading = true;
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
                    for (var i = 0; i <  lessonCommentaires.length; i++)
                      lessonCommentaires.isNotEmpty?  CustomLessonCommentaires(
                          icon: true,
                          reponse: true,
                          commentaire: lessonCommentaires[i], 
                        ): Container()
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
