import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/custom_app_bar.dart';
import 'package:mbschool/common/widgets/custom_course_curriculum.dart';
import 'package:mbschool/common/widgets/custom_course_footer.dart';
import 'package:mbschool/common/widgets/custom_detail_course_info_header.dart';
import 'package:mbschool/common/widgets/custom_exigence_cours.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';
import 'package:mbschool/common/widgets/custom_my_courses_card.dart';
import 'package:mbschool/common/widgets/custom_person_card.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/datas/courses_json.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/features/panel/course_manager/services/exigence_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/exigence.dart';
import 'package:mbschool/models/section.dart';

class DetailTeacherCourseScreen extends StatefulWidget {
  static const routeName = 'detail-teacher-course-screen';
  final Cours cours;
  const DetailTeacherCourseScreen({Key? key, required this.cours})
      : super(key: key);

  @override
  State<DetailTeacherCourseScreen> createState() =>
      _DetailTeacherCourseScreenState();
}

class _DetailTeacherCourseScreenState extends State<DetailTeacherCourseScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          child: CustomAppBar(
            backgroundColor: Colors.transparent, title: "Détails sur l'enseignant",
          ),
          preferredSize: Size.fromHeight(40)),
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
