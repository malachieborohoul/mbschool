import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbschool/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:mbschool/core/domain/entities/user.dart';
import 'package:mbschool/core/error/failures.dart';
import 'package:mbschool/core/secrets/app_secrets.dart';
import 'package:mbschool/features/auth/domain/usecases/init_app.dart';
import 'package:mbschool/features/auth/domain/usecases/sign_in.dart';
import 'package:mbschool/features/auth/domain/usecases/sign_up.dart';
import 'package:mbschool/features/auth/domain/usecases/user_current_user.dart';
import 'package:mbschool/features/auth/domain/usecases/user_sign_out.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignOut _userSignOut;
  final UserCurrentUser _userCurrentUser;
  final AppUserCubit _appUserCubit;
  final SignIn _signIn;
  final SignUp _signUp;

  final InitApp _initApp;

  // final SignInWithGoogle _signInWithGoogle;
  AuthBloc({
    required UserSignOut userSignOut,
    required SignIn signIn,
    required SignUp signUp,
    required UserCurrentUser userCurrentUser,
    required AppUserCubit appUserCubit,
    required InitApp initApp,
  })  : _userSignOut = userSignOut,
        _signIn = signIn,
        _signUp = signUp,
        _userCurrentUser = userCurrentUser,
        _appUserCubit = appUserCubit,
        _initApp = initApp,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthInitApp>(_onInitApp);

    on<AuthSignOut>(_onAuthSignOut);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthCurrentUserApi>(_onCurrentUserApi);

  }

  void _onInitApp(AuthInitApp event, Emitter<AuthState> emit) async {
    final res = await _initApp();

    res.fold((l) {
    // var appLocalization = AppLocalizations.of(event.context);

      // if(l.error=="invalid_grant"){
      //   emit(AuthSignOutSuccess());

      // }else{

      // }
          _emitFailure(l, emit, event.context);


    //   print("From AuthBloc _onInitApp" + l.errorCode);
    //   if (l.errorCode == "500" &&
    //     l.error == "INTERNAL_SERVER_ERROR") {
    //   emit(AuthSignOutSuccess());
    // } else {
    //   if (l.error == AppSecrets.ERROR_NETWORK) {
    //     emit(AuthFailure(appLocalization!.no_internet_connection));
    //   } else {
    //     emit(AuthFailure(appLocalization!.msg_error_occurred));
    //   }
    // };
    }, (r) {
      if (r.id == 0) {
        emit(AuthLoggedOut());
      } else {
        _emitAuthSuccess(r, emit);
      }

      // if(r == true){
      //   emit(AuthLoggedIn());
      // }else{
      //   emit(AuthLoggedOut());

      // }
    });
  }

  void _onCurrentUserApi(
      AuthCurrentUserApi event, Emitter<AuthState> emit) async {
    final res = await _userCurrentUser();
    debugPrint("💡From Bloc - Get current user data from api ");

    res.fold((l) => _emitFailure(l, emit, event.context), (r) {
      _appUserCubit.updateUser(r);
      emit(AuthSuccess(r));
    });
  }

  void _onAuthSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    final res = await _userSignOut();

    res.fold((l) => _emitFailure(l, emit, event.context), (r) {
      // _appUserCubit.updateUser(null);

      emit(AuthSignOutSuccess());
    });
  }



  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    // var appLocalization = AppLocalizations.of(event.context);

    final res = await _signIn(
        SignInParams(email: event.email, password: event.password));

    res.fold((l) {
      if (l.code == AppSecrets.ERROR_NETWORK) {
        // emit(AuthFailure(appLocalization!.no_internet_connection));
      } else {
        if (l.statusCode == "400" &&
            l.code == AppSecrets.AUTH_INVALID_CREDENTIALS) {
          // emit(AuthFailure(appLocalization!.msg_login_failure));
        } else {
          // emit(AuthFailure(appLocalization!.msg_error_occurred));
        }
      }
    }, (r) {
      debugPrint("💡From Bloc - Emit AuthSuccess");

      // emit(AuthSignInWithOIDSuccess());

      _emitAuthSuccess(r, emit);
    });
  }

  

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    // var appLocalization = AppLocalizations.of(event.context);

    final res = await _signUp(SignUpParams(
        name: event.name,
        prenom: event.prenom,
        email: event.email,
        password: event.password  
        
        ));

    res.fold((l){
          if (l.code == AppSecrets.ERROR_NETWORK) {
        // emit(AuthFailure(appLocalization!.no_internet_connection));
      } else {
        if (l.statusCode == "400" &&
            l.code == AppSecrets.AUTH_USERNAME_OR_EMAIL_ALREADY_EXISTS) {
          // emit(AuthFailure(appLocalization!.msg_username_or_email_already_exists));
        } else {
          // emit(AuthFailure(appLocalization!.msg_error_occurred));
        }
      }
    }, (r) {
      debugPrint("💡From Bloc - Emit AuthSuccess");

      // emit(AuthSignInWithOIDSuccess());

      // emit(AuthSignUpSuccess());
      // _appUserCubit.updateUser(r);
    emit(AuthSignUpSuccess());
    });
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) async {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

  void _emitFailure(
      Failure l, Emitter<AuthState> emit, BuildContext context) async {
    // var appLocalization = AppLocalizations.of(context);

    print("_emitFailure" + l.message);
    //  if(l.error=="invalid_grant"){
    //       emit(DepositsLoggedOut());

    //     }else{

    //      emit(DepositsFailure(l.message));
    //     }

    if (l.statusCode == "400" &&
        l.code == AppSecrets.AUTH_INVALID_CREDENTIALS) {
      emit(AuthSignOutSuccess());
    } else {
      if (l.code == AppSecrets.ERROR_NETWORK) {
        // emit(AuthFailure(appLocalization!.no_internet_connection));
      } else {
        // emit(AuthFailure(appLocalization!.msg_error_occurred));
      }
    }
  }


  //  void _emitAuthPendingVerification(User user, Emitter<AuthState> emit) async {
  //         debugPrint("💡From Bloc -  _emitAuthPendingVerification  Code d'erreur : ${user}");

  //   _appUserCubit.updateUser(user);
  //   emit(AuthPendingVerification(user));
  // }


}
