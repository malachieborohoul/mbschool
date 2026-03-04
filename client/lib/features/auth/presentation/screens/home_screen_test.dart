import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbschool/core/common/animations/slide_transition_page.dart';
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // When the Bloc emits Initial or Failure (logged out), go back to AuthScreen
        if (state is AuthInitial || state is AuthFailure) {
          Navigator.pushAndRemoveUntil(
            context,
            AuthScreen.route(),
            (route) => false,
          );
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
              const Text(
                "Vous êtes connecté !",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: () {
                  // Trigger the Sign Out event
                  context.read<AuthBloc>().add(AuthSignOut(context: context));
                },
                child: const Text("Se déconnecter"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}