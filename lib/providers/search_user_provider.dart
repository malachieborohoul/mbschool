import 'package:flutter/material.dart';
import 'package:mbschool/models/user.dart';

class SearchUserProvider extends ChangeNotifier {
  User _user =
      User(
          id: "",
          nom: "",
          prenom: "",
          email: "",
          password: "",
          role: '',
          photo: '',
          sexe: '',
          localisation: '',
          telephone: '',
          qualification: '',
          numCompte: '',
          cv: '',
          token: '', 
          verify_code: '', 
          statut_users: '');

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void set_user(User user) {
    _user = user;
    notifyListeners();
  }
}
