import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/features/account/screens/account_screen.dart';
import 'package:mbschool/features/course/screens/course_screen.dart';
import 'package:mbschool/features/favorite/screens/favorite_screen.dart';
import 'package:mbschool/features/filter/screens/filter_course_screen.dart';
import 'package:mbschool/features/home/screens/home_screen.dart';

class BottomBar extends StatefulWidget {
  static const routeName = '/bottom-bar';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _pageIndex = 0;
  late PageController _pageController;

  final List<Widget> _pages = [
    const HomeScreen(),
    const CourseScreen(),
    const FavoriteScreen(),
    const AccountScreen(),
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
        children: _pages,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(), // Désactive le balayage
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildBottomNavigationBar() {
    List<String> items = [
      "assets/images/home_icon.svg",
      "assets/images/play_icon.svg",
      "assets/images/favorite_icon.svg",
      "assets/images/user_icon.svg",
    ];

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: textWhite,
        boxShadow: [
          BoxShadow(
            color: textBlack.withOpacity(0.12),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          return _buildNavItem(items[index], index);
        }),
      ),
    );
  }

  Widget _buildNavItem(String iconPath, int index) {
    return GestureDetector(
      onTap: () {
        _pageController.jumpToPage(index);
        _onPageChanged(index);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 24,
              color: _pageIndex == index ? primary : secondary,
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 4,
              width: _pageIndex == index ? 20 : 0,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _showFilterBottomSheet,
      backgroundColor: secondary,
      child: const Icon(
        Icons.filter_list_outlined,
        color: textWhite,
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: FilterCourseScreen(controller: controller),
        ),
      ),
    );
  }
}

// Interface pour les écrans rafraîchissables
abstract class RefreshableScreen {
  void refresh();
}



// Répétez le même modèle pour CourseScreen, FavoriteScreen, et AccountScreen 