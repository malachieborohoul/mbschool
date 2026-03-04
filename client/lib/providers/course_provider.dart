import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:mbschool/models/cours.dart';

class CoursProvider extends ChangeNotifier {
  Cours _cours = Cours(
      idCours: "",
      titre: "",
      vignette: "",
      statut: 0.0,
      description: "",
      descriptionCourte: "",
      idUsers: "",
      prix: "",
      idCategorie: "",
      idLangue: "",
      idNiveau: "",
      nom: "",
      prenom: "",
      photo: "");

  Cours get cours => _cours;

  void setCours(String cours) {
    _cours = Cours.fromJson(cours);
    notifyListeners();
  }

  void setCoursObject(Cours cours) {
    _cours = cours;
    notifyListeners();
  }
}
