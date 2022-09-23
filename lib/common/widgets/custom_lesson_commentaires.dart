import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/models/commentaire.dart';

class CustomLessonCommentaires extends StatefulWidget {
  const CustomLessonCommentaires(
      {Key? key, this.icon = false, required this.commentaire})
      : super(key: key);
  final bool icon;
  final Commentaire? commentaire;

  @override
  State<CustomLessonCommentaires> createState() =>
      _CustomLessonCommentairesState();
}

class _CustomLessonCommentairesState extends State<CustomLessonCommentaires> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      // color: primary,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.commentaire!.photo),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.commentaire!.nom} ${widget.commentaire!.prenom}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text("1 mois")
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                  "${widget.commentaire!.intitule}"),
            ),
            widget.icon == true
                ? IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.message_outlined,
                      size: 17,
                    ))
                : Container()
          ],
        ),
      ),
    );
  }
}
