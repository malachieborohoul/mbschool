import 'dart:convert';

class Langue {
  final String id_langue;
  final String nom;


  Langue(
      {required this.id_langue,
      required this.nom,
 });

  Map<String, dynamic> toMap() {
    return {
      'id_langue': id_langue,
      'nom': nom,
      
    };
  }

  factory Langue.fromMap(Map<String, dynamic> map) {
    return Langue(
      id_langue: map['id_langue'] ?? '',
      nom: map['nom'] ?? '',
      
    );
  }

  String toJson() => json.encode(toMap());

  factory Langue.fromJson(String source) => Langue.fromMap(json.decode(source));
}
