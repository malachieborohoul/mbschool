import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbschool/core/common/widgets/loader.dart';
import 'package:mbschool/core/l10n/app_localizations.dart';
import 'package:mbschool/core/presentation/widgets/custom_error404.dart';
import 'package:mbschool/core/utils/show_snackbar.dart';
import 'package:mbschool/core/utils/size_utils.dart';
import 'package:mbschool/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mbschool/features/auth/presentation/screens/auth_screen.dart';
import 'package:mbschool/features/auth/presentation/screens/home_screen_test.dart';


class LoadingScreen extends StatefulWidget {
  static PageRouteBuilder<dynamic> route() => PageRouteBuilder(pageBuilder: (_, animation, __) {
        return FadeTransition(
          opacity: animation,
          child: const LoadingScreen(),
        );
      });
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late bool isPendingVerification;
  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 2));

    
    debugPrint(
          "💡From LoadingScreen - Déclencher l'événement pour vérifier si l'utilisateur est connecté ou numero non verifié");

        context.read<AuthBloc>().add(AuthInitApp(context: context));

  }



  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context);

    return Scaffold(
        body:  
        
        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoggedIn || state is AuthSuccess) {
                    debugPrint(" ✅ From LoadingScreen - ");

              // Navigator.pushReplacement(
              //       context, CodeVerificationTestScreen.route(""));
              // Navigator.pushReplacement(context, CreatePinScreen.route());
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   BottomBar.route(),
              //   (Route<dynamic> route) => false,
              // );

               Navigator.pushAndRemoveUntil(
                context,
                HomeScreenTest.route(),
                (Route<dynamic> route) => false,
              );
            
            } else if (state is AuthInitial ||
                state is AuthLoggedOut
                ) {
              debugPrint("💡 From LoadingScreen - Rediriger vers LoginScreen");
             Navigator.pushReplacement(context, AuthScreen.route());
            }
            else if (
                state is AuthSignOutSuccess
               
                ) {
                    showSnackBar(context, appLocalization!.msg_session_expired,
                                  );
              debugPrint("💡 From LoadingScreen - Rediriger vers LoginScreen");
              Navigator.pushAndRemoveUntil(
                          context,
                          AuthScreen.route(),
                          (Route<dynamic> route) => false, 
                        );
            }
            else if(state is AuthFailure){
              showSnackBar(context, state.message,
                                  const Color.fromARGB(255, 194, 72, 64));
            }
          },
          builder: (context, state) {
            if (kDebugMode) {
              print(state);
            }
            if(state is AuthLoading){
             return   Center(
            child: Loader(),
          );
            }else
            if(state is AuthFailure){
               return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.h),
                  child: CustomError404(onPressed: () {
                     context.read<AuthBloc>().add(AuthInitApp(context: context));
                  }),
                );
            }else{
              return SizedBox.shrink();
            }
          },
        ));
  }
}