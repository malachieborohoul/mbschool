import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/custom_categories_button.dart';
import 'package:mbschool/common/widgets/custom_course_card.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';
import 'package:mbschool/common/widgets/custom_place_holder.dart';
import 'package:mbschool/common/widgets/custom_search_field.dart';
import 'package:mbschool/common/widgets/custom_title.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/datas/category_json.dart';
import 'package:mbschool/features/course/screens/detail_course_screen.dart';
import 'package:mbschool/features/favorite/services/favorite_service.dart';
import 'package:mbschool/models/cours.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite';
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Cours>? cours;
  FavoriteService _favoriteService = FavoriteService();
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
      body: cours == null ? Loader() : getBody(),
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
              height: spacer -50,
            ),
            Column(
              children: List.generate(cours!.length, (index) {
                return Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, DetailCourseScreen.routeName,
                              arguments: cours![index]);
                        },
                        child: CustomFavoriteCourseCard(cours: cours![index])));
              }),
            )
          ],
        ),
      ),
    );
  }
}
