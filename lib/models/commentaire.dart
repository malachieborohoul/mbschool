import 'dart:convert';

class Commentaire {
  final String id_commentaire;

  final String intitule;

  // final String created_at
  final String nom;
  final String prenom;
  final String photo;

  Commentaire({
    required this.id_commentaire,
    required this.intitule,

    // required this.created_at,
    required this.nom,
    required this.prenom,
    required this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_commentaire': id_commentaire,
      'intitule': intitule,

      // 'created_at': created_at,
      'nom': nom,
      'prenom': prenom,
      'photo': photo,
    };
  }

  factory Commentaire.fromMap(Map<String, dynamic> map) {
    return Commentaire(
      id_commentaire: map['id_commentaire'] ?? '',
      intitule: map['intitule'] ?? '',

      // created_at: map['created_at'] ?? '',
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      photo: map['photo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Commentaire.fromJson(String source) =>
      Commentaire.fromMap(json.decode(source));
}
