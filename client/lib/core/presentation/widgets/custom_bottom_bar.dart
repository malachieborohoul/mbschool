// ignore_for_file: must_be_immutable, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mbschool/core/presentation/widgets/custom_image_view.dart';
import 'package:mbschool/core/theme/app_decoration.dart';
import 'package:mbschool/core/theme/custom_text_style.dart';
import 'package:mbschool/core/theme/theme_helper.dart';
import 'package:mbschool/core/utils/image_constant.dart';
import 'package:mbschool/core/utils/size_utils.dart';



class CustomBottomBar extends StatelessWidget {
  CustomBottomBar({
    super.key,
    this.onChanged,
  });

  // RxInt selectedIndex = 0.obs;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.homeUnSelected,
      activeIcon: ImageConstant.homeSelected,
      title: "Home",
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: ImageConstant.depositsUnSelected,
      activeIcon: ImageConstant.depositsSelected,
      title: "Deposits",
      type: BottomBarEnum.Deposits,
    ),
    BottomMenuModel(
      icon: ImageConstant.statisticUnSelected,
      activeIcon: ImageConstant.statisticSelected,
      title: "Statistic",
      type: BottomBarEnum.Statistic,
    ),
    BottomMenuModel(
      icon: ImageConstant.loanUnSelected,
      activeIcon: ImageConstant.loanSelected,
      title: "Loan",
      type: BottomBarEnum.Withdraw,
    ),
    BottomMenuModel(
      icon: ImageConstant.profileUnSelected,
      activeIcon: ImageConstant.profileSelected,
      title: "Profile",
      type: BottomBarEnum.Profile,
    )
  ];

  Function(BottomBarEnum)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.v,
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        boxShadow: [
          BoxShadow(
            color: appTheme.indigo8001e,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              4,
              0,
            ),
          ),
        ],
      ),
      child:      BottomNavigationBar(
              backgroundColor: Colors.transparent,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedFontSize: 0,
              elevation: 0,
              // currentIndex: controller.selectedIndex,
              type: BottomNavigationBarType.fixed,
              items: List.generate(bottomMenuList.length, (index) {
                return BottomNavigationBarItem(
                  icon: SizedBox(
                    // decoration: AppDecoration.fillWhiteA,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomImageView(
                          imagePath: bottomMenuList[index].icon,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                          color: appTheme.gray700,
                          margin: EdgeInsets.only(top: 22.v),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 9.v,
                            bottom: 22.v,
                          ),
                          child: Text(
                            bottomMenuList[index].title ?? "",
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: appTheme.gray700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  activeIcon: SizedBox(
                    // decoration: AppDecoration.fillWhiteA,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 18.v),
                          decoration: AppDecoration.fillIndigo.copyWith(
                            borderRadius: BorderRadiusStyle.circleBorder16,
                          ),
                          child: CustomImageView(
                            imagePath: bottomMenuList[index].activeIcon,
                            height: 24.adaptSize,
                            width: 24.adaptSize,
                            color: appTheme.black900,
                            margin: EdgeInsets.fromLTRB(17.h, 4.v, 18.h, 4.v),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 5.v,
                            bottom: 22.v,
                          ),
                          child: Text(
                            bottomMenuList[index].title ?? "",
                            style:
                                CustomTextStyles.bodyMediumBlack900_1.copyWith(
                              color: appTheme.black900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  label: '',
                );
              }),
              onTap: (index) {
                // selectedIndex.value = index;
                onChanged?.call(bottomMenuList[index].type);

                // controller.getIndex(index);
              },
            )
    );
  }
}

enum BottomBarEnum {
  Home,
  Transfers,
  Deposits,
  Statistic,
  Withdraw,
  Profile,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
  });

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffffff),
      padding: const EdgeInsets.all(10),
      child: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class CustomBottomBarController extends GetxController {
//   int selectedIndex = 0;

//   getIndex(int index) {
//     selectedIndex = index;
//     update();
//   }
// }
