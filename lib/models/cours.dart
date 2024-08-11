import 'dart:convert';

class Cours {
  final String id_cours;
  final String titre;
  final String vignette;
  final double statut;
  final String description;
  final String description_courte;
  final String id_users;
  final String nom;
  final String prenom;
  final String photo;
  final String prix;
  final String id_categorie;
  final String id_langue;
  final String id_niveau;
  

  Cours( {
    required this.id_cours,
    required this.titre,
    required this.vignette,
    required this.statut,
    required this.description,
    required this.description_courte,
    required this.id_users,
    required this.prix,
    required this.id_categorie,
    required this.id_langue,
    required this.id_niveau,
    required this.nom, 
    required this.prenom, 
    required this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_cours': id_cours,
      'titre': titre,
      'vignette': vignette,
      'statut': statut,
      'description': description,
      'description_courte': description_courte,
      'id_users': id_users,
      'nom': nom,
      'prenom': prenom,
      'photo': photo,
      'prix': prix,
      'id_categorie': id_categorie,
      'id_langue': id_langue,
      'id_niveau': id_niveau,
    };
  }

  factory Cours.fromMap(Map<String, dynamic> map) {
    return Cours(
      id_cours: map['id_cours'] ?? '',
      titre: map['titre'] ?? '',
      vignette: map['vignette'] ?? '',
      statut: map['statut']?.toDouble() ?? 0.0,
      description: map['description'] ?? '',
      description_courte: map['description_courte'] ?? '',
      id_users: map['id_users'] ?? '',
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      photo: map['photo'] ?? '',
      prix: map['prix'] ?? '',
      id_categorie: map['id_categorie'] ?? '',
      id_langue: map['id_langue'] ?? '',
      id_niveau: map['id_niveau'] ?? '',

    );
  }

  String toJson() => json.encode(toMap());

  factory Cours.fromJson(String source) => Cours.fromMap(json.decode(source));
}
