import 'dart:convert';

class Categorie {
  final String id_categorie;
  final String nom;

  Categorie({
    required this.id_categorie,
    required this.nom,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_categorie': id_categorie,
      'nom': nom,
    };
  }

  factory Categorie.fromMap(Map<String, dynamic> map) {
    return Categorie(
      id_categorie: map['id_categorie'] ?? '',
      nom: map['nom'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Categorie.fromJson(String source) =>
      Categorie.fromMap(json.decode(source));
}
