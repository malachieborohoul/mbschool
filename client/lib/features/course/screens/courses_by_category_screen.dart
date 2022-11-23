import 'package:flutter/material.dart';
import 'package:mbschool/common/widgets/custom_app_bar.dart';
import 'package:mbschool/common/widgets/custom_categories_button.dart';
import 'package:mbschool/common/widgets/custom_course_card.dart';
import 'package:mbschool/common/widgets/custom_course_curriculum.dart';
import 'package:mbschool/common/widgets/custom_course_price_footer.dart';
import 'package:mbschool/common/widgets/custom_detail_course_info_header.dart';
import 'package:mbschool/common/widgets/custom_exigence_cours.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';
import 'package:mbschool/common/widgets/custom_my_courses_card.dart';
import 'package:mbschool/common/widgets/custom_person_card.dart';
import 'package:mbschool/common/widgets/custom_title.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/datas/courses_json.dart';
import 'package:mbschool/features/course/screens/detail_course_screen.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/features/panel/course_manager/services/exigence_service.dart';
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/enseignant_cours.dart';
import 'package:mbschool/models/exigence.dart';
import 'package:mbschool/models/section.dart';
import 'package:mbschool/providers/course_provider.dart';
import 'package:provider/provider.dart';

class CoursesByCategoryScreen extends StatefulWidget {
  static const routeName = 'courses-by-category-screen';
  final Categorie categorie;
  const CoursesByCategoryScreen({Key? key, required this.categorie})
      : super(key: key);

  @override
  State<CoursesByCategoryScreen> createState() =>
      _CoursesByCategoryScreenState();
}

class _CoursesByCategoryScreenState extends State<CoursesByCategoryScreen>
    with TickerProviderStateMixin {
  CourseManagerService courseManagerService = CourseManagerService();

  List<Cours> cours = [];
  List<Categorie> categories = [];
  List<EnseignantCours> enseignantPop = [];

  @override
  void initState() {
    getAllCoursesByCategory();
    getAllCategorieData();
    getAllEnseignantPopulaire();

    super.initState();
  }

  void getAllCoursesByCategory() async {
    cours = await courseManagerService.getAllCoursesByCategory(
        context, widget.categorie);
    setState(() {});
  }

  void getAllEnseignantPopulaire() async {
    enseignantPop =
        await courseManagerService.getAllEnseignantPopulaire(context);
    setState(() {});
  }

  getAllCategorieData() async {
    categories = await createCourseService.getAllCategorieData(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          child: CustomAppBar(
            backgroundColor: Colors.transparent,
            title: widget.categorie.nom.toUpperCase(),
          ),
          preferredSize: Size.fromHeight(40)),
      // body: Center(
      //   child: Column(
      //     children: [
      //       CustomPersonCard(
      //           image: widget.cours.photo,
      //           name: widget.cours.nom,
      //           course: widget.cours.titre,
      //           totalCourses: "2",
      //           totalStudents: "2")
      //     ],
      //   ),
      // ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(appPadding),
          child: Column(
            children: [
              const SizedBox(
                height: appPadding * 3,
              ),
              const Padding(
                padding: EdgeInsets.only(
                    left: appPadding - 20, right: appPadding - 20),
                child: CustomTitle(
                  title: "Cours ",
                  extend: false,
                ),
              ),
              const SizedBox(
                height: smallSpacer,
              ),
              SingleChildScrollView(
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
                            Provider.of<CoursProvider>(context, listen: false)
                                .set_cours(cours[index]);
                          },
                          child: cours == null
                              ? Loader()
                              : CustomCourseCardExpand(
                                  thumbNail: Image.network(
                                    cours[index].vignette,
                                    fit: BoxFit.cover,
                                  ),
                                  videoAmount: CoursesJson[index]['video'],
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
                height: spacer,
              ),
              const CustomTitle(
                title: "Categories populaires",
                extend: false,
              ),
              const SizedBox(
                height: appPadding,
              ),
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: List.generate(
                  categories.length,
                  (index) {
                    return GestureDetector(
                      onTap: () => Navigator.pushReplacementNamed(
                          context, CoursesByCategoryScreen.routeName,
                          arguments: categories[index]),
                      child: CustomCategoriesButton(
                          title: categories[index].nom.toUpperCase()),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: spacer,
              ),
              const CustomTitle(
                title: "Enseignants populaires",
                extend: false,
              ),
              const SizedBox(
                height: appPadding,
              ),
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: List.generate(
                  enseignantPop.length,
                  (index) {
                    return Builder(builder: (context) {
                      String fullName = enseignantPop[index].nom +
                          " " +
                          enseignantPop[index].prenom;
                      return CustomPersonCard(
                          image: enseignantPop[index].photo,
                          name: fullName,
                          totalCourses: enseignantPop[index].nombre_cours,
                          totalStudents: "4");
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
