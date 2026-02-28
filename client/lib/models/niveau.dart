import 'dart:convert';

class Niveau {
  final String idNiveau;
  final String titre;


  Niveau(
      {required this.idNiveau,
      required this.titre,
 });

  Map<String, dynamic> toMap() {
    return {
      'idNiveau': idNiveau,
      'titre': titre,
      
    };
  }

  factory Niveau.fromMap(Map<String, dynamic> map) {
    return Niveau(
      idNiveau: map['idNiveau'] ?? '',
      titre: map['titre'] ?? '',
      
    );
  }

  String toJson() => json.encode(toMap());

  factory Niveau.fromJson(String source) => Niveau.fromMap(json.decode(source));
}
