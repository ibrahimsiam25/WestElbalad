import 'package:flutter/material.dart';
import 'package:west_elbalad/core/constants/app_assets.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/features/admin/presentation/views/admin_view.dart';
import 'package:west_elbalad/features/home/presentation/views/home_view.dart';
import 'package:west_elbalad/features/profile/presentation/views/profile_view.dart';
import 'package:west_elbalad/features/settings/presentation/views/settings_view.dart';

class BottomNavBarController extends StatefulWidget {
  const BottomNavBarController({super.key});
  @override
  State<BottomNavBarController> createState() => _BottomNavBarControllerState();
}

class _BottomNavBarControllerState extends State<BottomNavBarController> {
  int index = 0;
  bool showAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        currentIndex: index,
        onTap: (int value) {
          setState(() {
            index = value;
          });
        },
        items: [
          bottomNavBarItem(AppAssets.home),
          bottomNavBarItem(AppAssets.user),
          bottomNavBarItem(AppAssets.settings),
          bottomNavBarItem(AppAssets.admin),
        ],
      ),
      body: IndexedStack(
        index: index,
        children: [
          HomeView(),
          ProfileView(),
          SettingsView(),
          AdminView(),
        ],
      ),
    );
  }
}

BottomNavigationBarItem bottomNavBarItem(String image) {
  return BottomNavigationBarItem(
    activeIcon: Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(
          kRadius32,
        ),
      ),
      child: Image.asset(
        width: 32.0,
        height: 32.0,
        color: AppColors.white,
        image,
      ),
    ),
    icon: Image.asset(
      width: 32.0,
      height: 32.0,
      color: AppColors.black,
      repeat: ImageRepeat.repeatX,
      image,
    ),
    label: '',
  );
}
