import 'dart:convert';

class Section {
  final String idSection;
  final String titre;
  final String idCours;


  Section(
      {
        required this.idSection,
      required this.titre,
      required this.idCours,
 });

  Map<String, dynamic> toMap() {
    return {
      'idSection': idSection,
      'titre': titre,
      'idCours': idCours,
      
    };
  }

  factory Section.fromMap(Map<String, dynamic> map) {
    return Section(
      idSection: map['idSection'] ?? '',
      titre: map['titre'] ?? '',
      idCours: map['idCours'] ?? '',
      
    );
  }

  String toJson() => json.encode(toMap());

  factory Section.fromJson(String source) => Section.fromMap(json.decode(source));
}
