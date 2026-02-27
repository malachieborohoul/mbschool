import 'package:equatable/equatable.dart';
import 'package:mbschool/core/domain/entities/user.dart';
import 'package:mbschool/core/usecase/usecase.dart';
import 'package:mbschool/core/utils/typedef.dart';
import 'package:mbschool/features/auth/domain/repositories/auth_repository.dart';


class SignIn implements Usecase<User, SignInParams> {
  final AuthRepository repository;

  SignIn(this.repository);
  @override
  ResultFuture<User> call(SignInParams params) async {
    return await repository.signIn(email: params.email, password: params.password);
  }
}

class SignInParams extends Equatable {
  final String email;

  final String password;

  const SignInParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
