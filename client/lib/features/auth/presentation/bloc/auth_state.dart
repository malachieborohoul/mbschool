part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}
final class AuthSplash extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess(this.user);
}

final class AuthPendingVerification extends AuthState {
  final User user;

  const AuthPendingVerification(this.user);
}


final class AuthFailure extends AuthState {
  final String message;
  final String errorCode;

  const AuthFailure([this.message = 'An unexpected error occurred', this.errorCode = ""]);
}

final class AuthSignOutSuccess extends AuthState {}
final class AuthForgotPasswordSuccess extends AuthState {}

final class AuthSignUpWithPhoneSuccess extends AuthState {}
final class AuthSignUpSuccess extends AuthState {

  const AuthSignUpSuccess();
}



final class AuthGetUsersSuccess extends AuthState {
  final List<User> users;

  const AuthGetUsersSuccess(this.users);
}


final class AuthSignInWithOIDSuccess extends AuthState {}
final class AuthLoggedIn extends AuthState {}
final class AuthLoggedOut extends AuthState {}
