import 'package:flutter/material.dart';
import 'package:mbschool/common/arguments/course_lesson_arguments.dart';
import 'package:mbschool/common/arguments/select_file_arguments.dart';
import 'package:mbschool/common/widgets/bottom_bar.dart';
import 'package:mbschool/features/account/screens/account_screen.dart';
import 'package:mbschool/features/account/screens/edit_profile_screen.dart';
import 'package:mbschool/features/auth/screens/auth_screen.dart';
import 'package:mbschool/features/course/screens/all_course_screen.dart';
import 'package:mbschool/features/course/screens/course_screen.dart';
import 'package:mbschool/features/course/screens/courses_by_category_screen.dart';
import 'package:mbschool/features/course/screens/detail_course_screen.dart';
import 'package:mbschool/features/course/screens/detail_lesson_screen.dart';
import 'package:mbschool/features/course/screens/rate_course_screen.dart';
import 'package:mbschool/features/favorite/screens/favorite_screen.dart';
import 'package:mbschool/features/filter/screens/filter_course_screen.dart';
import 'package:mbschool/features/home/screens/detail_teacher_course_screen.dart';
import 'package:mbschool/features/intro/screens/intro_screen.dart';
import 'package:mbschool/features/intro/screens/verification_screen.dart';
import 'package:mbschool/features/panel/course_manager/screens/course_manager_screen.dart';
import 'package:mbschool/features/panel/course_manager/screens/exigence_screen.dart';
import 'package:mbschool/features/panel/course_manager/screens/modify_course_screen.dart';
import 'package:mbschool/features/panel/course_manager/screens/plan_screen.dart';
import 'package:mbschool/features/panel/course_manager/screens/select_file.dart';
import 'package:mbschool/features/panel/create_course/screens/create_course_screen.dart';
import 'package:mbschool/features/search/screens/search_screen.dart';
import 'package:mbschool/main.dart';
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/lecon.dart';
import 'package:page_transition/page_transition.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());
    case CourseScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CourseScreen());
    case AllCourseScreen.routeName:
      var cours = routeSettings.arguments as List<Cours>;

      return PageTransition(
        settings: routeSettings,
        child: AllCourseScreen(
          cours: cours,
        ),
        type: PageTransitionType.bottomToTop,
      );
    case FavoriteScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const FavoriteScreen());
    case AuthScreen.routeName:
      return PageTransition(
          settings: routeSettings, child:  const AuthScreen(), type: PageTransitionType.leftToRight);

    case EditProfileScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const EditProfileScreen());

    case AccountScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AccountScreen());

    case CreateCourseScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CreateCourseScreen());

    case CourseManagerScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CourseManagerScreen());

    case PlanScreen.routeName:
      var cours = routeSettings.arguments as Cours;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => PlanScreen(cours: cours));

    case SelectFile.routeName:
      var codeFile = routeSettings.arguments as SelectFileArguments;
      var cours = routeSettings.arguments as SelectFileArguments;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SelectFile(
                codeFile: codeFile.codeFile,
                cours: cours.cours,
              ));

    case ModifyCourseScreen.routeName:
      var cours = routeSettings.arguments as Cours;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ModifyCourseScreen(cours: cours));

    case ExigenceScreen.routeName:
      var cours = routeSettings.arguments as Cours;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ExigenceScreen(cours: cours));

    case DetailCourseScreen.routeName:
      var cours = routeSettings.arguments as Cours;

      return PageTransition(
          settings: routeSettings,
          child: DetailCourseScreen(
            cours: cours,
          ),
          type: PageTransitionType.fade);

    case DetailTeacherCourseScreen.routeName:
      var cours = routeSettings.arguments as Cours;

      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => DetailTeacherCourseScreen(
                cours: cours,
              ));

    case CoursesByCategoryScreen.routeName:
      var categorie = routeSettings.arguments as Categorie;

      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CoursesByCategoryScreen(
                categorie: categorie,
              ));

    case FilterCourseScreen.routeName:
      var controller = routeSettings.arguments as ScrollController?;

      return PageTransition(
          settings: routeSettings,
          child: FilterCourseScreen(
            controller: controller,
          ),
          curve: Curves.easeOut,
          type: PageTransitionType.bottomToTop);

    case SearchScreen.routeName:
      return PageTransition(
          settings: routeSettings,
          child: SearchScreen(),
          curve: Curves.easeOut,
          type: PageTransitionType.fade);

    case DetailLessonScreen.routeName:
      var cours = routeSettings.arguments as CourseLessonArguments;
      var lecon = routeSettings.arguments as CourseLessonArguments;

      //  var codeFile = routeSettings.arguments as SelectFileArguments;
      // var cours = routeSettings.arguments as SelectFileArguments;

      return PageTransition(
          settings: routeSettings,
          child: DetailLessonScreen(
            cours: cours.cours,
            lecon: lecon.lecon,
          ),
          type: PageTransitionType.fade);

    case IntroScreen.routeName:
      return PageTransition(
          settings: routeSettings,
          child: IntroScreen(),
          curve: Curves.easeOut,
          type: PageTransitionType.rightToLeft);

    case VerificationScreen.routeName:
      return PageTransition(
          settings: routeSettings,
          child: VerificationScreen(),
          curve: Curves.easeOut,
          type: PageTransitionType.rightToLeft);

     case RateCourseScreen.routeName:
      return PageTransition(
          settings: routeSettings, child:  const RateCourseScreen(), type: PageTransitionType.leftToRight);
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("ERREUR 404"),
                ),
              ));
  }
}
