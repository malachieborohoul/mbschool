import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/custom_app_bar.dart';
import 'package:mbschool/common/widgets/custom_course_curriculum.dart';
import 'package:mbschool/common/widgets/custom_course_footer.dart';
import 'package:mbschool/common/widgets/custom_detail_course_info_header.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/datas/courses_json.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/section.dart';

class DetailCourseScreen extends StatefulWidget {
  static const routeName = 'detail-course-screen';
  final Cours cours;
  const DetailCourseScreen({Key? key, required this.cours}) : super(key: key);

  @override
  State<DetailCourseScreen> createState() => _DetailCourseScreenState();
}

class _DetailCourseScreenState extends State<DetailCourseScreen>
    with TickerProviderStateMixin {
  List<Section> sections = [];
  CourseManagerService courseManagerService = CourseManagerService();

  @override
  void initState() {
    super.initState();
    getAllSections();
  }

  void getAllSections() async {
    sections = await courseManagerService.getAllSections(context, widget.cours);
    setState(() {
      // print(sections.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          child: CustomAppBar(
            backgroundColor: Colors.transparent,
          ),
          preferredSize: Size.fromHeight(40)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .4,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: ClipRRect(
                    child: Image.network(
                      'https://images.unsplash.com/photo-1575089976121-8ed7b2a54265?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: textWhite,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(Icons.play_arrow),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.8,
                    top: MediaQuery.of(context).size.height * 0.4,
                  ),
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: third,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.favorite_outline_rounded,
                      )),
                ),
              ],
            ),
            CustomDetailCourseInfoHeader(),
            Padding(
              padding: const EdgeInsets.all(appPadding),
              child: Container(
                width: double.infinity,
                height: 50,
                child: TabBar(
                    labelColor: Colors.black,
                    indicatorColor: primary,
                    controller: _tabController,
                    tabs: [
                      Tab(
                        text: "Informations",
                      ),
                      Tab(
                        text: "Resultats",
                      ),
                      Tab(
                        text: "Exigences",
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(appPadding),
              child: Container(
                width: double.infinity,
                height: 50,
                color: third,
                child: TabBarView(controller: _tabController, children: [
                  Text("Hi"),
                  Text("Hello"),
                  Text("OK"),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(appPadding),
              child: CustomCourseCurriculum(),
            )
          ],
        ),
      ),
      bottomSheet: CustomCourseFooter(),
    );
  }
}
