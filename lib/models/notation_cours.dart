import 'dart:convert';

class NotationCours {
  final String id_notation_cours;
  final String testimonial;
  final String id_cours;
  final String id_users;
  final String nom;
  final String prenom;
  final String note;
  final String photo;


  NotationCours(
      {
        required this.id_notation_cours,
      required this.testimonial,
      required this.id_cours,
      required this.id_users,
      required this.note,
      required this.nom,
      required this.prenom,
      required this.photo,
 });

  Map<String, dynamic> toMap() {
    return {
      'id_notation_cours': id_notation_cours,
      'testimonial': testimonial,
      'id_cours': id_cours,
      'id_users': id_users,
      'note': note,
      'nom': nom,
      'prenom': prenom,
      'photo': photo,
      
    };
  }

  factory NotationCours.fromMap(Map<String, dynamic> map) {
    return NotationCours(
      id_notation_cours: map['id_notation_cours'] ?? '',
      testimonial: map['testimonial'] ?? '',
      id_cours: map['id_cours'] ?? '',
      id_users: map['id_users'] ?? '',
      note: map['note'] ?? '',
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      photo: map['photo'] ?? '',
      
    );
  }

  String toJson() => json.encode(toMap());

  factory NotationCours.fromJson(String source) => NotationCours.fromMap(json.decode(source));
}
