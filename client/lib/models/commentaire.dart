import 'dart:convert';

class Commentaire {
  final String idCommentaire;

  final String intitule;
  final String numberDiscussions;
  final String numberReponses;

  // final String created_at
  final String nom;
  final String prenom;
  final String photo;

  Commentaire(  {
    required this.idCommentaire,
    required this.intitule,


    // required this.created_at,
    required this.nom,
    required this.prenom,
    required this.photo,
    required this.numberDiscussions,
    required this.numberReponses,
  });

  Map<String, dynamic> toMap() {
    return {
      'idCommentaire': idCommentaire,
      'intitule': intitule,

      // 'created_at': created_at,
      'nom': nom,
      'prenom': prenom,
      'photo': photo,
      'numberDiscussions': numberDiscussions,
      'numberReponses': numberReponses,
    };
  }

  factory Commentaire.fromMap(Map<String, dynamic> map) {
    return Commentaire(
      idCommentaire: map['idCommentaire'] ?? '',
      intitule: map['intitule'] ?? '',

      // created_at: map['created_at'] ?? '',
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      photo: map['photo'] ?? '',
      numberDiscussions: map['numberDiscussions'] ?? '',
      numberReponses: map['numberReponses'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Commentaire.fromJson(String source) =>
      Commentaire.fromMap(json.decode(source));
}
