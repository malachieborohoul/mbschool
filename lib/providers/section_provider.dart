import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/section.dart';
import 'package:mbschool/models/user.dart';

class SectionProvider extends ChangeNotifier {
  Section _section = Section(
    id_section: "",
    titre: "",
    id_cours: "",
  );
  Section get section => _section;

  void setSection(String section) {
    _section = Section.fromJson(section);
    notifyListeners();
  }

  void set_section(Section section) {
    _section = section;
    notifyListeners();
  }
}
