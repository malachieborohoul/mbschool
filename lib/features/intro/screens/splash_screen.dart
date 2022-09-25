import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/bottom_bar.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/features/auth/screens/auth_screen.dart';
import 'package:mbschool/features/auth/services/auth_service.dart';
import 'package:mbschool/features/panel/panel.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

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

  @override
  void initState() {
    authService.getUserData(context);

    // _animationController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     _animationController.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     _animationController.forward();
    //   }
    // });

    Timer(Duration(seconds: 3), () {
      if (Provider.of<UserProvider>(context).user.token.isNotEmpty) {
      } else {
        Navigator.pushReplacementNamed(context, AuthScreen.routeName);
      }
    });
    
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _animation,
                child: const Text(
                  "MbSchool",
                  style: TextStyle(
                      color: primary,
                      fontSize: 50,
                      fontWeight: FontWeight.w600),
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.only(top: 100.0),
              //   child: Loader(),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
