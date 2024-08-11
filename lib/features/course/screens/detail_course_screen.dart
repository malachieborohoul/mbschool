import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbschool/common/animations/opacity_tween.dart';
import 'package:mbschool/common/animations/slide_down_tween.dart';
import 'package:mbschool/common/widgets/alert_notification.dart';
import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/common/widgets/custom_course_curriculum.dart';
import 'package:mbschool/common/widgets/custom_course_price_footer.dart';
import 'package:mbschool/common/widgets/custom_course_reviews.dart';
import 'package:mbschool/common/widgets/custom_detail_course_info_header.dart';

import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/common/widgets/nodata.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/course/services/rate_course_service.dart';
import 'package:mbschool/features/course/services/video_settings_service.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/features/panel/course_manager/services/exigence_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/exigence.dart';
import 'package:mbschool/models/lecon.dart';
import 'package:mbschool/models/notation_cours.dart';
import 'package:mbschool/models/section.dart';
import 'package:mbschool/providers/course_provider.dart';
import 'package:provider/provider.dart';

class DetailCourseScreen extends StatefulWidget {
  static const routeName = 'detail-course-screen';
  final Cours cours;
  const DetailCourseScreen({Key? key, required this.cours}) : super(key: key);

  @override
  State<DetailCourseScreen> createState() => _DetailCourseScreenState();
}

CourseManagerService courseManagerService = CourseManagerService();

RateCourseService rateCourseService = RateCourseService();

class _DetailCourseScreenState extends State<DetailCourseScreen>
    with TickerProviderStateMixin {
  late Future<List<Section>> sections;
  CourseManagerService courseManagerService = CourseManagerService();
  ExigenceService exigenceService = ExigenceService();
  late Future<List<Exigence>> exigences;
  List<Lecon> lecons = [];
  bool? isCourseInFav;
  bool? isCourseEnroll;
  bool _isLoading = false;
  List<NotationCours> notationCours = [];
  late double averageRate;

  @override
  void initState() {
    super.initState();
    getAllSections();
    getAllExigences();
    // getAllLecons();
    isCoursInFavorite();
    isCourseEnrolled();
    getAllNotationCours();
  }

  void getAllNotationCours() async {
    int totalRate = 0;
    notationCours =
        await rateCourseService.getAllNotationCours(context, widget.cours);
    setState(() {
      if (notationCours.isNotEmpty) {
        for (int i = 0; i < notationCours.length; i++) {
          totalRate += int.parse(notationCours[i].note);
        }
        averageRate = totalRate / notationCours.length;
      } else {
        averageRate = 0;
      }
    });
  }

  void isCourseEnrolled() async {
    isCourseEnroll =
        await courseEnrollmentService.isCourseEnrolled(context, widget.cours);
    setState(() {});
  }

  void isCoursInFavorite() async {
    isCourseInFav =
        await courseManagerService.isCourseInFavorite(context, widget.cours);
    setState(() {});
  }

  void getAllExigences() {
    exigences = exigenceService.getAllExigences(context, widget.cours);
    // print(exigences.length);
  }

  void getAllSections() {
    sections = courseManagerService.getAllSections(context, widget.cours);
    setState(() {
      // print(sections.length);
    });
  }

  // void getAllLecons() async {
  //   lecons = await courseManagerService.getAllLecons(context, sections[0]);
  //   setState(() {
  // print(lecons.length);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final coursProvider =
        Provider.of<CoursProvider>(context, listen: false).cours;

    // final tabController = Provider.of<TabBarProvider>(context).controller;

    final cours = Provider.of<CoursProvider>(context, listen: false).cours;

    void enrollToCourse() {
      courseEnrollmentService.enrollToCourse(context, cours, () {
        setState(() {
          isCourseEnrolled();
          _isLoading = false;
          showDialog(
              context: context,
              builder: (context) {
                return const AlertNotification(
                    error: false,
                    message: "Votre enrôlement s'est effectué avec succès");
              });
        });
      });
    }

    return Scaffold(
      body: isCourseInFav == null ||
              _isLoading == true ||
              isCourseEnroll == null
          ? const Loader()
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
                                  offset: const Offset(0, 2),
                                )
                              ],
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              '${assetImg}arrow_left_icon.svg',
                              color: textWhite,
                            ),
                          ),
                        ),
                      ),

                      backgroundColor: Colors.transparent,
                      expandedHeight: MediaQuery.of(context).size.height * 0.3,
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

                                      /*
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const AlertDialog(
                                                backgroundColor: textBlack,
                                                content: VideoDisplay(
                                                    videoUrl:
                                                        'https://res.cloudinary.com/dshli1qgh/video/upload/v1660467558/dogs%20/i7nluycv93dqouta4cmt.mp4'),
                                              ));*/
                                    },
                                    splashColor: Colors.grey,
                                    child: const Icon(Icons.play_arrow),
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
                              averageRate: averageRate,
                            ))),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: appPadding,
                        right: appPadding,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: TabBar(
                            labelColor: textBlack,
                            indicatorColor: primary,
                            tabs: [
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
                          FutureBuilder(
                              future: exigences,
                              builder: (context,
                                  AsyncSnapshot<List<Exigence>> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return InfosTabBarView(
                                      exigences: snapshot.data!);
                                } else {
                                  return const Loader();
                                }
                              }),
                          FutureBuilder(
                              future: sections,
                              builder: (context,
                                  AsyncSnapshot<List<Section>> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return LeconTabBarView(
                                    sections: snapshot.data!,
                                    isCourseEnrolled: isCourseEnroll!,
                                  );
                                } else {
                                  return const Loader();
                                }
                              }),
                          ReviewsTabBarView(notationCours: notationCours)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: _isLoading == true
          ? const Loader()
          : isCourseEnroll == false
              ? Row(
                  children: [
                    CustomCoursePriceFooter(cours: cours),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SlideDownTween(
                                  offset: 140,
                                  child: OpacityTween(
                                    begin: 0.5,
                                    child: AlertDialog(
                                      content: Column(
                                        children: [
                                          const Flexible(
                                              child: Text(
                                            "Voulez vous vous enrôler?",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        right: 25.0),
                                                child: InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 40,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: const Text(
                                                        "Non",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    Navigator.pop(context);

                                                    _isLoading = true;
                                                    enrollToCourse();
                                                  });
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 40,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(15)),
                                                  child: const Text(
                                                    "Oui",
                                                    style: TextStyle(
                                                        color: textWhite),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: const CustomButtonBox(
                            title: "S'enrôler maintenant"),
                      ),
                    ),
                  ],
                )
              : const Padding(
                  padding: EdgeInsets.all(appPadding),
                  child: CustomButtonBox(title: "Enrôlé(e)"),
                ),
    );
  }
}

class LeconTabBarView extends StatefulWidget {
  const LeconTabBarView({
    Key? key,
    required this.sections,
    required this.isCourseEnrolled,
  }) : super(key: key);
  final List<Section> sections;
  final bool isCourseEnrolled;

  @override
  State<LeconTabBarView> createState() => _LeconTabBarViewState();
}

class _LeconTabBarViewState extends State<LeconTabBarView> {
  @override
  Widget build(BuildContext context) {
    final coursProvider =
        Provider.of<CoursProvider>(context, listen: false).cours;

    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.sections.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.only(
              left: appPadding,
              right: appPadding,
              bottom: 0,
            ),
            child: CustomCourseCurriculum(
              isCourseEnrolled: widget.isCourseEnrolled,
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
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: appPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Exigences",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  for (var i = 0; i < widget.exigences.length; i++)
                    Text(widget.exigences[i].nom),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: appPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Objectifs",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  for (var i = 0; i < widget.exigences.length; i++)
                    Text(widget.exigences[i].nom),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: appPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Résultats",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  for (var i = 0; i < widget.exigences.length; i++)
                    Text(widget.exigences[i].nom),
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
    required this.notationCours,
  }) : super(key: key);
  final List<NotationCours> notationCours;

  @override
  State<ReviewsTabBarView> createState() => _ReviewsTabBarViewState();
}

class _ReviewsTabBarViewState extends State<ReviewsTabBarView> {
  @override
  Widget build(BuildContext context) {
    return widget.notationCours.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: widget.notationCours.length,
            itemBuilder: (context, i) {
              return Padding(
                  padding: const EdgeInsets.only(
                    left: appPadding,
                    right: appPadding,
                    bottom: 0,
                  ),
                  child: CustomCourseReviews(
                      notationCours: widget.notationCours[i]));
            })
        : const NoData();
  }
}
