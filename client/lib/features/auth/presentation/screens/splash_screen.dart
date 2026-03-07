import 'dart:async';

import 'package:flutter/material.dart';

import 'package:mbschool/core/constants/colors.dart';
import 'package:mbschool/core/utils/pref_utils.dart';
import 'package:mbschool/features/auth/presentation/screens/loading_screen.dart';
import 'package:mbschool/features/autht/services/auth_service.dart';
import 'package:mbschool/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:mbschool/models/user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AuthService authService = AuthService();

  late final _animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 1));

  late final Animation<double> _animation = Tween<double>(begin: 1.0, end: 1.2)
      .animate(CurvedAnimation(
          parent: _animationController, curve: Curves.decelerate));

  List<User> userList = [];
  late Future<User> userFuture;
  late String? token;

  @override
  void initState() {
    init();

    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (_animationController.status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });

    super.initState();
  }

  void init() async {
    await Future.delayed(Duration.zero);


    Timer(const Duration(milliseconds: 2000), () async {
      // bool isLogin = await PrefUtils.getLogin();
      bool isIntro = await PrefUtils.getIntro();

      await Future.delayed(Duration.zero);

      Timer(const Duration(seconds: 3), () {
        if (isIntro) {
          debugPrint("💡Navigating to Onboarding Screen");
          Navigator.pushReplacement(context, OnboardingScreen.route());
        } else {
          debugPrint("💡Navigating to LoadingScreen ");

          Navigator.pushReplacement(context, LoadingScreen.route());
        }
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:   AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: SizedBox()
          ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _animation,
            child: const Text(
              "mbschool",
              style: TextStyle(
                  color: primary, fontSize: 50, fontWeight: FontWeight.w600),
            ),
          ),
  
        ],
      )),
    );
  }
}
