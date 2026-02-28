import 'dart:convert';

class Cours {
  final String idCours;
  final String titre;
  final String vignette;
  final double statut;
  final String description;
  final String descriptionCourte;
  final String idUsers;
  final String nom;
  final String prenom;
  final String photo;
  final String prix;
  final String idCategorie;
  final String idLangue;
  final String idNiveau;
  

  Cours( {
    required this.idCours,
    required this.titre,
    required this.vignette,
    required this.statut,
    required this.description,
    required this.descriptionCourte,
    required this.idUsers,
    required this.prix,
    required this.idCategorie,
    required this.idLangue,
    required this.idNiveau,
    required this.nom, 
    required this.prenom, 
    required this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'idCours': idCours,
      'titre': titre,
      'vignette': vignette,
      'statut': statut,
      'description': description,
      'descriptionCourte': descriptionCourte,
      'idUsers': idUsers,
      'nom': nom,
      'prenom': prenom,
      'photo': photo,
      'prix': prix,
      'idCategorie': idCategorie,
      'idLangue': idLangue,
      'idNiveau': idNiveau,
    };
  }

  factory Cours.fromMap(Map<String, dynamic> map) {
    return Cours(
      idCours: map['idCours'] ?? '',
      titre: map['titre'] ?? '',
      vignette: map['vignette'] ?? '',
      statut: map['statut']?.toDouble() ?? 0.0,
      description: map['description'] ?? '',
      descriptionCourte: map['descriptionCourte'] ?? '',
      idUsers: map['idUsers'] ?? '',
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      photo: map['photo'] ?? '',
      prix: map['prix'] ?? '',
      idCategorie: map['idCategorie'] ?? '',
      idLangue: map['idLangue'] ?? '',
      idNiveau: map['idNiveau'] ?? '',

    );
  }

  String toJson() => json.encode(toMap());

  factory Cours.fromJson(String source) => Cours.fromMap(json.decode(source));
}
