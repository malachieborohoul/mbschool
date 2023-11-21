import 'dart:convert';

class Section {
  final String id_section;
  final String titre;
  final String id_cours;


  Section(
      {
        required this.id_section,
      required this.titre,
      required this.id_cours,
 });

  Map<String, dynamic> toMap() {
    return {
      'id_section': id_section,
      'titre': titre,
      'id_cours': id_cours,
      
    };
  }

  factory Section.fromMap(Map<String, dynamic> map) {
    return Section(
      id_section: map['id_section'] ?? '',
      titre: map['titre'] ?? '',
      id_cours: map['id_cours'] ?? '',
      
    );
  }

  String toJson() => json.encode(toMap());

  factory Section.fromJson(String source) => Section.fromMap(json.decode(source));
}
