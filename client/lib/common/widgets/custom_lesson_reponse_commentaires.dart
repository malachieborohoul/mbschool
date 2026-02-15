import 'package:flutter/material.dart';
import 'package:mbschool/models/reponse_commentaire.dart';

class CustomLessonReponseCommentaires extends StatefulWidget {
  const CustomLessonReponseCommentaires(
      {Key? key, this.icon = false,  this.reponseCommentaire})
      : super(key: key);
  final bool icon;
  final ReponseCommentaire? reponseCommentaire;

  @override
  State<CustomLessonReponseCommentaires> createState() =>
      _CustomLessonReponseCommentairesState();
}

class _CustomLessonReponseCommentairesState extends State<CustomLessonReponseCommentaires> {
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
                backgroundImage: NetworkImage(widget.reponseCommentaire!.photo),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.reponseCommentaire!.nom} ${widget.reponseCommentaire!.prenom}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(widget.reponseCommentaire!.intitule_reponse)),
                    widget.icon == true
                        ? IconButton(
                            onPressed: () {
                              // showModalBottomSheet(
                              // useRootNavigator: true,
                              // isScrollControlled: true,
                              // isDismissible: true,
                              // backgroundColor: Colors.transparent,
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.vertical(
                              //     top: Radius.circular(20),
                              //   ),
                              // ),
                              // context: context,
                              // builder: (context) {
                              //   return DraggableScrollableSheet(
                              //     expand: false,
                              //     initialChildSize: 0.7,
                              //     builder: (_, controller) => Container(
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.vertical(
                              //             top: Radius.circular(20)),
                              //         color: Colors.white,
                              //       ),
                              //       child: CourseReponseCommentaireScreen(
                              //           controller: controller,
                              //            reponseCommentaire: null,),
                              //     ),
                              //   );
                              // });
                        
                            },
                            icon: const Icon(
                              Icons.message_outlined,
                              size: 17,
                            ))
                        : Container()
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
