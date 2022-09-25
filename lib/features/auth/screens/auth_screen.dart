import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbschool/common/animations/opacity_tween.dart';
import 'package:mbschool/common/animations/slide_down_tween.dart';
import 'package:mbschool/common/widgets/clipper.dart';
import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/common/widgets/custom_button_social.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';
import 'package:mbschool/common/widgets/custom_textfield.dart';

import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/auth/services/auth_service.dart';
import 'package:mbschool/features/intro/screens/splash_screen.dart';

enum Auth {
  sign_up,
  login,
}

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  // bool isCharging = false;

  TextEditingController cPasswordController = TextEditingController();
  Auth _auth = Auth.login;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signUpUser() {
    authService.signUpUser(
      context: context,
      name: nameController.text,
      prenom: prenomController.text,
      email: emailController.text,
      password: passwordController.text,
      onSuccess: () {
        setState(() {
          isCharging = false;
        });
      },
    );
  }

  void signInUser() {
    authService.signInUser(
        context: context,
        email: emailController.text,
        password: passwordController.text,
        onSuccess: () {
          setState(() {
            isCharging = false;
          });
        },
        onFailed: () {
          setState(() {
            isCharging = false;
          });
        });
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      SplashScreen();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    prenomController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: background,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: _auth == Auth.sign_up
              ?
              //SIGNUPSCREEN
              SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(appPadding),
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: spacer,
                          ),
                          OpacityTween(
                            begin: 0.2,
                            child: const CustomHeading(
                                title: "Inscrivez vous",
                                subTitle: "Bienvenue",
                                color: secondary),
                          ),
                          const SizedBox(
                            height: spacer,
                          ),
                          OpacityTween(
                            begin: 0.2,
                            child: CustomTextField(
                              prefixIcon: "user_icon.svg",
                              labelText: "Nom ",
                              controller: nameController,
                              iconColor: primary,
                            ),
                          ),
                          const SizedBox(
                            height: spacer - 40,
                          ),
                          OpacityTween(
                            begin: 0.2,
                            child: CustomTextField(
                              prefixIcon: "user_icon.svg",
                              labelText: "Prenom ",
                              controller: prenomController,
                              iconColor: primary,
                            ),
                          ),
                          const SizedBox(
                            height: spacer - 40,
                          ),
                          OpacityTween(
                            begin: 0.2,
                            child: CustomTextField(
                              prefixIcon: "email_icon.svg",
                              labelText: "Adresse email",
                              controller: emailController,
                              iconColor: primary,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(
                            height: spacer - 40,
                          ),
                          OpacityTween(
                            begin: 0.2,
                            child: CustomTextField(
                              prefixIcon: "key_icon.svg",
                              labelText: "Mot de passe",
                              controller: passwordController,
                              iconColor: primary,
                              isPassword: true,
                            ),
                          ),
                          const SizedBox(
                            height: spacer - 40,
                          ),
                          const SizedBox(
                            height: spacer,
                          ),
                          GestureDetector(
                              onTap: () {
                                if (_signUpFormKey.currentState!.validate()) {
                                  setState(() {
                                    isCharging = true;
                                  });
                                  signUpUser();
                                }
                              },
                              child: OpacityTween(
                                begin: 0.2,
                                child: Column(
                                  children: [
                                    const CustomButtonBox(title: "S'inscrire"),
                                    isCharging == true
                                        ? CircularProgressIndicator(
                                            color: primary,
                                          )
                                        : Text("")
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: spacer,
                          ),
                          Row(
                            children: [
                              Text(
                                "Vous avez déjà un compte ?",
                                style: TextStyle(
                                    color: secondary.withOpacity(0.5)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _auth = Auth.login;
                                  setState(() {});
                                },
                                child: const Text(
                                  "Connectez vous",
                                  style: TextStyle(color: primary),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: spacer - 30,
                          ),
                          const Center(
                              child: Text(
                            "Avec",
                            style: TextStyle(color: textBlack),
                          )),
                          const SizedBox(
                            height: spacer - 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              CustomButtonSocial(svgIcon: "google_logo.svg"),
                              CustomButtonSocial(svgIcon: "facebook_logo.svg"),
                              CustomButtonSocial(svgIcon: "apple_logo.svg"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              :
              //LOGINSCREEN
              SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(appPadding),
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SlideDownTween(
                            offset: 40,
                            delay: 1.0,
                            child: OpacityTween(
                              begin: 0,
                              child: Center(
                                  child: SvgPicture.asset(
                                assetImg + "login_image.svg",
                                width: 250,
                                height: 250,
                              )),
                            ),
                          ),
                          const SizedBox(
                            height: spacer - 40,
                          ),
                          SlideDownTween(
                            delay: 1.4,
                            offset: 40,
                            child: OpacityTween(
                              begin: 0.2,
                              child: const CustomHeading(
                                  title: "Connectez-vous",
                                  subTitle: "Bienvenue",
                                  color: secondary),
                            ),
                          ),
                          const SizedBox(
                            height: spacer - 40,
                          ),
                          SlideDownTween(
                            offset: 50,
                            delay: 1.6,
                            child: OpacityTween(
                              begin: 0.4,
                              child: CustomTextField(
                                prefixIcon: "email_icon.svg",
                                labelText: "Adresse email",
                                controller: emailController,
                                iconColor: primary,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: spacer - 40,
                          ),
                          SlideDownTween(
                            offset: 50,
                            delay: 1.6,
                            child: OpacityTween(
                              begin: 0.4,
                              child: CustomTextField(
                                prefixIcon: "key_icon.svg",
                                labelText: "Mot de passe",
                                controller: passwordController,
                                iconColor: primary,
                                isPassword: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: spacer,
                          ),
                          GestureDetector(
                              onTap: () {
                                if (_signInFormKey.currentState!.validate()) {
                                  setState(() {
                                    isCharging = true;
                                  });
                                  signInUser();
                                }
                              },
                              child: SlideDownTween(
                                offset: 40,
                                delay: 2.0,
                                child: OpacityTween(
                                  begin: 0.5,
                                  child: Column(
                                    children: [
                                      const CustomButtonBox(
                                          title: "Se connecter"),
                                      isCharging == true
                                          ? CircularProgressIndicator(
                                              color: primary,
                                            )
                                          : Text("")
                                    ],
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: spacer - 30,
                          ),
                          SlideDownTween(
                            offset: 40,
                            delay: 2.0,
                            child: OpacityTween(
                              begin: 0.6,
                              child: Row(
                                children: [
                                  Text(
                                    "Vous n'avez pas de compte ?",
                                    style: TextStyle(
                                        color: secondary.withOpacity(0.5)),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _auth = Auth.sign_up;
                                      setState(() {});
                                    },
                                    child: const Text(
                                      "Inscrivez vous",
                                      style: TextStyle(color: primary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: spacer - 30,
                          ),
                          const Center(
                              child: Text(
                            "Avec",
                            style: TextStyle(color: textBlack),
                          )),
                          const SizedBox(
                            height: spacer - 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              CustomButtonSocial(svgIcon: "google_logo.svg"),
                              CustomButtonSocial(svgIcon: "facebook_logo.svg"),
                              CustomButtonSocial(svgIcon: "apple_logo.svg"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
    );
  }
}
