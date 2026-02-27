import 'package:flutter/material.dart';
import 'package:mbschool/core/common/animations/slide_transition_page.dart';
import 'package:mbschool/core/presentation/widgets/custom_bottom_bar.dart';
import 'package:mbschool/core/presentation/widgets/custom_image_view.dart';
import 'package:mbschool/core/theme/app_decoration.dart';
import 'package:mbschool/core/theme/custom_text_style.dart';
import 'package:mbschool/core/theme/theme_helper.dart';
import 'package:mbschool/core/utils/image_constant.dart';
import 'package:mbschool/core/utils/size_utils.dart';


class BottomBar extends StatefulWidget {
  static PageRouteBuilder<dynamic> route() => PageRouteBuilder(pageBuilder: (_, animation, __) {
        return SlideTransitionPage(
          page: const BottomBar(),
          animation: animation,
        );
      });
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _pageIndex = 0;
  int selectedIndex = 0;
  late PageController _pageController;

  final List<Widget> _pages = [
    // const HomeScreen(),
    // const DepositsCurrentScreen(),
    // const TransfersScreen(),
    // const WithdrawsScreen(),
    // const StatisticIncomeTabContainerScreen(),
    // LoansScreen(),
    // const CourseScreen(),
    // const FavoriteScreen(),
    // const AccountScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _pageIndex = index);
    _refreshCurrentPage();
  }

  void _refreshCurrentPage() {
    // Vous pouvez implémenter une logique de rafraîchissement ici
    // Par exemple, si vos pages ont une méthode refresh(), vous pouvez l'appeler
    if (_pages[_pageIndex] is RefreshableScreen) {
      (_pages[_pageIndex] as RefreshableScreen).refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages, // Désactive le balayage
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    // var appLocalization = AppLocalizations.of(context);

    List<BottomMenuModel> bottomMenuList = [
      BottomMenuModel(
        icon: ImageConstant.homeUnSelected,
        activeIcon: ImageConstant.homeSelected,
        title:  "Home ",
        type: BottomBarEnum.Home,
      ),


      
      // BottomMenuModel(
      //   icon: ImageConstant.statisticUnSelected,
      //   activeIcon: ImageConstant.statisticSelected,
      //   title: appLocalization.lbl_statistic,
      //   type: BottomBarEnum.Statistic,
      // ),
      // BottomMenuModel(
      //   icon: ImageConstant.loanUnSelected,
      //   activeIcon: ImageConstant.loanSelected,
      //   title: appLocalization.lbl_loan,
      //   type: BottomBarEnum.Loan,
      // ),
 
    ];

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
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          elevation: 0,
          currentIndex: selectedIndex,
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
                      decoration: AppDecoration.fillPrimary .copyWith(
                        borderRadius: BorderRadiusStyle.circleBorder16,
                        color: ColorSchemes.primaryColorScheme.primary.withValues(alpha: .2)
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
                        style: CustomTextStyles.bodyMediumBlack900_1.copyWith(
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
            _pageController.jumpToPage(index);
            _onPageChanged(index);
            selectedIndex = index;
            // onChanged?.call(bottomMenuList[index].type);

            // controller.getIndex(index);
          },
        ));
  }
}

// Interface pour les écrans rafraîchissables
abstract class RefreshableScreen {
  void refresh();
}



// Répétez le même modèle pour CourseScreen, FavoriteScreen, et AccountScreen 