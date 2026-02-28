import 'dart:convert';

class Resultat {
  final String idResultat;
  final String titre;
  final String idCours;


  Resultat(
      {
        required this.idResultat,
      required this.titre,
      required this.idCours,
 });

  Map<String, dynamic> toMap() {
    return {
      'idResultat': idResultat,
      'titre': titre,
      'idCours': idCours,
      
    };
  }

  factory Resultat.fromMap(Map<String, dynamic> map) {
    return Resultat(
      idResultat: map['idResultat'] ?? '',
      titre: map['titre'] ?? '',
      idCours: map['idCours'] ?? '',
      
    );
  }

  String toJson() => json.encode(toMap());

  factory Resultat.fromJson(String source) => Resultat.fromMap(json.decode(source));
}
