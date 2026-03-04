
import 'package:flutter/material.dart';

import 'package:mbschool/core/common/widgets/custom_button_box.dart';
import 'package:mbschool/core/constants/colors.dart';
import 'package:mbschool/core/constants/utils.dart';
import 'package:mbschool/core/l10n/app_localizations.dart';
import 'package:mbschool/core/utils/pref_utils.dart';
import 'package:mbschool/features/auth/presentation/screens/auth_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
    static PageRouteBuilder<dynamic> route() => PageRouteBuilder(pageBuilder: (_, animation, __) {
        return FadeTransition(
          opacity: animation,
          child: const OnboardingScreen(),
        );
      });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int currentIndex = 0;
  SharedPreferences? prefs;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    pref();
    super.initState();
  }

  void pref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: textWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: textWhite,
            leading: SizedBox(),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: GestureDetector(
              onTap: () {
                PrefUtils.setIntro(false);
                // prefs!.setString('x-auth-token', '');

                Navigator.pushReplacement(context, AuthScreen.route());
              },
              child: Text(
                appLocalization!.skip,
                style: const TextStyle(
                    color: primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: [
              makePage(
                image: "intro_one.png",
                title: appLocalization.intro_title_1,
                 content: appLocalization.intro_desc_1,
                 appLocalization: appLocalization,  
              ),
              makePage(
                  image: "intro_two.png",
                  title: appLocalization.intro_title_2,
                  content: appLocalization.intro_desc_2,
                  button: true,
                  appLocalization: appLocalization,
                  prefs: prefs),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
          )
        ],
      ),
    );
  }

  Widget makePage(
      {required String image, required String title, required String content, button = false, SharedPreferences? prefs, AppLocalizations? appLocalization}) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(
              assetImg + image,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            title,
            style: const TextStyle(
                color: primary, fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            content,
            style: const TextStyle(
                color: secondary, fontSize: 15, fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          button == false
              ? Container()
              : GestureDetector(
                  onTap: () {
                    // Provider.of<NumberEntryProvider>(context, listen: false)
                    //     .setCount(1);

                    // introApp.num = 1;
                PrefUtils.setIntro(false);

                    // prefs!.setString('x-auth-token', '');

                    Navigator.pushReplacement(context, AuthScreen.route());
                  },
                  child:  CustomButtonBox(title: appLocalization!.lbl_get_started)),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 8,
        width: isActive ? 30 : 8,
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            color: primary, borderRadius: BorderRadius.circular(5)));
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 2; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
