import 'package:flutter/material.dart';
import 'package:mbschool/common/animations/opacity_tween.dart';
import 'package:mbschool/common/animations/slide_right_tween.dart';
import 'package:mbschool/common/animations/slide_up_tween.dart';
import 'package:mbschool/common/widgets/custom_app_bar.dart';
import 'package:mbschool/common/widgets/custom_course_card.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/features/course/screens/detail_course_screen.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/providers/course_provider.dart';
import 'package:provider/provider.dart';

class AllCourseScreen extends StatefulWidget {
  static const routeName = '/all-course-screen';
  final Future<List<Cours>> coursFuture;

  AllCourseScreen({Key? key, required this.coursFuture}) : super(key: key);

  @override
  State<AllCourseScreen> createState() => _AllCourseScreenState();
}

class _AllCourseScreenState extends State<AllCourseScreen> {
  late Future<List<Cours>> _coursFuture;

  @override
  void initState() {
    super.initState();
    _coursFuture = widget.coursFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: CustomAppBar(
          backgroundColor: Colors.transparent,
          action: true,
          actionIcon: 'search_icon.svg',
        ),
      ),
      body: FutureBuilder<List<Cours>>(
        future: _coursFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Pas d'informations"));
          } else {
            return getBody(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget getBody(List<Cours> cours) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: spacer),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SlideUpTween(
                  offset: 40,
                  child: Text(
                    "${cours.length} Cours",
                    style: const TextStyle(
                      fontSize: 20,
                      color: secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: spacer),
            Column(
              children: List.generate(cours.length, (index) {
                return SlideRightTween(
                  duration: Duration(milliseconds: index * 500),
                  curve: Curves.easeInOutCubic,
                  offset: 80,
                  child: OpacityTween(
                    begin: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            DetailCourseScreen.routeName,
                            arguments: cours[index],
                          );

                          Provider.of<CoursProvider>(context, listen: false)
                              .set_cours(cours[index]);
                        },
                        child: CustomCourseCardShrink(
                          thumbNail: cours[index].vignette,
                          title: cours[index].titre,
                          nom: cours[index].nom,
                          prenom: cours[index].prenom,
                          price: cours[index].prix.isEmpty
                              ? "Gratuit"
                              : cours[index].prix,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
