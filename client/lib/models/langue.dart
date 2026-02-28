import 'dart:convert';

class Langue {
  final String idLangue;
  final String nom;


  Langue(
      {required this.idLangue,
      required this.nom,
 });

  Map<String, dynamic> toMap() {
    return {
      'idLangue': idLangue,
      'nom': nom,
      
    };
  }

  factory Langue.fromMap(Map<String, dynamic> map) {
    return Langue(
      idLangue: map['idLangue'] ?? '',
      nom: map['nom'] ?? '',
      
    );
  }

  String toJson() => json.encode(toMap());

  factory Langue.fromJson(String source) => Langue.fromMap(json.decode(source));
}
