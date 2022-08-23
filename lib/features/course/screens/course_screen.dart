import 'package:flutter/material.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';
import 'package:mbschool/common/widgets/custom_my_courses_card.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/datas/courses_json.dart';

class CourseScreen extends StatefulWidget {
  static const routeName = '/course';
  const CourseScreen({Key? key}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: getBody(),
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
                Text(
                  "${MyCoursesJson.length} Cours",
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
              children: List.generate(MyCoursesJson.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomMyCoursesCard(
                    image: MyCoursesJson[index]['image'],
                    title: MyCoursesJson[index]['title'],
                    instructor: MyCoursesJson[index]['user_name'],
                    videoAmount: MyCoursesJson[index]['video'],
                    percentage: MyCoursesJson[index]['percentage'],
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
