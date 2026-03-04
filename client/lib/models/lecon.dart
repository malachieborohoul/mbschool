import 'dart:convert';

class Lecon {
  final String idLecon;
  final String titre;
  final String url;
  final String resume;
  final String idCours;
  final String idSection;
  final String idTypeLecon;

  Lecon({
    required this.idLecon,
    required this.titre,
    required this.url,
    required this.resume,
    required this.idCours,
    required this.idSection,
    required this.idTypeLecon,
  });

  Map<String, dynamic> toMap() {
    return {
      'idLecon': idLecon,
      'titre': titre,
      'url': url,
      'resume': resume,
      'idCours': idCours,
      'idSection':idSection,
      'idTypeLecon':idTypeLecon,
    };
  }

  factory Lecon.fromMap(Map<String, dynamic> map) {
    return Lecon(
      idLecon: map['idLecon'] ?? '',
      titre: map['titre'] ?? '',
      url: map['url'] ?? '',
      resume: map['resume'] ?? '',
      idCours: map['idCours'] ?? '',
      idSection: map['idSection'] ?? '',
      idTypeLecon: map['idTypeLecon'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Lecon.fromJson(String source) => Lecon.fromMap(json.decode(source));
}
