import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/features/home/presentation/views/home_view.dart';
import 'package:west_elbalad/features/settings/presentation/views/settings_view.dart';
import 'package:west_elbalad/features/shopping_cart/presentation/views/shopping_cart_view.dart';
import 'package:west_elbalad/features/used_phones/presentation/views/used_phones_view.dart';

/// Bottom navigation bar controller for the USER flavor.
/// Tabs order: الرئيسية | مستعملة | عربة التسوق | الإعدادات
class UserBottomNavBarController extends StatefulWidget {
  const UserBottomNavBarController({super.key});

  @override
  State<UserBottomNavBarController> createState() =>
      _UserBottomNavBarControllerState();
}

class _UserBottomNavBarControllerState
    extends State<UserBottomNavBarController> {
  int index = 0;

  /// Changing this key forces the cart widget to dispose and recreate,
  /// which triggers a fresh fetch of orders every time the tab is tapped.
  Key _cartKey = UniqueKey();

  final List<_NavItem> _items = const [
    _NavItem(icon: Icons.home_rounded, label: 'الرئيسية'),
    _NavItem(icon: Icons.phone_android_rounded, label: 'مستعملة'),
    _NavItem(icon: Icons.shopping_cart_rounded, label: 'عربة التسوق'),
    _NavItem(icon: Icons.settings_rounded, label: 'الإعدادات'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: _FloatingNavBar(
        currentIndex: index,
        items: _items,
        onTap: (i) => setState(() {
          if (i == 2) {
            // Refresh the cart every time the tab is tapped
            _cartKey = UniqueKey();
          }
          index = i;
        }),
      ),
      body: IndexedStack(
        index: index,
        children: [
          const HomeView(),
          const UsedPhones(),
          ShoppingCartView(key: _cartKey, showBackBar: false),
          const SettingsView(),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}

class _FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final List<_NavItem> items;
  final void Function(int) onTap;

  const _FloatingNavBar({
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        bottom: 16.h,
      ),
      child: Container(
        height: 64.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.15),
              blurRadius: 24,
              spreadRadius: 0,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (i) {
            final selected = i == currentIndex;
            return GestureDetector(
              onTap: () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.primary.withOpacity(0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      items[i].icon,
                      size: 22.r,
                      color: selected ? AppColors.primary : AppColors.darkGrey,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      items[i].label,
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight:
                            selected ? FontWeight.w700 : FontWeight.w400,
                        color:
                            selected ? AppColors.primary : AppColors.darkGrey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
