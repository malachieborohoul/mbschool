import 'package:flutter/material.dart';

import 'package:mbschool/core/common/widgets/custom_app_bar.dart';

import 'package:mbschool/models/cours.dart';

class DetailTeacherCourseScreen extends StatefulWidget {
  static const routeName = 'detail-teacher-course-screen';
  final Cours cours;
  const DetailTeacherCourseScreen({super.key, required this.cours});

  @override
  State<DetailTeacherCourseScreen> createState() =>
      _DetailTeacherCourseScreenState();
}

class _DetailTeacherCourseScreenState extends State<DetailTeacherCourseScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: CustomAppBar(
            backgroundColor: Colors.transparent, title: "Détails sur l'enseignant",
          )),
      // body: Center(
      //   child: Column(
      //     children: [
      //       CustomPersonCard(
      //           image: widget.cours.photo,
      //           name: widget.cours.nom,
      //           course: widget.cours.titre,
      //           totalCourses: "2",
      //           totalStudents: "2")
      //     ],
      //   ),
      // ),
    );
  }
}
