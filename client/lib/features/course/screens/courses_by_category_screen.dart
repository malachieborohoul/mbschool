import 'package:flutter/material.dart';
import 'package:mbschool/common/widgets/custom_app_bar.dart';
import 'package:mbschool/common/widgets/custom_categories_button.dart';
import 'package:mbschool/common/widgets/custom_course_card.dart';

import 'package:mbschool/common/widgets/custom_person_card.dart';
import 'package:mbschool/common/widgets/custom_title.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/global.dart';

import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/datas/courses_json.dart';
import 'package:mbschool/features/course/screens/detail_course_screen.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/enseignant_cours.dart';

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

  late Future<List<Cours>> cours;
  late Future<List<Categorie>> categories;
  late Future<List<EnseignantCours>> enseignantPop;

  @override
  void initState() {
    getAllCoursesByCategory();
    getAllCategorieData();
    getAllEnseignantPopulaire();

    super.initState();
  }

  void getAllCoursesByCategory() {
    cours =
        courseManagerService.getAllCoursesByCategory(context, widget.categorie);
    setState(() {});
  }

  void getAllEnseignantPopulaire() {
    enseignantPop = courseManagerService.getAllEnseignantPopulaire(context);
    setState(() {});
  }

  getAllCategorieData() {
    categories = createCourseService.getAllCategorieData(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: CustomAppBar(
            backgroundColor: Colors.transparent,
            title: widget.categorie.nom.toUpperCase(),
          )),
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
                  child: FutureBuilder(
                    future: cours,
                    builder: (context, AsyncSnapshot<List<Cours>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Wrap(
                            spacing: 10,
                            children:
                                List.generate(snapshot.data!.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, DetailCourseScreen.routeName,
                                      arguments: snapshot.data![index]);
                                  Provider.of<CoursProvider>(context,
                                          listen: false)
                                      .set_cours(snapshot.data![index]);
                                },
                                child: CustomCourseCardExpand(
                                  thumbNail: Image.network(
                                    snapshot.data![index].vignette,
                                    fit: BoxFit.cover,
                                  ),
                                  videoAmount: CoursesJson[index]['video'],
                                  title: snapshot.data![index].titre,
                                  userProfile: snapshot.data![index].photo,
                                  userName: snapshot.data![index].nom,
                                  price: snapshot.data![index].prix.isEmpty
                                      ? "Gratuit"
                                      : snapshot.data![index].prix,
                                  cours: snapshot.data![index],
                                ),
                              );
                            }));
                      } else {
                        return const Loader();
                      }
                    },
                  ),
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
              FutureBuilder(
                future: categories,
                builder: (context, AsyncSnapshot<List<Categorie>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: List.generate(
                        snapshot.data!.length,
                        (index) {
                          return GestureDetector(
                            onTap: () => Navigator.pushReplacementNamed(
                                context, CoursesByCategoryScreen.routeName,
                                arguments: snapshot.data![index]),
                            child: CustomCategoriesButton(
                                title: snapshot.data![index].nom.toUpperCase()),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Loader();
                  }
                },
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
              FutureBuilder(
                future: enseignantPop,
                builder:
                    (context, AsyncSnapshot<List<EnseignantCours>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: List.generate(
                        snapshot.data!.length,
                        (index) {
                          return Builder(builder: (context) {
                            String fullName =
                                "${snapshot.data![index].nom} ${snapshot.data![index].prenom}";
                            return CustomPersonCard(
                                image: snapshot.data![index].photo,
                                name: fullName,
                                totalCourses:
                                    snapshot.data![index].nombre_cours,
                                totalStudents: "4");
                          });
                        },
                      ),
                    );
                  } else {
                    return const Loader();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
