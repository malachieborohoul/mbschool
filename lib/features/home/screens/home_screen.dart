import 'package:flutter/material.dart';
import 'package:mbschool/common/animations/slide_down_tween.dart';
import 'package:mbschool/common/widgets/clipper.dart';
import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/common/widgets/custom_categories_button.dart';
import 'package:mbschool/common/widgets/custom_category_card.dart';
import 'package:mbschool/common/widgets/custom_course_card.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';
import 'package:mbschool/common/widgets/custom_promotion_card.dart';
import 'package:mbschool/common/widgets/custom_search_field.dart';
import 'package:mbschool/common/widgets/custom_title.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/datas/category_json.dart';
import 'package:mbschool/datas/courses_json.dart';
import 'package:mbschool/datas/user_profile.dart';
import 'package:mbschool/features/account/screens/account_screen.dart';
import 'package:mbschool/features/account/screens/edit_profile_screen.dart';
import 'package:mbschool/features/course/screens/all_course_screen.dart';
import 'package:mbschool/features/course/screens/courses_by_category_screen.dart';
import 'package:mbschool/features/course/screens/detail_course_screen.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/features/search/screens/search_screen.dart';
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/providers/course_provider.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  CourseManagerService courseManagerService = CourseManagerService();
  List<Cours> cours = [];
  List<Categorie> categories = [];

  late final AnimationController _animationController;
  late final Animation<double> _animation;
  @override
  void initState() {
    getAllCourses();
    getAllCategorieData();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));

    _animation =
        Tween<double>(begin: 1.0, end: 5.0).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void getAllCourses() async {
    cours = await courseManagerService.getAllCourses(context);
    setState(() {});
  }

  getAllCategorieData() async {
    categories = await createCourseService.getAllCategorieData(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),

      child: Scaffold(
        backgroundColor: background,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            brightness: Brightness.light,
          ),
        ),
        body: cours == null || categories==null? Loader(): SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  // SlideDownTween(
                  //   child: ClipPath(
                  //     clipper: BottomClipper(),
                  //     child: Container(
                  //       width: size.width,
                  //       height: 300,
                  //       decoration: BoxDecoration(color: secondary),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: appPadding, right: appPadding),
                    child: Column(
                      children: [
                        SizedBox(
                          height: spacer + 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SlideDownTween(
                              offset: 70,
                              child: CustomHeading(
                                  title: "Bienvenue ${user.nom} ",
                                  subTitle: "Que voulez vous apprendre?",
                                  color: secondary),
                            ),
                            SlideDownTween(
                              offset: 70,
                              child: Container(
                                height: spacer,
                                width: spacer,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AccountScreen.routeName);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: user.photo.isNotEmpty
                                        ? Image.network(
                                            user.photo,
                                          )
                                        : Image.asset(
                                            UserProfile['image'].toString(),
                                          ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: spacer,
                        ),
                        SlideDownTween(
                          offset: 70,
                          child: CustomSearchField(
                            onTap: true,
                            hintField: "Essayez le Developpement mobile",
                            backgroundColor: textWhite,
                          ),
                        ),
                        const SizedBox(
                          height: spacer - 30,
                        ),
                        SlideDownTween(offset: 70, child: CustomCategoryCard()),
                        const SizedBox(
                          height: spacer,
                        ),
                        SlideDownTween(
                            offset: 70, child: const CustomPromotionCard()),
                        const SizedBox(
                          height: spacer,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: appPadding - 20, right: appPadding - 20),
                          child: CustomTitle(
                            title: "Cours populaires",
                            titreLien: "Voir plus",
                            route: AllCourseScreen.routeName,
                            arg: cours,
                          ),
                        ),
                        const SizedBox(
                          height: smallSpacer,
                        ),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: appPadding - 20, right: appPadding - 10),
                            child: Wrap(
                                spacing: 10,
                                children: List.generate(cours.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, DetailCourseScreen.routeName,
                                          arguments: cours[index]);
    
                                      Provider.of<CoursProvider>(context,
                                              listen: false).set_cours(cours[index]);
                                    },
                                    child: cours == null
                                        ? Loader()
                                        : CustomCourseCardExpand(
                                            thumbNail: Hero(
                                              tag: cours[index].vignette,
                                              child: Image.network(
                                                cours[index].vignette,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            videoAmount: CoursesJson[index]
                                                ['video'],
                                            title: cours[index].titre,
                                            userProfile: cours[index].photo,
                                            userName: cours[index].nom,
                                            price: cours[index].prix.isEmpty
                                                ? "Gratuit"
                                                : cours[index].prix,
                                            cours: cours[index],
                                          ),
                                  );
                                })),
                          ),
                        ),
                        const SizedBox(
                          height: spacer - 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: appPadding - 20),
                          child: CustomTitle(title: "Categories"),
                        ),
                        const SizedBox(
                          height: smallSpacer,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: appPadding),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    children:
                                        List.generate(categories.length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 10, bottom: 5),
                                    child: InkWell(
                                      splashColor: Colors.grey,
                                      onTap: () => Navigator.pushNamed(context,
                                          CoursesByCategoryScreen.routeName,
                                          arguments: categories[index]),
                                      child: CustomCategoriesButton(
                                          title: categories[index]
                                              .nom
                                              .toUpperCase()),
                                    ),
                                  );
                                })),
                                // Row(
                                //     children: List.generate(CategoryJson2.length,
                                //         (index) {
                                //   return Padding(
                                //     padding: const EdgeInsets.only(
                                //         left: 5, right: 10, top: 10, bottom: 5),
                                //     child: CustomCategoriesButton(
                                //         title: CategoryJson2[index]['title']),
                                //   );
                                // })),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: spacer,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: appPadding - 20, right: appPadding - 20),
                          child: CustomTitle(title: "Cours Design"),
                        ),
                        const SizedBox(
                          height: smallSpacer,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
