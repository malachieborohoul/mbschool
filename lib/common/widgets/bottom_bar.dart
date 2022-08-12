import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/features/account/screens/account_screen.dart';
import 'package:mbschool/features/course/screens/course_screen.dart';
import 'package:mbschool/features/explore/screens/explore_screen.dart';
import 'package:mbschool/features/home/screens/home_screen.dart';

class BottomBar extends StatefulWidget {
  static const routeName = '/bottom-bar';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int pageIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  Widget getFooter() {
    List items = [
      "assets/images/home_icon.svg",
      "assets/images/play_icon.svg",
      "assets/images/rocket_icon.svg",
      "assets/images/user_icon.svg",
    ];
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 100,
      decoration: BoxDecoration(color: textWhite, boxShadow: [
        BoxShadow(
            color: textBlack.withOpacity(0.12),
            blurRadius: 30,
            offset: Offset(0, -10))
      ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  pageIndex = index;
                });
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    items[index],
                    height: 17.5,
                    color: pageIndex == index ? primary : secondary,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  pageIndex == index
                      ? AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          child: Container(
                            height: 5,
                            width: 20,
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        )
                      : Container()
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: const [
        HomeScreen(),
        CourseScreen(),
        ExploreScreen(),
        AccountScreen()
      ],
    );
  }
}
