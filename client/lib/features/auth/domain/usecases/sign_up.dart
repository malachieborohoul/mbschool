import 'package:equatable/equatable.dart';
import 'package:mbschool/core/domain/entities/user.dart';
import 'package:mbschool/core/usecase/usecase.dart';
import 'package:mbschool/core/utils/typedef.dart';
import 'package:mbschool/features/auth/domain/repositories/auth_repository.dart';


class SignUp implements Usecase<User, SignUpParams> {
  final AuthRepository repository;

  SignUp(this.repository);
  @override
  ResultFuture<User> call(SignUpParams params) async {
    return await repository.signUp(name: params.name, prenom: params.prenom, email: params.email, password: params.password);
  }
}

class SignUpParams extends Equatable {
   final String name;
  final String prenom;
  final String email;
  final String password;

  const SignUpParams( {
    required this.name,
    required this.prenom,
    required this.email,
    required this.password,
   
  });

  @override
  List<Object?> get props => [name, prenom, email, password];
}
