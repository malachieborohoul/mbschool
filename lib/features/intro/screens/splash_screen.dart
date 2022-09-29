import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/bottom_bar.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/features/auth/screens/auth_screen.dart';
import 'package:mbschool/features/auth/services/auth_service.dart';
import 'package:mbschool/features/intro/screens/intro_screen.dart';
import 'package:mbschool/features/intro/screens/verification_screen.dart';
import 'package:mbschool/features/panel/panel.dart';
import 'package:mbschool/models/user.dart';
import 'package:mbschool/providers/number_entry_provider.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    getUserData();

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

  void getUserData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userFuture = authService.getUserData(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('x-auth-token');

    setState(() {
      print("token ${token} ");
      print("verify code: ${userProvider.user.verify_code} ");
      // print("token pro: ${userProvider.user.token} ");

      // print(numberEntry.count);
      // print(introApp.num);

      // print("token $userProvider");
      // if (Provider.of<UserProvider>(context).user.token.isNotEmpty) {
      // } else {
      //   Navigator.pushReplacementNamed(context, AuthScreen.routeName);
      // }

      // if (token == null) {
      //   Navigator.pushReplacementNamed(context, IntroScreen.routeName);
      // } else {
      //   if (userProvider.user.token.isNotEmpty &&
      //       userProvider.user.verify_code.isNotEmpty) {
      //     Navigator.pushReplacementNamed(
      //         context, VerificationScreen.routeName);
      //   } else if (userProvider.user.token.isEmpty &&
      //       userProvider.user.verify_code.isEmpty) {
      //     Navigator.pushReplacementNamed(context, AuthScreen.routeName);
      //   } else if (userProvider.user.token.isNotEmpty &&
      //       userProvider.user.verify_code.isEmpty) {
      //     Navigator.pushReplacementNamed(context, BottomBar.routeName);
      //   } else {}
      // }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
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

    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Center(
            child: FutureBuilder(
                future: userFuture,
                builder: (context, snapshot) {
                  var text;
                  if (snapshot.hasData) {
                    if (token == null) {
                      Future.delayed(Duration(milliseconds: 0), () {
                        Navigator.pushReplacementNamed(
                            context, IntroScreen.routeName);
                      });
                    } else {
                      if (userProvider.user.token.isNotEmpty &&
                          userProvider.user.verify_code.isNotEmpty) {
                        Future.delayed(Duration(milliseconds: 0), () {
                          Navigator.pushReplacementNamed(
                              context, VerificationScreen.routeName);
                        });
                      } else if (userProvider.user.token.isEmpty &&
                          userProvider.user.verify_code.isEmpty) {
                        Future.delayed(Duration(milliseconds: 0), () {
                          Navigator.pushReplacementNamed(
                              context, AuthScreen.routeName);
                        });
                      } else if (userProvider.user.token.isNotEmpty &&
                          userProvider.user.verify_code.isEmpty) {
                        Future.delayed(Duration(milliseconds: 0), () {
                          Navigator.pushReplacementNamed(
                              context, BottomBar.routeName);
                        });
                      }
                    }
                    return Container();
                  } else {
                    return Column(
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
                    );
                  }
                })),
      ),
    );
  }
}
