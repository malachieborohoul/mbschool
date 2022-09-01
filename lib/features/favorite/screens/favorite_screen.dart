import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/custom_categories_button.dart';
import 'package:mbschool/common/widgets/custom_course_card.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';
import 'package:mbschool/common/widgets/custom_place_holder.dart';
import 'package:mbschool/common/widgets/custom_search_field.dart';
import 'package:mbschool/common/widgets/custom_title.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/datas/category_json.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite';
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
                title: "Mes favoris",
                subTitle: "",
                color: secondary),
            const SizedBox(
              height: spacer,
            ),

            // Column(
            //   children: List.generate(cours.length, (index) {
            //     return Padding(
            //         padding: const EdgeInsets.only(bottom: 25),
            //         child: InkWell(
            //             onTap: () {
            //               Navigator.pushNamed(
            //                   context, DetailCourseScreen.routeName,
            //                   arguments: cours[index]);
            //             },
            //             child: CustomFavoriteCourseCard(
            //                 thumbNail: cours[index].vignette,
            //                 title: cours[index].titre,
            //                 nom: cours[index].nom,
            //                 prenom: cours[index].prenom,
            //                 price: cours[index].prix.isEmpty
            //                     ? "Gratuit"
            //                     : cours[index].prix)));
            //   }),
            // )
           

             
          ],
        ),
      ),
    );
  }
}
