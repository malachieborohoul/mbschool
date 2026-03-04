import 'dart:convert';

class Categorie {
  final String idCategorie;
  final String nom;

  Categorie({
    required this.idCategorie,
    required this.nom,
  });

  Map<String, dynamic> toMap() {
    return {
      'idCategorie': idCategorie,
      'nom': nom,
    };
  }

  factory Categorie.fromMap(Map<String, dynamic> map) {
    return Categorie(
      idCategorie: map['idCategorie'] ?? '',
      nom: map['nom'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Categorie.fromJson(String source) =>
      Categorie.fromMap(json.decode(source));
}
