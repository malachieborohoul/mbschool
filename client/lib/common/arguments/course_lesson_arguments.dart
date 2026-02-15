import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/lecon.dart';

class CourseLessonArguments {
  final Lecon lecon;
  final Cours cours;
  CourseLessonArguments(this.cours, this.lecon);
}
