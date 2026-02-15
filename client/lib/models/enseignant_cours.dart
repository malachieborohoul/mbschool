import 'dart:convert';

class EnseignantCours {
  final String id_users;
  final String nom;
  final String prenom;
  final String photo;
  final String nombre_cours;


  EnseignantCours(
      {
        required this.id_users,
      required this.nom,
      required this.prenom,
      required this.photo,
      required this.nombre_cours,
 });

  Map<String, dynamic> toMap() {
    return {
      'id_users': id_users,
      'nom': nom,
      'prenom': prenom,
      'photo': photo,
      'nombre_cours': nombre_cours,
      
    };
  }

  factory EnseignantCours.fromMap(Map<String, dynamic> map) {
    return EnseignantCours(
      id_users: map['id_users'] ?? '',
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      photo: map['photo'] ?? '',
      nombre_cours: map['nombre_cours'] ?? '',
      
    );
  }

  String toJson() => json.encode(toMap());

  factory EnseignantCours.fromJson(String source) => EnseignantCours.fromMap(json.decode(source));
}
