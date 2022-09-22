import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbschool/common/animations/opacity_tween.dart';
import 'package:mbschool/common/animations/slide_down_tween.dart';
import 'package:mbschool/common/widgets/custom_app_bar.dart';
import 'package:mbschool/common/widgets/custom_course_curriculum.dart';
import 'package:mbschool/common/widgets/custom_course_footer.dart';
import 'package:mbschool/common/widgets/custom_course_reviews.dart';
import 'package:mbschool/common/widgets/custom_detail_course_info_header.dart';
import 'package:mbschool/common/widgets/custom_exigence_cours.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/datas/courses_json.dart';
import 'package:mbschool/features/course/services/video_settings_service.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/features/panel/course_manager/services/exigence_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/exigence.dart';
import 'package:mbschool/models/lecon.dart';
import 'package:mbschool/models/section.dart';
import 'package:mbschool/providers/course_provider.dart';
import 'package:mbschool/providers/tabbar_provider.dart';
import 'package:provider/provider.dart';

class DetailCourseScreen extends StatefulWidget {
  static const routeName = 'detail-course-screen';
  final Cours cours;
  const DetailCourseScreen({Key? key, required this.cours}) : super(key: key);

  @override
  State<DetailCourseScreen> createState() => _DetailCourseScreenState();
}

CourseManagerService courseManagerService = CourseManagerService();

class _DetailCourseScreenState extends State<DetailCourseScreen>
    with TickerProviderStateMixin {
  List<Section> sections = [];
  CourseManagerService courseManagerService = CourseManagerService();
  ExigenceService exigenceService = ExigenceService();
  List<Exigence> exigences = [];
  List<Lecon> lecons = [];
  bool? isCourseInFav;

  @override
  void initState() {
    super.initState();
    getAllSections();
    getAllExigences();
    getAllLecons();
    isCoursInFavorite();

    // TabController _tabController = TabController(length: 3, vsync: this);

    // Provider.of<TabBarProvider>(context, listen: false)
    //     .setTabController(_tabController);
  }

  void isCoursInFavorite() async {
    isCourseInFav =
        await courseManagerService.isCourseInFavorite(context, widget.cours);
    setState(() {});
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
    final coursProvider =
        Provider.of<CoursProvider>(context, listen: false).cours;

    // final tabController = Provider.of<TabBarProvider>(context).controller;
    TabController _tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      body: sections == null || isCourseInFav == null
          ? Loader()
          : DefaultTabController(
              length: 3,
              child: NestedScrollView(
                headerSliverBuilder: (context, value) {
                  return [
                    SliverAppBar(
                      // pinned: true,
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          // splashColor: textWhite,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            // clipBehavior: Clip.antiAlias,
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                              color: primary.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(100.0),
                              boxShadow: [
                                BoxShadow(
                                  color: primary.withOpacity(0.5),
                                  spreadRadius: 0.0,
                                  blurRadius: 6.0,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              assetImg + 'arrow_left_icon.svg',
                              color: textWhite,
                            ),
                          ),
                        ),
                      ),

                      backgroundColor: Colors.transparent,
                      expandedHeight: 170,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .3,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.transparent,
                                  child: Hero(
                                    tag: coursProvider.vignette,
                                    child: ClipRRect(
                                      child: Image.network(
                                        coursProvider.vignette,
                                        fit: BoxFit.cover,
                                      ),
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
                              ],
                            ),
                          ],
                        ),
                        // preferredSize: Size.fromHeight(400),
                      ),
                    )
                  ];
                },
                body: Column(
                  children: [
                    SlideDownTween(
                        offset: 25,
                        child: OpacityTween(
                            begin: 0,
                            child: CustomDetailCourseInfoHeader(
                              cours: coursProvider,
                              isCourseInFav: isCourseInFav!,
                            ))),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: appPadding,
                        right: appPadding,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        child: TabBar(
                            labelColor: textBlack,
                            indicatorColor: primary,
                            tabs: const [
                              OpacityTween(
                                begin: 0,
                                child: Tab(
                                  text: "A propos",
                                ),
                              ),
                              OpacityTween(
                                begin: 0,
                                child: Tab(
                                  text: "Leçons",
                                ),
                              ),
                              OpacityTween(
                                begin: 0,
                                child: Tab(
                                  text: "Avis",
                                ),
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          InfosTabBarView(exigences: exigences),
                          LeconTabBarView(sections: sections),
                          ReviewsTabBarView(sections: sections)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    
      bottomNavigationBar: CustomCourseFooter(cours: coursProvider),
    );
  }
}

class LeconTabBarView extends StatefulWidget {
  const LeconTabBarView({
    Key? key,
    required this.sections,
  }) : super(key: key);
  final List<Section> sections;

  @override
  State<LeconTabBarView> createState() => _LeconTabBarViewState();
}

class _LeconTabBarViewState extends State<LeconTabBarView> {
  @override
  Widget build(BuildContext context) {
    final coursProvider =
        Provider.of<CoursProvider>(context, listen: false).cours;

    return ListView.builder(
      physics: BouncingScrollPhysics(),
        itemCount: widget.sections.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.only(
              left: appPadding,
              right: appPadding,
              bottom: 0,
            ),
            child: CustomCourseCurriculum(
              section: widget.sections[i],
              cours: coursProvider,
            ),
          );
        });
  }
}

class InfosTabBarView extends StatefulWidget {
  const InfosTabBarView({Key? key, required this.exigences}) : super(key: key);
  final List<Exigence> exigences;

  @override
  State<InfosTabBarView> createState() => _InfosTabBarViewState();
}

class _InfosTabBarViewState extends State<InfosTabBarView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: appPadding),
              child: Column(
                children: [
                  Text(
                    "Exigences",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  for (var i = 0; i < widget.exigences.length; i++)
                    Text('${widget.exigences[i].nom}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: appPadding),
              child: Column(
                children: [
                  Text(
                    "Objectifs",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  for (var i = 0; i < widget.exigences.length; i++)
                    Text('${widget.exigences[i].nom}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: appPadding),
              child: Column(
                children: [
                  Text(
                    "Résultats",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  for (var i = 0; i < widget.exigences.length; i++)
                    Text('${widget.exigences[i].nom}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // Column(
    //   children: [
    //     Expanded(
    //       child: Text(
    //         "Exigences",
    //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    //       ),
    //     ),
    //     ListView.builder(
    //         itemCount: widget.exigences.length,
    //         itemBuilder: (context, index) {
    //           return Padding(
    //             padding: const EdgeInsets.all(appPadding),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text('${widget.exigences[index].nom}'),
    //               ],
    //             ),
    //           );
    //         }),
    //   ],
    // );
  }
}

class ReviewsTabBarView extends StatefulWidget {
  const ReviewsTabBarView({
    Key? key,
    required this.sections,
  }) : super(key: key);
  final List<Section> sections;

  @override
  State<ReviewsTabBarView> createState() => _ReviewsTabBarViewState();
}

class _ReviewsTabBarViewState extends State<ReviewsTabBarView> {
  @override
  Widget build(BuildContext context) {
    final coursProvider =
        Provider.of<CoursProvider>(context, listen: false).cours;

    return ListView.builder(
      physics: BouncingScrollPhysics(),
        itemCount: widget.sections.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.only(
              left: appPadding,
              right: appPadding,
              bottom: 10,
            ),
            child: CustomCourseReviews()
          );
        });
  }
}
