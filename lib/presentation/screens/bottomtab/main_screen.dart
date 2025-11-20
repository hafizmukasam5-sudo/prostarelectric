import 'package:flutter/material.dart';

import 'package:prostarelectrical/presentation/screens/auth/forgetpassword/forget_password_screen.dart';
import 'package:prostarelectrical/presentation/screens/favorites/favorites_screen.dart';
import 'package:prostarelectrical/presentation/screens/homescreen/home_screen.dart';
import 'package:prostarelectrical/presentation/screens/materials/materials_list_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeTab(),
    const FavoritesScreen(),
    const MaterialsListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textwhite,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.textwhite,
          selectedItemColor: AppColors.green,
          unselectedItemColor: AppColors.primaryblue,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          elevation: 8,
          items: [
            _buildNavItem(
              icon: AppImages.home,
              activeIcon: AppImages.homeselected,
              label: 'Home',
              isSelected: _currentIndex == 0,
            ),
            _buildNavItem(
              icon: AppImages.fav,
              activeIcon: AppImages.favselected,
              label: 'Favorite',
              isSelected: _currentIndex == 1,
            ),
            _buildNavItem(
              icon: AppImages.cart,
              activeIcon: AppImages.cartselected,
              label: 'Materials List',
              isSelected: _currentIndex == 2,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required String icon,
    required String activeIcon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 0),
        child: Image.asset(
          isSelected ? activeIcon : icon,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
          gaplessPlayback: true, // This prevents flickering
        ),
      ),
      label: label,
    );
  }
}
