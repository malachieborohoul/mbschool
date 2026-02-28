import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mbschool/core/constants/colors.dart';
import 'package:mbschool/core/constants/padding.dart';
import 'package:mbschool/core/constants/utils.dart';
import 'package:mbschool/features/search/screens/search_screen.dart';

class CustomSearchField extends StatefulWidget {
  const CustomSearchField({
    super.key,
    required this.hintField,
    this.backgroundColor,
    this.isFilter = false,
    this.onTap = false,
    this.controller,
  });

  final String hintField;
  final Color? backgroundColor;
  final bool isFilter;
  final bool onTap;
  final TextEditingController? controller;

  @override
  CustomSearchFieldState createState() => CustomSearchFieldState();
}

class CustomSearchFieldState extends State<CustomSearchField> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return
     Container(
      width: size.width,
      height: spacer,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              '${assetImg}search_icon.svg',
              colorFilter: ColorFilter.mode(secondary.withValues(alpha:0.5), BlendMode.srcIn),
              height: 15.0,
            ),
          ),
          Flexible(
            child: Container(
              width: size.width,
              height: 38,
              alignment: Alignment.topCenter,
              child: widget.onTap == true
                  ? TextFormField(
                      onTap: () {
                        Navigator.pushNamed(context, SearchScreen.routeName);
                      },
                      style: const TextStyle(fontSize: 15),
                      cursorColor: textBlack,
                      decoration: InputDecoration(
                        hintText: widget.hintField,
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: secondary.withValues(alpha:0.5),
                        ),
                        border: InputBorder.none,
                      ),
                    )
                  : TextField(
                      controller: widget.controller,
                      onChanged: (text) {
                          // print(text);
                      },
                      style: const TextStyle(fontSize: 15),
                      cursorColor: textBlack,
                      decoration: InputDecoration(
                        hintText: widget.hintField,
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: secondary.withValues(alpha:0.5),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 10.0),
          widget.isFilter == false
              ? Container(
                  height: 40.0,
                  width: 40.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha:0.7),
                    borderRadius: BorderRadius.circular(7.0),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withValues(alpha:0.5),
                        spreadRadius: 0.0,
                        blurRadius: 6.0,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: SvgPicture.asset(
                    '${assetImg}filter_icon.svg',
                    colorFilter: ColorFilter.mode(textWhite, BlendMode.srcIn),
                    height: 13.0,
                  ),
                )
              : Container(),
        ],
      ),
    );
 
 
  }
}
