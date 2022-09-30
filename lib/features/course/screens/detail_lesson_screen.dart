
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/animations/opacity_tween.dart';
import 'package:mbschool/common/animations/slide_down_tween.dart';
import 'package:mbschool/common/widgets/custom_app_bar.dart';
import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/common/widgets/custom_course_curriculum.dart';
import 'package:mbschool/common/widgets/custom_course_price_footer.dart';
import 'package:mbschool/common/widgets/custom_detail_course_info_header.dart';
import 'package:mbschool/common/widgets/custom_exigence_cours.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';
import 'package:mbschool/common/widgets/custom_lesson_commentaires.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/datas/courses_json.dart';
import 'package:mbschool/features/commentaire/screens/course_commentaire_screen.dart';
import 'package:mbschool/features/commentaire/services/course_commentaire_service.dart';
import 'package:mbschool/features/course/screens/rate_course_screen.dart';
import 'package:mbschool/features/course/services/video_settings_service.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/features/panel/course_manager/services/exigence_service.dart';
import 'package:mbschool/models/commentaire.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/exigence.dart';
import 'package:mbschool/models/lecon.dart';
import 'package:mbschool/models/section.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DetailLessonScreen extends StatefulWidget {
  static const routeName = 'detail-lesson-screen';
  final Lecon lecon;
  final Cours cours;
  const DetailLessonScreen({Key? key, required this.lecon, required this.cours})
      : super(key: key);

  @override
  State<DetailLessonScreen> createState() => _DetailLessonScreenState();
}

class _DetailLessonScreenState extends State<DetailLessonScreen>
    with TickerProviderStateMixin {
  List<Section> sections = [];
  CourseManagerService courseManagerService = CourseManagerService();
  ExigenceService exigenceService = ExigenceService();
  List<Exigence> exigences = [];
  List<Lecon> lecons = [];
  bool? isCourseInFav;
  bool? isLeconDone;

  bool selected = false;

  List<Commentaire> lessonCommentaires = [];
  var number_discussions;
  CourseCommentaireService _courseCommentaireService =
      CourseCommentaireService();

  String? numberLecon;
  String? numberLeconDone;

  @override
  void initState() {
    super.initState();
    // getAllSections();
    // getAllExigences();
    getAllLecons();
    isCoursInFavorite();
    countAllLessonReponseAndCommentaires();
    isLeconMarkDone();
    getNumberLeconCours();
    getNumberLeconCoursDone();
  }

  void getNumberLeconCours() async {
    numberLecon =
        await courseManagerService.getNumberLeconCours(context, widget.cours);
    setState(() {});
  }

  void getNumberLeconCoursDone() async {
    numberLeconDone = await courseManagerService.getNumberLeconCoursDone(
        context, widget.cours);
    setState(() {});
  }

  void countAllLessonReponseAndCommentaires() async {
    number_discussions = await _courseCommentaireService
        .countAllLessonReponseAndCommentaires(context, widget.lecon);
    setState(() {});
  }

  void isCoursInFavorite() async {
    isCourseInFav =
        await courseManagerService.isCourseInFavorite(context, widget.cours);
    setState(() {});
  }

  void isLeconMarkDone() async {
    isLeconDone = await courseManagerService.isLeconDone(context, widget.lecon);
    setState(() {
      selected = false;
    });
  }

  // void getAllExigences() async {
  //   exigences = await exigenceService.getAllExigences(context, widget.cours);
  //   print(exigences.length);
  // }

  // void getAllSections() async {
  //   sections = await courseManagerService.getAllSections(context, widget.cours);
  //   setState(() {
  //     // print(sections.length);
  //   });
  // }

  void getAllLecons() async {
    lecons = await courseManagerService.getAllLecons(context, sections[0]);
    setState(() {
      print(lecons.length);
    });
  }

  void markLessonAsDone() {
    _courseCommentaireService.markLessonAsDone(context, widget.lecon, () {
      setState(() {
        isLeconMarkDone();
        getNumberLeconCours();
        getNumberLeconCoursDone();
        if (int.parse(numberLeconDone!) + 1 == int.parse(numberLecon!)) {
          print(
              "${int.parse(numberLeconDone!) + 1} / ${int.parse(numberLecon!)}");

          Navigator.pushNamed(context, RateCourseScreen.routeName);
        } else {
          print(
              "${int.parse(numberLeconDone!) + 1} / ${int.parse(numberLecon!)}");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          child: CustomAppBar(
            backgroundColor: Colors.transparent,
          ),
          preferredSize: Size.fromHeight(40)),
      body: number_discussions == null ||
              isLeconDone == null ||
              selected == true ||
              numberLecon == null ||
              numberLeconDone == null
          ? Loader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .3,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        child: Hero(
                          tag: widget.cours.vignette,
                          child: ClipRRect(
                            child: Image.network(
                              widget.cours.vignette,
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
                           Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return VideoDisplay(videoUrl: widget.lecon.url);
                          }));
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
                  // SlideDownTween(
                  //   offset: 25,
                  //   child: OpacityTween(
                  //     begin: 0,
                  //     child: CustomDetailCourseInfoHeader(
                  //       cours: widget.cours,
                  //       isCourseInFav: isCourseInFav!,
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: appPadding, right: appPadding, bottom: appPadding),
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: 50,
                  //     child:
                  //     TabBar(
                  //         labelColor: Colors.black,
                  //         indicatorColor: primary,
                  //         controller: _tabController,
                  //         tabs: const [
                  //           OpacityTween(
                  //             begin: 0,
                  //             child: Tab(
                  //               text: "Infos",
                  //             ),
                  //           ),
                  //           OpacityTween(
                  //             begin: 0,
                  //             child: Tab(
                  //               text: "Commentaires",
                  //             ),
                  //           ),

                  //         ]),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(appPadding),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        // color: third,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: OpacityTween(
                        begin: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.lecon.resume),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Télécharger fichier",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.file_download_outlined,
                                        color: primary,
                                      )),
                                ],
                              ),
                              isLeconDone == true
                                  ? Container(
                                      width: size.width,
                                      height: 45.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: textWhite,
                                        border: Border.all(color: primary),
                                        borderRadius:
                                            BorderRadius.circular(17.5),
                                      ),
                                      child: Text(
                                        "Déjà suivi",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700,
                                          color: primary,
                                        ),
                                      ))
                                  : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selected = true;
                                        });
                                        markLessonAsDone();
                                      },
                                      child: CustomButtonBox(
                                          title: "Marquer comme déjà suivie"),
                                    ),
                              InkWell(
                                splashColor: Colors.grey,
                                onTap: () {
                                  showModalBottomSheet(
                                      useRootNavigator: true,
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return DraggableScrollableSheet(
                                          expand: false,
                                          initialChildSize: 0.7,
                                          builder: (_, controller) => Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(20)),
                                              color: Colors.white,
                                            ),
                                            child: CourseCommentaireScreen(
                                                controller: controller,
                                                lecon: widget.lecon),
                                          ),
                                        );
                                      });
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: appPadding),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "Discussions ${number_discussions}"),
                                            Icon(Icons.unfold_more_outlined)
                                          ],
                                        ),
                                        // CustomLessonCommentaires(
                                        //   commentaire: lessonCommentaires[lessonCommentaires.length -1],
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      // bottomNavigationBar: TextFormField(
      //   decoration: InputDecoration(

      //   ),
      // )
    );
  }
}
