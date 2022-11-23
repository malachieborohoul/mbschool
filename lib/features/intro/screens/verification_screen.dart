import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/animations/slide_down_tween.dart';
import 'package:mbschool/common/animations/slide_up_tween.dart';
import 'package:mbschool/common/widgets/bottom_bar.dart';
import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/common/widgets/textbox_verification.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/auth/services/auth_service.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);
  static const routeName = 'verification-screen';

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

bool _selected = false;
bool _hide = false;
double _width = double.infinity;
double _height = 45;

class _VerificationScreenState extends State<VerificationScreen>
    with SingleTickerProviderStateMixin {
  final _codeVerificationFormKey = GlobalKey<FormState>();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  TextEditingController _controller6 = TextEditingController();

  AuthService _authService = AuthService();

  late final _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 750));

  late final _scaleAnimation = Tween<double>(begin: 1.0, end: 30).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.easeInOutExpo))
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, BottomBar.routeName);
      }
    });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    void codeVerification(var code) {
      if (code == userProvider.user.verify_code) {
        _authService.codeVerification(
            context: context,
            codeVerification: code,
            onSuccess: () {
              setState(() {
                _selected = !_selected;
              });

              _animationController.forward();
            });
      } else {
        // setState(() {
        //   _selected = !_selected;
        // });
        showSnackBar(context, "Code incorrecte");
      }
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      // onTap: () =>
      //     Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return VerificationScreen();
      // })),
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: const EdgeInsets.all(appPadding),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SlideDownTween(
                    delay: 1,
                    offset: 60,
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Image.asset(assetImg + "verification.png",
                          width: 250),
                    ),
                  ),
                  SlideDownTween(
                    delay: 1.2,
                    offset: 50,
                    child: const Text(
                      "Vérification",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SlideDownTween(
                    delay: 1.4,
                    offset: 40,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                          style: TextStyle(
                              fontSize: 15,
                              color: grey,
                              fontWeight: FontWeight.w300),
                          children: [
                            TextSpan(
                              text: "Entrez le code vérification qui vous a été envoyé ",
                            ),
                            // TextSpan(
                            //     text: "bsmlancer@gmail.com",
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.bold,
                            //         color: textBlack)),
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  SlideDownTween(
                    delay: 1.6,
                    offset: 30,
                    child: Form(
                      key: _codeVerificationFormKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextBoxVerification(
                            controller: _controller1,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          TextBoxVerification(
                            controller: _controller2,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          TextBoxVerification(
                            controller: _controller3,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          TextBoxVerification(
                            controller: _controller4,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          TextBoxVerification(
                            controller: _controller5,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          TextBoxVerification(
                            controller: _controller6,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SlideDownTween(
                    delay: 1.8,
                    offset: 20,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                          style: TextStyle(
                              fontSize: 13,
                              color: grey,
                              fontWeight: FontWeight.w300),
                          children: [
                            TextSpan(
                              text: "Vous n'avez pas reçu le code ? ",
                            ),
                            TextSpan(
                                text: "Renvoyer le code",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primary)),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_codeVerificationFormKey.currentState!.validate()) {
                        setState(() {
                          // _selected = !_selected;
                          var code = _controller1.text +
                              _controller2.text +
                              _controller3.text +
                              _controller4.text +
                              _controller5.text +
                              _controller6.text;
                          print(code);
                          // _selected = !_selected;
                          codeVerification(code);
                        });
                      }
                    },
                    child: SlideDownTween(
                      delay: 2,
                      offset: 10,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          // duration: const Duration(milliseconds: 500),
                          // curve: Curves.easeInCirc,
                          width: _selected == false ? 350 : 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: primary.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: _selected == false
                                ? Text(
                                    "Vérifier",
                                    style: TextStyle(
                                        color: textWhite,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Container(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
