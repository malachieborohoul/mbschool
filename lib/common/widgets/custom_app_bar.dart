import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/utils.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.title = '',
    this.action = false,
    this.actionIcon = 'filter_icon.svg',
    this.iconColor = primary,
    this.backgroundColor = background,
    this.brightness,
  }) : super(key: key);

  final String title;
  final bool action;
  final String actionIcon;
  final Color iconColor;
  final Color backgroundColor;
  final Brightness? brightness;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      primary: false,
      excludeHeaderSemantics: true,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    // splashColor: textWhite,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    child: Container(
                      // clipBehavior: Clip.antiAlias,
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        color: primary.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(100.0),
                        boxShadow: [
                          BoxShadow(
                            color: primary.withOpacity(0.5),
                            spreadRadius: 0.0,
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        assetImg + 'arrow_left_icon.svg',
                        color: textWhite,
                      ),
                    ),
                  ),
                  
                  Spacer(),
                  Text(
                    title,
                    style: TextStyle(fontSize: 17, color: secondary, fontWeight: FontWeight.w300),
                  ),
                  Spacer(),

                  (action)
                      ? GestureDetector(
                        child: Container(
                            width: 40.0,
                            child: Container(
                              child: SvgPicture.asset(
                                assetImg + actionIcon,
                                color: iconColor,
                                height: 20.0,
                              ),
                            ),
                          ),
                      )
                      : Container(
                          width: 40.0,
                          height: 40.0,
                        ),
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
