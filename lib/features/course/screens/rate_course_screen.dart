import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mbschool/common/animations/slide_down_tween.dart';
import 'package:mbschool/common/animations/slide_up_tween.dart';
import 'package:mbschool/common/widgets/custom_app_bar.dart';
import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/course/screens/detail_course_screen.dart';
import 'package:mbschool/features/course/services/rate_course_service.dart';
import 'package:mbschool/providers/course_provider.dart';
import 'package:provider/provider.dart';

class RateCourseScreen extends StatefulWidget {
  const RateCourseScreen({Key? key}) : super(key: key);
  static const routeName = 'rate-course-screen';

  @override
  State<RateCourseScreen> createState() => _RateCourseScreenState();
}

class _RateCourseScreenState extends State<RateCourseScreen>
    with SingleTickerProviderStateMixin {
  RateCourseService _rateCourseService = RateCourseService();
  final _ratingFormKey = GlobalKey<FormState>();
  double ratingCourse = 0.0;
  TextEditingController testimonialController = TextEditingController();
  late final _animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 750))
          .addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      showSnackBar(context, "Merci");
    } else {}
  });

  bool click = false;
  bool circular = false;
  bool changeMessage = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    testimonialController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // changeMessage = !changeMessage;
    final coursProvider =
        Provider.of<CoursProvider>(context, listen: false).cours;

    var size = MediaQuery.of(context).size;
    print(click);

    void rateCourse() async {
      _rateCourseService.rateCourse(
          context, coursProvider, ratingCourse, testimonialController.text, () {
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            // click = !click;
            // circular = !circular;
            changeMessage = !changeMessage;
          });
          // showSnackBar(context, "Merci");
        });
      });
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          //  extendBodyBehindAppBar: true,
          appBar: PreferredSize(
              child: changeMessage == false
                  ? CustomAppBar(
                      title: "Notez ce cours",
                      backgroundColor: Colors.transparent,
                    )
                  : Container(),
              preferredSize: Size.fromHeight(40)),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(appPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: appPadding,
                    ),
                    changeMessage == false
                        ? SlideDownTween(
                            delay: 2,
                            offset: 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "FELICITATIONS!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                SizedBox(height: appPadding - 10),
                                Text(
                                  "Vous avez terminé!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                                ),
                                SizedBox(height: appPadding - 10),
                                Text(
                                  "${coursProvider.titre}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20),
                                ),
                                SizedBox(height: appPadding - 10),
                                Text(
                                  "S'il vous plait prenez un moment pour laisser une note et un témoignage. Cordialement!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                SizedBox(height: appPadding - 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Notation",
                                      style:
                                          TextStyle(color: grey, fontSize: 15),
                                    ),
                                    RatingBar.builder(
                                        initialRating: 0,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        itemBuilder: (context, _) => const Icon(
                                              Icons.star,
                                              size: 20,
                                              color: third,
                                            ),
                                        onRatingUpdate: (rating) {
                                          ratingCourse = rating;
                                          print(ratingCourse);
                                        })
                                  ],
                                ),
                              ],
                            ),
                          )
                        : SlideUpTween(
                            offset: 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  assetImg + "thanks.png",
                                ),
                                SizedBox(height: appPadding - 10),
                                SlideUpTween(
                                  offset: 70,
                                  child: Text(
                                    "Merci!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Form(
                        key: _ratingFormKey,
                        child: Column(
                          children: [
                            SizedBox(height: appPadding - 10),
                            changeMessage == false
                                ? SlideDownTween(
                                    delay: 2,
                                    offset: 70,
                                    child: TextFormField(
                                      controller: testimonialController,
                                      validator: (value) {
                                        if (value!.isEmpty || value == null) {
                                          return "Veuillez saisir un témoignage";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        label: Text("Témoignage"),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: primary),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            SizedBox(height: appPadding - 5),
                            GestureDetector(
                              onTap: changeMessage == false
                                  ? () {
                                      if (_ratingFormKey.currentState!
                                          .validate()) {
                                        if (ratingCourse == 0.0) {
                                          showSnackBar(
                                              context, "Donnez une note svp!");
                                        } else {
                                          setState(() {
                                            circular = !circular;
                                            click = !click;

                                            rateCourse();

                                            // Future.delayed(Duration(seconds: 1), () {
                                            //   click = !click;
                                            // });
                                          });
                                        }
                                      }
                                    }
                                  : () {
                                      final coursProvider =
                                          Provider.of<CoursProvider>(context,
                                                  listen: false)
                                              .cours;
                                      Navigator.pop(context);
                                    },
                              child: AnimatedContainer(
                                width: click == true ? 50 : size.width,
                                height: 45.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: primary.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primary.withOpacity(0.5),
                                      spreadRadius: 0.0,
                                      blurRadius: 6.0,
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                ),
                                duration: const Duration(milliseconds: 1200),
                                curve: Curves.easeInOutBack,
                                child: changeMessage == false
                                    ? circular == true
                                        ? CircularProgressIndicator.adaptive(
                                            backgroundColor: textWhite,
                                            strokeWidth: 1,
                                          )
                                        : Text(
                                            "Envoyer",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: textWhite,
                                            ),
                                          )
                                    : Icon(
                                        Icons.check,
                                        color: textWhite,
                                      ),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
