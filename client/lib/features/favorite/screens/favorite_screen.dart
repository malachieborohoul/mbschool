import 'package:flutter/material.dart';

import 'package:mbschool/common/animations/slide_right_tween.dart';
import 'package:mbschool/common/widgets/custom_course_card.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';

import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/common/widgets/nodata.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/features/course/screens/detail_course_screen.dart';
import 'package:mbschool/features/favorite/services/favorite_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/providers/course_provider.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite';
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Cours> cours = [];
  final FavoriteService _favoriteService = FavoriteService();
  @override
  void initState() {
    getAllFavoriteCourses();
    super.initState();
  }

  void getAllFavoriteCourses() async {
    cours = await _favoriteService.getAllFavoriteCourses(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getAllFavoriteCourses();
    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: cours == null ? const Loader() : getBody(),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: spacer,
            ),
            const CustomHeading(
                title: "Mes favoris", subTitle: "", color: secondary),
            const SizedBox(
              height: spacer - 50,
            ),
           cours.isEmpty? const NoData(): Column(
              children: List.generate(cours.length, (index) {
                return Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: SlideRightTween(
                      duration: Duration(milliseconds: (index+1) * 500),
                      curve: Curves.easeInOutCubic,
                      offset: 80,
                      child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, DetailCourseScreen.routeName,
                                arguments: cours[index]);

                            Provider.of<CoursProvider>(context, listen: false)
                                .set_cours(cours[index]);
                          },
                          child: CustomFavoriteCourseCard(cours: cours[index])),
                    ));
              }),
            )
          ],
        ),
      ),
    );
  }
}
