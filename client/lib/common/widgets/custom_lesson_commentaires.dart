import 'package:flutter/material.dart';
import 'package:mbschool/features/commentaire/screens/course_reponse_commentaire_screen.dart';
import 'package:mbschool/features/commentaire/services/course_commentaire_service.dart';
import 'package:mbschool/models/commentaire.dart';

class CustomLessonCommentaires extends StatefulWidget {
  const CustomLessonCommentaires({
    Key? key,
    this.icon = false,
    required this.commentaire,
    this.reponse = false,
  }) : super(key: key);
  final bool icon;
  final bool reponse;
  final Commentaire? commentaire;

  @override
  State<CustomLessonCommentaires> createState() =>
      _CustomLessonCommentairesState();
}

class _CustomLessonCommentairesState extends State<CustomLessonCommentaires> {
  final CourseCommentaireService _courseCommentaireService =
      CourseCommentaireService();
  late String lessonNumberReponses;

  @override
  void initState() {
    getAllLessonNumberReponses();
    super.initState();
  }

  void getAllLessonNumberReponses() async {
    lessonNumberReponses = await _courseCommentaireService
        .getAllLessonNumberReponses(context, widget.commentaire!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.commentaire!.photo),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "${widget.commentaire!.nom} ${widget.commentaire!.prenom}",
                    //   style: const TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(widget.commentaire!.intitule)),
                    Row(
                      children: [
                        widget.icon == true
                            ? IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      useRootNavigator: true,
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      backgroundColor: Colors.transparent,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return DraggableScrollableSheet(
                                          expand: false,
                                          initialChildSize: 0.8,
                                          builder: (_, controller) => Container(
                                            decoration: const BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(20)),
                                              color: Colors.white,
                                            ),
                                            child:
                                                CourseReponseCommentaireScreen(
                                                    controller: controller,
                                                    commentaire:
                                                        widget.commentaire!),
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.message_outlined,
                                  size: 17,
                                ))
                            : Container(),
                        widget.reponse == true
                            ? InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      useRootNavigator: true,
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      backgroundColor: Colors.transparent,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return DraggableScrollableSheet(
                                          expand: false,
                                          initialChildSize: 0.8,
                                          builder: (_, controller) => Container(
                                            decoration: const BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(20)),
                                              color: Colors.white,
                                            ),
                                            child:
                                                CourseReponseCommentaireScreen(
                                                    controller: controller,
                                                    commentaire:
                                                        widget.commentaire!),
                                          ),
                                        );
                                      });
                                },
                                child: Text("$lessonNumberReponses Reponse(s)",
                                    style: const TextStyle(
                                      color: Colors.blueAccent,
                                    )),
                              )
                            : Container()
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
