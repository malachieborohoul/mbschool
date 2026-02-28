part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthInitApp extends AuthEvent {
  final BuildContext context;

  const AuthInitApp({required this.context});


}

final class AuthSignUp extends AuthEvent {
  final BuildContext context;

  final String name;
  final String prenom;
  final String email;
  final String password;

  const AuthSignUp(  {required this.context,required this.name,required this.prenom,required this.email, required this.password,});
}



final class AuthSignIn extends AuthEvent {
  final BuildContext context;

  final String email;
  final String password;

  const AuthSignIn({ required this.context, required this.email, required this.password});
}






final class AuthSignOut extends AuthEvent {
  final BuildContext context;

  const AuthSignOut({required this.context});

 
}

class AuthSignUpWithGoogle extends AuthEvent {}
class AuthSignInWithOID extends AuthEvent {
  final BuildContext context;

  const AuthSignInWithOID({required this.context});
}
class AuthSignInWithGoogle extends AuthEvent {}

class AuthSignUpWithApple extends AuthEvent {}



final class AuthIsUserLoggedIn extends AuthEvent {
  const AuthIsUserLoggedIn();

}

final class AuthCurrentUserApi extends AuthEvent {
  final BuildContext context;

  const AuthCurrentUserApi({required this.context});

}



final class AuthForgotPassword extends AuthEvent {
  final String email;

  const AuthForgotPassword({required this.email, });
}


final class AuthForgotPasswordWithToken extends AuthEvent {
  final String email;
  final String password;
  final String token;

  const AuthForgotPasswordWithToken({required this.email, required this.password, required this.token,});
}

final class AuthSignUpWithPhone extends AuthEvent {
  final String phone;
  final String password;
  final String firstName;
  final String lastName;

  const AuthSignUpWithPhone(this.firstName, this.lastName, {required this.phone, required this.password});
}


final class AuthVerifyPhoneOtp extends AuthEvent {
  final String phone;
  final String otpCode;
  

  const AuthVerifyPhoneOtp( {required this.phone, required this.otpCode});
}

final class AuthResendPhoneOTP extends AuthEvent {
  final String phone;
  

  const AuthResendPhoneOTP( {required this.phone, });
}

final class AuthGetUsers extends AuthEvent {
  final BuildContext context;

  const AuthGetUsers({required this.context});

}
