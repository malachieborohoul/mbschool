import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbschool/core/common/animations/slide_transition_page.dart';
import 'package:mbschool/core/constants/utils.dart';
import 'package:mbschool/core/l10n/app_localizations.dart';
import 'package:mbschool/core/utils/loader_dialog.dart';
import 'package:mbschool/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mbschool/features/auth/presentation/screens/auth_screen.dart';
import 'package:mbschool/core/constants/colors.dart';

class HomeScreenTest extends StatelessWidget {
  static PageRouteBuilder<dynamic> route() =>
      PageRouteBuilder(pageBuilder: (_, animation, __) {
        return SlideTransitionPage(
          page: const HomeScreenTest(),
          animation: animation,
        );
      });

  const HomeScreenTest({super.key});

  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // When the Bloc emits Initial or Failure (logged out), go back to AuthScreen
      

            if (state is AuthLoading) {
      showLoaderDialog(context);
    } else {
      closeLoaderDialog(context);
        if (state is AuthInitial || state is AuthFailure) {
          Navigator.pushAndRemoveUntil(
            context,
            AuthScreen.route(),
            (route) => false,
          );
        } else if (state is AuthSignOutSuccess) {
          showSnackBar(
            context,
            appLocalization.msg_session_expired,
          );
          debugPrint("💡 From LoadingScreen - Rediriger vers LoginScreen");
          Navigator.pushAndRemoveUntil(
            context,
            AuthScreen.route(),
            (Route<dynamic> route) => false,
          );
        } else if (state is AuthFailure) {
          showSnackBar(context, state.message);
        }

    }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("MBSchool Test Home"),
          backgroundColor: primary,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                appLocalization!.lbl_welcome_to_mbschool,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: () {
                  // Trigger the Sign Out event
                  context.read<AuthBloc>().add(AuthSignOut(context: context));
                },
                child: Text(appLocalization.lbl_logout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
