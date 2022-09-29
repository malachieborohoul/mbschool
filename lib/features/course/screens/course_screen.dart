import 'package:flutter/material.dart';
import 'package:mbschool/common/animations/slide_right_tween.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';
import 'package:mbschool/common/widgets/custom_my_courses_card.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/datas/courses_json.dart';
import 'package:mbschool/features/course/screens/detail_course_screen.dart';
import 'package:mbschool/features/course/services/course_enrollment_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/providers/course_provider.dart';
import 'package:provider/provider.dart';

class CourseScreen extends StatefulWidget {
  static const routeName = '/course';
  const CourseScreen({Key? key}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  CourseEnrollmentService courseEnrollmentService = CourseEnrollmentService();
  List<Cours> enrolledCours = [];
  @override
  void initState() {
    super.initState();
    getAllEnrolledCourses();
  }

  void getAllEnrolledCourses() async {
    enrolledCours =
        await courseEnrollmentService.getAllEnrolledCourses(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: enrolledCours == null ? Loader() : getBody(),
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
                const CustomHeading(
                    title: "Mes Cours",
                    subTitle: "Reprenons",
                    color: textBlack),
                // Text(
                //   "${MyCoursesJson.length} Cours",
                //   style: const TextStyle(
                //     fontSize: 15,
                //     color: secondary,
                //   ),
                // )
              ],
            ),
            const SizedBox(
              height: spacer,
            ),
            Column(
              children: List.generate(enrolledCours.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: SlideRightTween(
                    duration: Duration(milliseconds: index * 500),
                    curve: Curves.easeInOutCubic,
                    offset: 80,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, DetailCourseScreen.routeName,
                            arguments: enrolledCours[index]);

                        Provider.of<CoursProvider>(context, listen: false)
                            .set_cours(enrolledCours[index]);
                      },
                      child: CustomMyCoursesCard(
                        image: enrolledCours[index].vignette,
                        title: enrolledCours[index].titre,
                        instructor: enrolledCours[index].nom,
                        videoAmount: "20",
                        percentage: 20,
                        cours: enrolledCours[index],
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
