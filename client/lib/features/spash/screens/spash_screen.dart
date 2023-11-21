import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/features/auth/screens/auth_screen.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/bottom_bar.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? const BottomBar()
          : const AuthScreen();
    });
  }

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "MBSCHOOL",
              style: TextStyle(fontSize: 50, color: primary),
            ),
            CircularProgressIndicator(
              color: primary,
            )
          ],
        ),
      ),
    );
  }
}
