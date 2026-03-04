import 'dart:convert';

class Exigence {
  final String idExigence;
  final String nom;
  final String idCours;


  Exigence(
      {
        required this.idExigence,
      required this.nom,
      required this.idCours,
 });

  Map<String, dynamic> toMap() {
    return {
      'idExigence': idExigence,
      'nom': nom,
      'idCours': idCours,
      
    };
  }

  factory Exigence.fromMap(Map<String, dynamic> map) {
    return Exigence(
      idExigence: map['idExigence'] ?? '',
      nom: map['nom'] ?? '',
      idCours: map['idCours'] ?? '',
      
    );
  }

  String toJson() => json.encode(toMap());

  factory Exigence.fromJson(String source) => Exigence.fromMap(json.decode(source));
}
