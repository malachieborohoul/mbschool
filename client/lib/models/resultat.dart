import 'dart:convert';

class Resultat {
  final String id_resultat;
  final String titre;
  final String id_cours;


  Resultat(
      {
        required this.id_resultat,
      required this.titre,
      required this.id_cours,
 });

  Map<String, dynamic> toMap() {
    return {
      'id_resultat': id_resultat,
      'titre': titre,
      'id_cours': id_cours,
      
    };
  }

  factory Resultat.fromMap(Map<String, dynamic> map) {
    return Resultat(
      id_resultat: map['id_resultat'] ?? '',
      titre: map['titre'] ?? '',
      id_cours: map['id_cours'] ?? '',
      
    );
  }

  String toJson() => json.encode(toMap());

  factory Resultat.fromJson(String source) => Resultat.fromMap(json.decode(source));
}
