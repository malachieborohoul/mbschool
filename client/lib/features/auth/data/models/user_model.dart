import 'dart:convert';

import 'package:mbschool/core/domain/entities/user.dart';




class UserModel extends User {
  UserModel( {
    required super.id,
    required super.nom,
    required super.prenom,
    required super.email,
    required super.password,
    required super.role,
    required super.statut_users,
    required super.photo,
    required super.sexe,
    required super.localisation,
    required super.telephone,
    required super.qualification,
    required super.numCompte,
    required super.cv,
    required super.token,
    required super.verify_code, 
    required super.verification_status,


   });
  
  
  

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'password': password,
      'role': role,
      'statut_users': statut_users,
      'photo': photo,
      'sexe': sexe,
      'localisation': localisation,
      'telephone': telephone,
      'qualification': qualification,
      'numCompte': numCompte,
      'cv': cv,
      'token': token,
      'verify_code': verify_code,
      'verification_status': verification_status,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
  id: map['id'] ?? '',
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      role: map['role'] ?? 0,
      statut_users: map['statut_users'] ?? '',
      photo: map['photo'] ?? '',
      sexe: map['sexe'] ?? '',
      localisation: map['localisation'] ?? '',
      telephone: map['telephone'] ?? '',
      qualification: map['qualification'] ?? '',
      numCompte: map['numCompte'] ?? '',
      cv: map['cv'] ?? '',
      token: map['token'] ?? '',
      verify_code: map['verify_code'] ?? '',
      verification_status: map['verification_status'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  
   UserModel.empty(): this(
    id: 0,
    nom: '_empty.nom',
    prenom: '_empty.prenom',
    email: '_empty.email',
    password: '_empty.password',           
    role: '_empty.role',
    statut_users: 0,
    photo: '_empty.photo',        
    sexe: '_empty.sexe',
    localisation: '_empty.localisation',
    telephone: '_empty.telephone',
    qualification: '_empty.qualification',      
    numCompte: '_empty.numCompte',
    cv: '_empty.cv',
    token: '_empty.token',
    verify_code: '_empty.verify_code',
    verification_status: false,

            );

  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    int? code_verify_status,
    double? balance,
  
    String? avatar,
    String? currency,
     DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      nom: firstName ?? this.nom,   
      prenom: lastName ?? this.prenom,
      email: email ?? this.email,
      password: password,
      role: role,
      statut_users: statut_users,
      photo: avatar ?? this.photo,
      sexe: sexe,

      localisation: localisation,
      telephone: phone ?? this.telephone,
      qualification: qualification,
      numCompte: numCompte,
      cv: cv,
      token: token,
      verify_code: verify_code, 
      verification_status: verification_status,
    );
  }
}
