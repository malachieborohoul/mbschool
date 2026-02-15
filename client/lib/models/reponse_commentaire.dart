import 'dart:convert';

class ReponseCommentaire {
  final String id_reponse;

  final String intitule_reponse;
  

  // final String created_at
  final String nom;
  final String prenom;
  final String photo;

  ReponseCommentaire({
    required this.id_reponse,
    required this.intitule_reponse,

    // required this.created_at,
    required this.nom,
    required this.prenom,
    required this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_reponse': id_reponse,
      'intitule_reponse': intitule_reponse,

      // 'created_at': created_at,
      'nom': nom,
      'prenom': prenom,
      'photo': photo,
    };
  }

  factory ReponseCommentaire.fromMap(Map<String, dynamic> map) {
    return ReponseCommentaire(
      id_reponse: map['id_reponse'] ?? '',
      intitule_reponse: map['intitule_reponse'] ?? '',

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
