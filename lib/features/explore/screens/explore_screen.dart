import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/custom_categories_button.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';
import 'package:mbschool/common/widgets/custom_place_holder.dart';
import 'package:mbschool/common/widgets/custom_search_field.dart';
import 'package:mbschool/common/widgets/custom_title.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/datas/category_json.dart';

class ExploreScreen extends StatefulWidget {
  static const routeName = '/explore';
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
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
                title: "Explorer",
                subTitle: "Rechercher votre préférence",
                color: secondary),
            const SizedBox(
              height: spacer,
            ),
            const CustomSearchField(
              hintField: "Essayez le développment mobile",
              backgroundColor: textWhite,
            ),
            const SizedBox(
              height: spacer,
            ),
            const CustomTitle(
              title: "Top Recherches",
              extend: false,
            ),
            const SizedBox(
              height: spacer,
            ),
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: List.generate(
                CategoryJson.length,
                (index) {
                  return CustomCategoriesButton(
                      title: CategoryJson[index]['title']);
                },
              ),
            ),
             const SizedBox(
              height: spacer,
            ),

            const CustomTitle(
              title: "Categories",
              extend: false,
            ),

              const SizedBox(
              height: smallSpacer,
            ),

            Column(
              children: List.generate(AllCategories.length, (index){
                return CunstomPlaceHolder(title: AllCategories[index]['title']);
              })
            )



             
          ],
        ),
      ),
    );
  }
}
