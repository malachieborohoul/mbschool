import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbschool/common/animations/opacity_tween.dart';
import 'package:mbschool/common/animations/slide_down_tween.dart';
import 'package:mbschool/common/widgets/custom_categories_button.dart';
import 'package:mbschool/common/widgets/custom_category_card.dart';
import 'package:mbschool/common/widgets/custom_course_card.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';
import 'package:mbschool/common/widgets/custom_promotion_card.dart';
import 'package:mbschool/common/widgets/custom_search_field.dart';
import 'package:mbschool/common/widgets/custom_title.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/common/widgets/navigation_drawer_admin.dart';
import 'package:mbschool/common/widgets/navigation_drawer_teacher.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/datas/courses_json.dart';
import 'package:mbschool/datas/user_profile.dart';
import 'package:mbschool/features/account/screens/edit_profile_screen.dart';
import 'package:mbschool/features/course/screens/all_course_screen.dart';
import 'package:mbschool/features/course/screens/courses_by_category_screen.dart';
import 'package:mbschool/features/course/screens/detail_course_screen.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
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
  final CourseManagerService courseManagerService = CourseManagerService();
  late Future<List<Cours>> cours;
  late Future<List<Categorie>> categories;

  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    cours = courseManagerService.getAllPublishedCourses(context);
    categories = createCourseService.getAllCategorieData(context);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        drawer: user.role == "1"
            ? Container()
            : user.role == "2"
                ? const NavigatorDrawerTeacher()
                : const NavigatorDrawerAdmin(),
        backgroundColor: background,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
        body: categories == null
            ? const Loader()
            : RefreshIndicator(
                color: primary,
                onRefresh: () async {
                  cours = courseManagerService.getAllPublishedCourses(context);
                  setState(() {});
                },
                child: SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: appPadding, right: appPadding),
                              child: Column(
                                children: [
                                  const SizedBox(height: spacer + 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SlideDownTween(
                                        offset: 70,
                                        child: OpacityTween(
                                          begin: 0.0,
                                          child: CustomHeading(
                                            title: "Bienvenue ${user.nom} ",
                                            subTitle:
                                                "Que voulez-vous apprendre?",
                                            color: secondary,
                                          ),
                                        ),
                                      ),
                                      SlideDownTween(
                                        offset: 70,
                                        child: OpacityTween(
                                          begin: 0.0,
                                          child: SizedBox(
                                            height: spacer,
                                            width: spacer,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    EditProfileScreen
                                                        .routeName);
                                              },
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundColor: grey,
                                                child: ClipOval(
                                                  child: user.photo.isNotEmpty
                                                      ? Image.network(
                                                          user.photo,
                                                          width: 60,
                                                          height: 60,
                                                          fit: BoxFit
                                                              .cover, // Assure que l'image couvre tout le cercle
                                                        )
                                                      : Image.asset(
                                                          UserProfile['image']
                                                              .toString(),
                                                          width: 60,
                                                          height: 60,
                                                          fit: BoxFit
                                                              .cover, // Assure que l'image couvre tout le cercle
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: spacer),
                                  const SlideDownTween(
                                    offset: 70,
                                    child: OpacityTween(
                                      begin: 0.0,
                                      child: CustomSearchField(
                                        onTap: true,
                                        hintField:
                                            "Essayez le Développement mobile",
                                        backgroundColor: textWhite,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: spacer - 30),
                                  const SlideDownTween(
                                    offset: 70,
                                    child: OpacityTween(
                                        begin: 0.0,
                                        child: CustomCategoryCard()),
                                  ),
                                  const SizedBox(height: spacer),
                                  const SlideDownTween(
                                    offset: 70,
                                    child: OpacityTween(
                                        begin: 0.0,
                                        child: CustomPromotionCard()),
                                  ),
                                  const SizedBox(height: spacer),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: appPadding - 20,
                                        right: appPadding - 20),
                                    child: CustomTitle(
                                      title: "Cours populaires",
                                      titreLien: "Voir plus",
                                      route: AllCourseScreen.routeName,
                                      arg: cours,
                                    ),
                                  ),
                                  const SizedBox(height: smallSpacer),
                                  SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: appPadding - 20,
                                          right: appPadding - 10),
                                      child: FutureBuilder(
                                        future: cours,
                                        builder: (context,
                                            AsyncSnapshot<List<Cours>>
                                                snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return Wrap(
                                              spacing: 10,
                                              children: List.generate(
                                                snapshot.data!.length,
                                                (index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                        context,
                                                        DetailCourseScreen
                                                            .routeName,
                                                        arguments: snapshot
                                                            .data![index],
                                                      );

                                                      Provider.of<CoursProvider>(
                                                              context,
                                                              listen: false)
                                                          .set_cours(snapshot
                                                              .data![index]);
                                                    },
                                                    child:
                                                        CustomCourseCardExpand(
                                                      thumbNail: Hero(
                                                        tag: snapshot
                                                            .data![index]
                                                            .vignette,
                                                        child: Image.network(
                                                          snapshot.data![index]
                                                              .vignette,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      videoAmount:
                                                          CoursesJson[index]
                                                              ['video'],
                                                      title: snapshot
                                                          .data![index].titre,
                                                      userProfile: snapshot
                                                          .data![index].photo,
                                                      userName: snapshot
                                                          .data![index].nom,
                                                      price: snapshot
                                                              .data![index]
                                                              .prix
                                                              .isEmpty
                                                          ? "Gratuit"
                                                          : snapshot
                                                              .data![index]
                                                              .prix,
                                                      cours:
                                                          snapshot.data![index],
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          } else {
                                            return const Loader();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: spacer - 20),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: appPadding - 20),
                                    child: CustomTitle(title: "Catégories"),
                                  ),
                                  const SizedBox(height: smallSpacer),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: appPadding),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: FutureBuilder(
                                        future: categories,
                                        builder: (context,
                                            AsyncSnapshot<List<Categorie>>
                                                snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return Row(
                                              children: List.generate(
                                                snapshot.data!.length,
                                                (index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            top: 10,
                                                            bottom: 5),
                                                    child: InkWell(
                                                      splashColor:
                                                          const Color.fromRGBO(
                                                              158, 158, 158, 1),
                                                      onTap: () =>
                                                          Navigator.pushNamed(
                                                              context,
                                                              CoursesByCategoryScreen
                                                                  .routeName,
                                                              arguments:
                                                                  snapshot.data![
                                                                      index]),
                                                      child:
                                                          CustomCategoriesButton(
                                                        title: snapshot
                                                            .data![index].nom
                                                            .toUpperCase(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          } else {
                                            return const Loader();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: spacer),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
