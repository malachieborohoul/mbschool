import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:mbschool/models/lecon.dart';

class LeconProvider extends ChangeNotifier {
  Lecon _lecon = Lecon(
      idLecon: "",
      titre: "",
      url: "",
      resume: "",
      idCours: "",
      idSection: "",
      idTypeLecon: "");
  Lecon get lecon => _lecon;

  void setLecon(String lecon) {
    _lecon = Lecon.fromJson(lecon);
    notifyListeners();
  }

  void setLeconObject(Lecon lecon) {
    _lecon = lecon;
    notifyListeners();
  }
}
