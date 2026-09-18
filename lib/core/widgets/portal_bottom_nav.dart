import 'package:flutter/material.dart';
import '../localization/app_locale.dart';
import '../routes/app_routes.dart';

class PortalBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const PortalBottomNav({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  void _handleTap(BuildContext context, int index) {
    if (onTap != null) {
      onTap!(index);
      return;
    }

    // Default global navigation when used in standalone views
    switch (index) {
      case 0:
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.shell,
          (route) => false,
          arguments: 0,
        );
        break;
      case 1:
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.shell,
          (route) => false,
          arguments: 1,
        );
        break;
      case 2:
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.shell,
          (route) => false,
          arguments: 2,
        );
        break;
      case 3:
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.shell,
          (route) => false,
          arguments: 3,
        );
        break;
      case 4:
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.shell,
          (route) => false,
          arguments: 9, // Agency settings / more
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final clampedIndex = currentIndex.clamp(0, 4);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: BottomNavigationBar(
          currentIndex: clampedIndex,
          onTap: (index) => _handleTap(context, index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFF006194),
          unselectedItemColor: const Color(0xFF707881),
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 11,
          ),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.dashboard_outlined),
              activeIcon: const Icon(Icons.dashboard),
              label: AppStrings.dashboard,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.assignment_outlined),
              activeIcon: const Icon(Icons.assignment),
              label: AppStrings.orders,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.local_shipping_outlined),
              activeIcon: const Icon(Icons.local_shipping),
              label: AppStrings.fleet,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.propane_tank_outlined),
              activeIcon: const Icon(Icons.propane_tank),
              label: AppStrings.inventory,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.menu),
              activeIcon: const Icon(Icons.menu_open),
              label: AppStrings.more,
            ),
          ],
        ),
      ),
    );
  }
}
