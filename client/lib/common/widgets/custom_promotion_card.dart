import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/datas/promotion.dart';

class CustomPromotionCard extends StatelessWidget {
  const CustomPromotionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: appPadding, right: appPadding),
      child: Stack(
        alignment: Alignment.topRight,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size.width,
            height: size.width * .55,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: secondary,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Promotion['title'].toString(),
                  style: const TextStyle(
                    fontSize: 25.0,
                    color: textWhite,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 7.0),
                SizedBox(
                  width: size.width * .425,
                  child: Text(
                    Promotion['subTitle'].toString(),
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: textWhite,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  height: 35.0,
                  width: 100.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(100.0),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withOpacity(0.5),
                        spreadRadius: 0.0,
                        blurRadius: 6.0,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: const Text(
                    "S'enrôler ",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: textWhite,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 25.0,
            right: 0,
            left: 125,
            child: SizedBox(
              height: size.width * .6,
              child: SvgPicture.asset(
                Promotion['image'].toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
