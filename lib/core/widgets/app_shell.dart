import 'package:flutter/material.dart';

import '../localization/app_locale.dart';
import '../routes/app_routes.dart';
import '../../features/dashboard/dashboard_home_view.dart';
import '../../features/orders/orders_dispatch_view.dart';
import '../../features/fleet/driver_fleet_management_view.dart';
import '../../features/inventory/inventory_stock_view.dart';
import '../../features/customers/customer_accounts_view.dart';
import '../../features/staff/staff_management_view.dart';
import '../../features/support/complaints_support_view.dart';
import '../../features/reports/operational_reports_view.dart';
import '../../features/notifications/operational_notifications_view.dart';
import '../../features/settings/agency_settings_view.dart';
import '../../features/simulator/interactive_workflow_simulator_view.dart';
import 'portal_bottom_nav.dart';

class AppShell extends StatefulWidget {
  final int initialIndex;
  const AppShell({super.key, this.initialIndex = 0});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _currentIndex;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _buildView(int index) {
    switch (index) {
      case 0:
        return const DashboardHomeView(showAppBar: false);
      case 1:
        return const OrdersDispatchView(showAppBar: false);
      case 2:
        return const DriverFleetManagementView(showAppBar: false);
      case 3:
        return const InventoryStockView(showAppBar: false);
      case 4:
        return const CustomerAccountsView(showAppBar: false);
      case 5:
        return const StaffManagementView(showAppBar: false);
      case 6:
        return const ComplaintsSupportView(showAppBar: false);
      case 7:
        return const OperationalReportsView(showAppBar: false);
      case 8:
        return const OperationalNotificationsView(showAppBar: false);
      case 9:
        return const AgencySettingsView(showAppBar: false);
      case 10:
        return const InteractiveWorkflowSimulatorView(showAppBar: false);
      default:
        return const DashboardHomeView(showAppBar: false);
    }
  }

  List<String> _getTitles() => [
        AppStrings.dashboardFull,
        AppStrings.ordersFull,
        AppStrings.fleetFull,
        AppStrings.inventoryFull,
        AppStrings.customersFull,
        AppStrings.staffFull,
        AppStrings.complaintsFull,
        AppStrings.reportsFull,
        AppStrings.notificationsFull,
        AppStrings.settingsFull,
        AppStrings.simulatorFull,
      ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: LocaleNotifier.instance,
      builder: (context, locale, _) {
        final isRtl = locale.languageCode == 'ar';
        final titles = _getTitles();

        return Directionality(
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: const Color(0xFFF8F9FF),
            drawerScrimColor: Colors.black.withValues(alpha: 0.35),
            drawerEdgeDragWidth: 40,
            drawerEnableOpenDragGesture: true,
            appBar: _buildShellAppBar(titles),
            drawer: _buildDrawer(),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: isRtl ? const Offset(-0.02, 0) : const Offset(0.02, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: KeyedSubtree(
                key: ValueKey<String>('${_currentIndex}_${locale.languageCode}'),
                child: _buildView(_currentIndex),
              ),
            ),
            bottomNavigationBar: _buildBottomNav(),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildShellAppBar(List<String> titles) {
    final currentTitle = _currentIndex < titles.length ? titles[_currentIndex] : '';

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      toolbarHeight: 64,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Color(0xFF006194)),
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF006194).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.local_gas_station,
              color: Color(0xFF006194),
              size: 22,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.agencyName,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006194),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  currentTitle,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B1C30),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        // Language Toggle Button with smooth micro-interaction
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: InkWell(
            onTap: () => LocaleNotifier.instance.toggleLocale(),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFCCE5FF)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.language, size: 14, color: Color(0xFF006194)),
                  const SizedBox(width: 4),
                  Text(
                    AppStrings.switchLanguage,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF006194),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        IconButton(
          tooltip: AppStrings.simulator,
          icon: const Icon(Icons.hub_outlined, color: Color(0xFF006194)),
          onPressed: () {
            setState(() => _currentIndex = 10);
          },
        ),
        IconButton(
          tooltip: AppStrings.liveMap,
          icon: const Icon(Icons.map_outlined, color: Color(0xFF006194)),
          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.liveMap),
        ),
        IconButton(
          tooltip: AppStrings.interactiveDashboard,
          icon: const Icon(Icons.insights, color: Color(0xFF006948)),
          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.dashboardInteractive),
        ),
        Stack(
          children: [
            IconButton(
              tooltip: AppStrings.notifications,
              icon: const Icon(Icons.notifications_outlined, color: Color(0xFF3F4850)),
              onPressed: () {
                setState(() => _currentIndex = 8);
              },
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFBA1A1A),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width.clamp(280.0, 340.0),
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(),
          _buildDrawerItem(
            icon: Icons.hub_outlined,
            title: AppStrings.simulator,
            index: 10,
            badge: AppStrings.newBadge,
            badgeColor: const Color(0xFF0284C7),
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.dashboard_outlined,
            title: AppStrings.dashboardFull,
            index: 0,
          ),
          _buildDrawerItem(
            icon: Icons.assignment_outlined,
            title: AppStrings.ordersFull,
            index: 1,
            badge: '18 ${AppStrings.pending}',
            badgeColor: const Color(0xFFBA1A1A),
          ),
          _buildDrawerItem(
            icon: Icons.local_shipping_outlined,
            title: AppStrings.fleetFull,
            index: 2,
            badge: '8 ${AppStrings.active}',
            badgeColor: const Color(0xFF006948),
          ),
          _buildDrawerItem(
            icon: Icons.propane_tank_outlined,
            title: AppStrings.inventoryFull,
            index: 3,
          ),
          _buildDrawerItem(
            icon: Icons.people_outline,
            title: AppStrings.customersFull,
            index: 4,
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.badge_outlined,
            title: AppStrings.staffFull,
            index: 5,
          ),
          _buildDrawerItem(
            icon: Icons.headset_mic_outlined,
            title: AppStrings.complaintsFull,
            index: 6,
            badge: '2 ${AppStrings.urgent}',
            badgeColor: const Color(0xFFBA1A1A),
          ),
          _buildDrawerItem(
            icon: Icons.analytics_outlined,
            title: AppStrings.reportsFull,
            index: 7,
          ),
          _buildDrawerItem(
            icon: Icons.notifications_active_outlined,
            title: AppStrings.notificationsFull,
            index: 8,
            badge: '4 ${AppStrings.newBadge}',
            badgeColor: const Color(0xFF006194),
          ),
          _buildDrawerItem(
            icon: Icons.settings_outlined,
            title: AppStrings.settingsFull,
            index: 9,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language, color: Color(0xFF006194)),
            title: Text(
              AppStrings.switchLanguage,
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, fontWeight: FontWeight.w600),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF006194).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                LocaleNotifier.instance.isArabic ? 'English' : 'عربي',
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF006194),
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              LocaleNotifier.instance.toggleLocale();
            },
          ),
          ListTile(
            leading: const Icon(Icons.share_location, color: Color(0xFF006948)),
            title: Text(
              AppStrings.liveMapFull,
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(AppRoutes.directDistribution);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Color(0xFFBA1A1A)),
            title: Text(
              AppStrings.logout,
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFFBA1A1A)),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed(AppRoutes.login);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      decoration: const BoxDecoration(
        color: Color(0xFF006194),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.local_gas_station,
                  color: Color(0xFF006194),
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.portalBadge,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      AppStrings.agencyName,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        color: Color(0xFFCCE5FF),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(radius: 3, backgroundColor: Color(0xFF85F8C4)),
                const SizedBox(width: 6),
                Text(
                  AppStrings.agencySubhead,
                  style: const TextStyle(fontFamily: 'Cairo', fontSize: 11, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required int index,
    String? badge,
    Color? badgeColor,
  }) {
    final isSelected = _currentIndex == index;
    return ListTile(
      selected: isSelected,
      selectedTileColor: const Color(0xFF006194).withValues(alpha: 0.08),
      leading: Icon(
        icon,
        color: isSelected ? const Color(0xFF006194) : const Color(0xFF565E74),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isSelected ? const Color(0xFF006194) : const Color(0xFF0B1C30),
        ),
      ),
      trailing: badge != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: (badgeColor ?? const Color(0xFF006194)).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: badgeColor ?? const Color(0xFF006194),
                ),
              ),
            )
          : null,
      onTap: () {
        Navigator.pop(context); // close drawer
        _onItemTapped(index);
      },
    );
  }

  Widget _buildBottomNav() {
    int bottomIndex = 0;
    if (_currentIndex == 0) {
      bottomIndex = 0;
    } else if (_currentIndex == 1) {
      bottomIndex = 1;
    } else if (_currentIndex == 2) {
      bottomIndex = 2;
    } else if (_currentIndex == 3) {
      bottomIndex = 3;
    } else {
      bottomIndex = 4;
    }

    return PortalBottomNav(
      currentIndex: bottomIndex,
      onTap: (index) {
        if (index == 4) {
          _scaffoldKey.currentState?.openDrawer();
        } else {
          _onItemTapped(index);
        }
      },
    );
  }
}
