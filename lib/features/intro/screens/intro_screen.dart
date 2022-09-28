import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/auth/screens/auth_screen.dart';
import 'package:mbschool/providers/number_entry_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);
  static const routeName = "intro-screen";

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
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
    return Scaffold(
      backgroundColor: textWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: textWhite,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: Text(
              "Sauter",
              style: TextStyle(
                  color: primary, fontSize: 15, fontWeight: FontWeight.w600),
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
                title: "Rendre l'Apprentissage Accessible Partout",
                content: "Gagnez du temps en rassemblant vos outils de classe",
              ),
              makePage(
                  image: "intro_two.png",
                  title: "Une plateforme d'apprentissage en ligne",
                  content:
                      "Gagnez du temps en rassemblant vos outils de classe",
                  button: true,
                  prefs: prefs),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 40),
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
      {image, title, content, button = false, SharedPreferences? prefs}) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(
              assetImg + image,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            title,
            style: TextStyle(
                color: primary, fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            content,
            style: TextStyle(
                color: secondary, fontSize: 15, fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          button == false
              ? Container()
              : GestureDetector(
                  onTap: () {
                    // Provider.of<NumberEntryProvider>(context, listen: false)
                    //     .setCount(1);

                    // introApp.num = 1;
                    prefs!.setString('x-auth-token', '');

                    Navigator.pushReplacementNamed(
                        context, AuthScreen.routeName);
                  },
                  child: CustomButtonBox(title: "Commençons"))
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 8,
        width: isActive ? 30 : 8,
        margin: EdgeInsets.only(right: 5),
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
