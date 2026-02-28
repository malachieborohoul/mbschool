import 'dart:convert';

class ReponseCommentaire {
  final String idReponse;

  final String intitulereponse;
  

  // final String created_at
  final String nom;
  final String prenom;
  final String photo;

  ReponseCommentaire({
    required this.idReponse,
    required this.intitulereponse,

    // required this.created_at,
    required this.nom,
    required this.prenom,
    required this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'idReponse': idReponse,
      'intitulereponse': intitulereponse,

      // 'created_at': created_at,
      'nom': nom,
      'prenom': prenom,
      'photo': photo,
    };
  }

  factory ReponseCommentaire.fromMap(Map<String, dynamic> map) {
    return ReponseCommentaire(
      idReponse: map['idReponse'] ?? '',
      intitulereponse: map['intitulereponse'] ?? '',

      // created_at: map['created_at'] ?? '',
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      photo: map['photo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ReponseCommentaire.fromJson(String source) =>
      ReponseCommentaire.fromMap(json.decode(source));
}
