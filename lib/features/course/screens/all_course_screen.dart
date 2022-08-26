import 'package:flutter/material.dart';
import 'package:mbschool/common/widgets/custom_app_bar.dart';
import 'package:mbschool/common/widgets/custom_course_card.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';
import 'package:mbschool/common/widgets/custom_my_courses_card.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/datas/courses_json.dart';
import 'package:mbschool/features/course/screens/detail_course_screen.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';

class AllCourseScreen extends StatefulWidget {
  static const routeName = '/all-course-screen';
  const AllCourseScreen({Key? key}) : super(key: key);

  @override
  State<AllCourseScreen> createState() => _AllCourseScreenState();
}

class _AllCourseScreenState extends State<AllCourseScreen> {
  CourseManagerService courseManagerService = CourseManagerService();
  List<Cours> cours = [];
  @override
  void initState() {
    getAllCourses();

    super.initState();
  }

  void getAllCourses() async {
    cours = await courseManagerService.getAllCourses(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          child: CustomAppBar(
            backgroundColor: Colors.transparent,
            action: true,
            actionIcon: 'search_icon.svg',
          ),
          preferredSize: Size.fromHeight(40)),
      body: cours == null
          ? Loader()
          : cours.isNotEmpty
              ? getBody()
              : Center(child: Text("Pas d'informations")),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: spacer,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const CustomHeading(
                //     title: "Tous les cours",
                //     subTitle: "Reprenons",
                //     color: textBlack),
                Text(
                  "${cours.length} Cours",
                  style: const TextStyle(
                    fontSize: 15,
                    color: secondary,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: spacer,
            ),
            Column(
              children: List.generate(cours.length, (index) {
                return Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, DetailCourseScreen.routeName,
                              arguments: cours[index]);
                        },
                        child: CustomCourseCardShrink(
                            thumbNail: cours[index].vignette,
                            title: cours[index].titre,
                            nom: cours[index].nom,
                            prenom: cours[index].prenom,
                            price: cours[index].prix.isEmpty
                                ? "Gratuit"
                                : cours[index].prix)));
              }),
            )
          ],
        ),
      ),
    );
  }
}
