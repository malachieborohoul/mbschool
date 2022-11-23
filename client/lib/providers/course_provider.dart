import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/user.dart';

class CoursProvider extends ChangeNotifier {
  Cours _cours = Cours(
      id_cours: "",
      titre: "",
      vignette: "",
      statut: 0.0,
      description: "",
      description_courte: "",
      id_users: "",
      prix: "",
      id_categorie: "",
      id_langue: "",
      id_niveau: "",
      nom: "",
      prenom: "",
      photo: "");

  Cours get cours => _cours;

  void setCours(String cours) {
    _cours = Cours.fromJson(cours);
    notifyListeners();
  }

  void set_cours(Cours cours) {
    _cours = cours;
    notifyListeners();
  }
}
