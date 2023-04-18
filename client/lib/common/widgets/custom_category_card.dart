
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/datas/category_json.dart';

class CustomCategoryCard extends StatelessWidget {
  const CustomCategoryCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(HomePageCategoryJson.length, (index) {
          
         
          return GestureDetector(
            onTap: () {
            
            },
            child: Container(
              height: size.width * .26,
              width: size.width * .26,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: textWhite,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: textBlack.withOpacity(0.05),
                    blurRadius: 15.0,
                    offset: const Offset(0, 7),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 35.0,
                    width: 35.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primary.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: primary.withOpacity(0.5),
                          spreadRadius: 0.0,
                          blurRadius: 6.0,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: SvgPicture.asset(
                      HomePageCategoryJson[index]['icon'],
                      color: textWhite,
                      width: 15.0,
                    ),
                  ),
                  Text(
                    HomePageCategoryJson[index]['title'],
                    style: const TextStyle(
                      color: secondary,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 0.0),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
