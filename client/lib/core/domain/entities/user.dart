class User {
  final int id;
  final String nom;
  final String prenom;
  final String email;
  final String password;
  final String role;
  final int statutUsers;
  final String photo;
  final String sexe;
  final String localisation;
  final String telephone;
  final String qualification;
  final String numCompte;
  final String cv;
  final String token;
  final String verifyCode;
  final bool verificationStatus;


  User( {
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.password,
    required this.role,
    required this.statutUsers,
    required this.photo,
    required this.sexe,
    required this.localisation,
    required this.telephone,
    required this.qualification,
    required this.numCompte,
    required this.cv,
    required this.token,
    required this.verifyCode,
    required this.verificationStatus,
  });
}