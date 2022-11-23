import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/lecon.dart';
import 'package:mbschool/models/section.dart';
import 'package:mbschool/models/user.dart';

class LeconProvider extends ChangeNotifier {
  Lecon _lecon = Lecon(
      id_lecon: "",
      titre: "",
      url: "",
      resume: "",
      id_cours: "",
      id_section: "",
      id_type_lecon: "");
  Lecon get lecon => _lecon;

  void setLecon(String lecon) {
    _lecon = Lecon.fromJson(lecon);
    notifyListeners();
  }

  void set_lecon(Lecon lecon) {
    _lecon = lecon;
    notifyListeners();
  }
}
