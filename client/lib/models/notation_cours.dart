import 'dart:convert';

class NotationCours {
  final String idNotationCours;
  final String testimonial;
  final String idCours;
  final String idUsers;
  final String nom;
  final String prenom;
  final String note;
  final String photo;


  NotationCours(
      {
        required this.idNotationCours,
      required this.testimonial,
      required this.idCours,
      required this.idUsers,
      required this.note,
      required this.nom,
      required this.prenom,
      required this.photo,
 });

  Map<String, dynamic> toMap() {
    return {
      'idNotationCours': idNotationCours,
      'testimonial': testimonial,
      'idCours': idCours,
      'idUsers': idUsers,
      'note': note,
      'nom': nom,
      'prenom': prenom,
      'photo': photo,
      
    };
  }

  factory NotationCours.fromMap(Map<String, dynamic> map) {
    return NotationCours(
      idNotationCours: map['idNotationCours'] ?? '',
      testimonial: map['testimonial'] ?? '',
      idCours: map['idCours'] ?? '',
      idUsers: map['idUsers'] ?? '',
      note: map['note'] ?? '',
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      photo: map['photo'] ?? '',
      
    );
  }

  String toJson() => json.encode(toMap());

  factory NotationCours.fromJson(String source) => NotationCours.fromMap(json.decode(source));
}
