import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/custom_app_bar.dart';
import 'package:mbschool/common/widgets/custom_course_curriculum.dart';
import 'package:mbschool/common/widgets/custom_course_footer.dart';
import 'package:mbschool/common/widgets/custom_detail_course_info_header.dart';
import 'package:mbschool/common/widgets/custom_exigence_cours.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/datas/courses_json.dart';
import 'package:mbschool/features/course/services/video_settings_service.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/features/panel/course_manager/services/exigence_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/exigence.dart';
import 'package:mbschool/models/lecon.dart';
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
  ExigenceService exigenceService = ExigenceService();
  List<Exigence> exigences = [];
  List<Lecon> lecons = [];

  @override
  void initState() {
    super.initState();
    getAllSections();
    getAllExigences();
    getAllLecons();
  }

  void getAllExigences() async {
    exigences = await exigenceService.getAllExigences(context, widget.cours);
    print(exigences.length);
  }

  void getAllSections() async {
    sections = await courseManagerService.getAllSections(context, widget.cours);
    setState(() {
      // print(sections.length);
    });
  }

  void getAllLecons() async {
    lecons = await courseManagerService.getAllLecons(context, sections[0]);
    setState(() {
      print(lecons.length);
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
                      widget.cours.vignette,
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
                  child: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                backgroundColor: textBlack,
                                content: VideoDisplay(
                                    videoUrl:
                                        'https://res.cloudinary.com/dshli1qgh/video/upload/v1660467558/dogs%20/i7nluycv93dqouta4cmt.mp4'),
                              ));
                    },
                    splashColor: Colors.grey,
                    child: Icon(Icons.play_arrow),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(
                //     left: MediaQuery.of(context).size.width * 0.8,
                //     top: MediaQuery.of(context).size.height * 0.4,
                //   ),
                //   child:  Icon(
                //     color: Color.fromARGB(255, 255, 0, 0),
                //     Icons.favorite_outline_rounded,
                //   ),
                // ),
              ],
            ),
            CustomDetailCourseInfoHeader(cours: widget.cours),
            Padding(
              padding: const EdgeInsets.only(
                  left: appPadding, right: appPadding, bottom: appPadding),
              child:  Container(
                width: double.infinity,
                height: 50,
                child: TabBar(
                    labelColor: Colors.black,
                    indicatorColor: primary,
                    controller: _tabController,
                    tabs: const[
                       Tab(
                        text: "Infos",
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
              padding: const EdgeInsets.only(
                  left: appPadding, right: appPadding, bottom: appPadding),
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: third,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(appPadding),
                  child: TabBarView(controller: _tabController, children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ce cours contient",
                          style: TextStyle(color: textWhite, fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "15 leçons",
                          style: TextStyle(color: textWhite),
                        ),
                        Divider(
                          thickness: 0.5,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "15 leçons",
                          style: TextStyle(color: textWhite),
                        ),
                        Divider(
                          thickness: 0.5,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ce que vous allez apprendre ",
                          style: TextStyle(color: textWhite, fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "15 leçons",
                          style: TextStyle(color: textWhite),
                        ),
                        Divider(
                          thickness: 0.5,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "15 leçons",
                          style: TextStyle(color: textWhite),
                        ),
                        Divider(
                          thickness: 0.5,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Les exigences du cours",
                          style: TextStyle(color: textWhite, fontSize: 20),
                        ),
                        for (int i = 0; i < exigences.length; i++)
                          CustomExigenceCours(exigence: exigences[i])
                      ],
                    ),
                  ]),
                ),
              ),
            ),
            for (int i = 0; i < sections.length; i++)
              Padding(
                padding: const EdgeInsets.only(
                  left: appPadding,
                  right: appPadding,
                  bottom: appPadding,
                ),
                child: CustomCourseCurriculum(
                  section: sections[i],
                ),
              )
          ],
        ),
      ),
      bottomNavigationBar: CustomCourseFooter(
        cours: widget.cours,
      ),
    );
  }
}
