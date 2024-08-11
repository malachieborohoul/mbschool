import 'dart:convert';

class Lecon {
  final String id_lecon;
  final String titre;
  final String url;
  final String resume;
  final String id_cours;
  final String id_section;
  final String id_type_lecon;

  Lecon({
    required this.id_lecon,
    required this.titre,
    required this.url,
    required this.resume,
    required this.id_cours,
    required this.id_section,
    required this.id_type_lecon,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_lecon': id_lecon,
      'titre': titre,
      'url': url,
      'resume': resume,
      'id_cours': id_cours,
      'id_section':id_section,
      'id_type_lecon':id_type_lecon,
    };
  }

  factory Lecon.fromMap(Map<String, dynamic> map) {
    return Lecon(
      id_lecon: map['id_lecon'] ?? '',
      titre: map['titre'] ?? '',
      url: map['url'] ?? '',
      resume: map['resume'] ?? '',
      id_cours: map['id_cours'] ?? '',
      id_section: map['id_section'] ?? '',
      id_type_lecon: map['id_type_lecon'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Lecon.fromJson(String source) => Lecon.fromMap(json.decode(source));
}
