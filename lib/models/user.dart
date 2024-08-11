import 'dart:convert';

class User {
  final String id;
  final String nom;
  final String prenom;
  final String email;
  final String password;
  final String role;
  final String statut_users;
  final String photo;
  final String sexe;
  final String localisation;
  final String telephone;
  final String qualification;
  final String numCompte;
  final String cv;
  final String token;
  final String verify_code;

  User( {
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.password,
    required this.role,
    required this.statut_users,
    required this.photo,
    required this.sexe,
    required this.localisation,
    required this.telephone,
    required this.qualification,
    required this.numCompte,
    required this.cv,
    required this.token,
    required this.verify_code,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'password': password,
      'role': role,
      'statut_users': statut_users,
      'photo': photo,
      'sexe': sexe,
      'localisation': localisation,
      'telephone': telephone,
      'qualification': qualification,
      'numCompte': numCompte,
      'cv': cv,
      'token': token,
      'verify_code': verify_code,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      role: map['role'] ?? 0,
      statut_users: map['statut_users'] ?? '',
      photo: map['photo'] ?? '',
      sexe: map['sexe'] ?? '',
      localisation: map['localisation'] ?? '',
      telephone: map['telephone'] ?? '',
      qualification: map['qualification'] ?? '',
      numCompte: map['numCompte'] ?? '',
      cv: map['cv'] ?? '',
      token: map['token'] ?? '',
      verify_code: map['verify_code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
