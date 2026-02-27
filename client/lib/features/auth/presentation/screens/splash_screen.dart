import 'dart:async';

import 'package:flutter/material.dart';

import 'package:mbschool/core/constants/colors.dart';
import 'package:mbschool/core/utils/pref_utils.dart';
import 'package:mbschool/features/auth/presentation/screens/auth_screen.dart';
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
    // authService.getUserData(context);

    // _animationController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     _animationController.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     _animationController.forward();
    //   }
    // });
  

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
    // if (ModalRoute.of(context)!.settings.arguments != null) {
    //   HomeController homeController = Get.find<HomeController>();
    //   homeController.onChange(0.obs);
    //   Get.toNamed(AppRoutes.homeCardSliderScreen);
    //   return;
    // }



    Timer(const Duration(milliseconds: 2000), () async {
      // bool isLogin = await PrefUtils.getLogin();
      bool isIntro = await PrefUtils.getIntro();

      await Future.delayed(Duration.zero);

      Timer(const Duration(seconds: 3), () {
        if (isIntro) {
          debugPrint("💡Navigating to Onboarding Screen");
          Navigator.push(context, OnboardingScreen.route());

        }  else {
           debugPrint("💡Navigating to LoadingScreen ");

                    Navigator.push(context, AuthScreen.route());

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
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //   String? token = prefs.getString('x-auth-token');

    // void getUserData() async {
    //   authService.getUserData(context);
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   String? token = prefs.getString('x-auth-token');

    //   setState(() {
    //     final userProvider = Provider.of<UserProvider>(context, listen: false);

    //     print("token ${token} ");
    //     print("verify code: ${userProvider.user.verify_code} ");

    //     // print(numberEntry.count);
    //     // print(introApp.num);

    //     // print("token $userProvider");
    //     Timer(Duration(seconds: 4), () {
    //       // if (Provider.of<UserProvider>(context).user.token.isNotEmpty) {
    //       // } else {
    //       //   Navigator.pushReplacementNamed(context, AuthScreen.routeName);
    //       // }

    //       if (token == null) {
    //         Navigator.pushReplacementNamed(context, IntroScreen.routeName);
    //       } else {
    //         if (userProvider.user.token.isNotEmpty &&
    //             userProvider.user.verify_code.isNotEmpty) {
    //           Navigator.pushReplacementNamed(
    //               context, VerificationScreen.routeName);
    //         } else if (userProvider.user.token.isEmpty &&
    //             userProvider.user.verify_code.isEmpty) {
    //           Navigator.pushReplacementNamed(context, AuthScreen.routeName);
    //         } else if (userProvider.user.token.isNotEmpty &&
    //             userProvider.user.verify_code.isEmpty) {
    //           Navigator.pushReplacementNamed(context, BottomBar.routeName);
    //         } else {}
    //       }
    //     });
    //   });
    // }

    // getUserData();

    return Scaffold(
      body: Center(
          child: 
          Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScaleTransition(
                        scale: _animation,
                        child: const Text(
                          "mbschool",
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
                  )
              ),
    );
  }
}
