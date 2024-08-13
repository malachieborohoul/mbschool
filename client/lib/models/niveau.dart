import 'dart:convert';

class Niveau {
  final String id_niveau;
  final String titre;


  Niveau(
      {required this.id_niveau,
      required this.titre,
 });

  Map<String, dynamic> toMap() {
    return {
      'id_niveau': id_niveau,
      'titre': titre,
      
    };
  }

  factory Niveau.fromMap(Map<String, dynamic> map) {
    return Niveau(
      id_niveau: map['id_niveau'] ?? '',
      titre: map['titre'] ?? '',
      
    );
  }

  String toJson() => json.encode(toMap());

  factory Niveau.fromJson(String source) => Niveau.fromMap(json.decode(source));
}
