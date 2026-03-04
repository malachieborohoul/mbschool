import 'dart:convert';

import 'package:mbschool/features/auth/domain/entities/auth_token.dart';

class AuthTokenModel extends AuthToken {
  AuthTokenModel({
    required super.accessToken,
    required super.refreshToken,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory AuthTokenModel.fromMap(Map<String, dynamic> map) {
    return AuthTokenModel(
      accessToken: map['accessToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
    );
  }

  AuthTokenModel.empty()
      : this(
          accessToken: '_empty.accessToken',
          refreshToken: '_empty.refreshToken',
        );

  String toJson() => json.encode(toMap());

  factory AuthTokenModel.fromJson(String source) =>
      AuthTokenModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    }.toString();
  }
}
