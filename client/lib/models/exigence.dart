import 'dart:convert';

class Exigence {
  final String id_exigence;
  final String nom;
  final String id_cours;


  Exigence(
      {
        required this.id_exigence,
      required this.nom,
      required this.id_cours,
 });

  Map<String, dynamic> toMap() {
    return {
      'id_exigence': id_exigence,
      'nom': nom,
      'id_cours': id_cours,
      
    };
  }

  factory Exigence.fromMap(Map<String, dynamic> map) {
    return Exigence(
      id_exigence: map['id_exigence'] ?? '',
      nom: map['nom'] ?? '',
      id_cours: map['id_cours'] ?? '',
      
    );
  }

  String toJson() => json.encode(toMap());

  factory Exigence.fromJson(String source) => Exigence.fromMap(json.decode(source));
}
