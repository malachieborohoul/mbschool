import 'dart:convert';

class EnseignantCours {
  final String idUsers;
  final String nom;
  final String prenom;
  final String photo;
  final String nombreCours;


  EnseignantCours(
      {
        required this.idUsers,
      required this.nom,
      required this.prenom,
      required this.photo,
      required this.nombreCours,
 });

  Map<String, dynamic> toMap() {
    return {
      'idUsers': idUsers,
      'nom': nom,
      'prenom': prenom,
      'photo': photo,
      'nombreCours': nombreCours,
      
    };
  }

  factory EnseignantCours.fromMap(Map<String, dynamic> map) {
    return EnseignantCours(
      idUsers: map['idUsers'] ?? '',
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      photo: map['photo'] ?? '',
      nombreCours: map['nombreCours'] ?? '',
      
    );
  }

  String toJson() => json.encode(toMap());

  factory EnseignantCours.fromJson(String source) => EnseignantCours.fromMap(json.decode(source));
}
