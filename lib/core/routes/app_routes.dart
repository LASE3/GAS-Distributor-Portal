import 'package:flutter/material.dart';

import '../../features/auth/distributor_login_view.dart';
import '../../features/auth/password_recovery_view.dart';
import '../../features/dashboard/dashboard_home_view.dart';
import '../../features/dashboard/home_operational_dashboard_interactive.dart';
import '../../features/orders/orders_dispatch_view.dart';
import '../../features/orders/order_details_view.dart';
import '../../features/orders/smart_assignment_view.dart';
import '../../features/fleet/driver_fleet_management_view.dart';
import '../../features/fleet/driver_profile_view.dart';
import '../../features/fleet/live_drivers_map_view.dart';
import '../../features/fleet/driver_direct_distribution_map_interactive.dart';
import '../../features/inventory/inventory_stock_view.dart';
import '../../features/inventory/inventory_movements_view.dart';
import '../../features/customers/customer_accounts_view.dart';
import '../../features/staff/staff_management_view.dart';
import '../../features/support/complaints_support_view.dart';
import '../../features/reports/operational_reports_view.dart';
import '../../features/notifications/operational_notifications_view.dart';
import '../../features/settings/agency_settings_view.dart';
import '../../features/simulator/interactive_workflow_simulator_view.dart';
import '../widgets/app_shell.dart';

class AppRoutes {
  AppRoutes._();

  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String shell = '/shell';
  static const String dashboard = '/dashboard';
  static const String dashboardInteractive = '/dashboard-interactive';
  static const String orders = '/orders';
  static const String orderDetails = '/orders/details';
  static const String smartDispatch = '/orders/smart-dispatch';
  static const String fleet = '/fleet';
  static const String driverProfile = '/fleet/profile';
  static const String liveMap = '/fleet/live-map';
  static const String directDistribution = '/fleet/direct-distribution';
  static const String inventory = '/inventory';
  static const String inventoryMovements = '/inventory/movements';
  static const String customers = '/customers';
  static const String staff = '/staff';
  static const String complaints = '/complaints';
  static const String reports = '/reports';
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String simulator = '/simulator';

  // Convenient Aliases
  static const String home = shell;
  static const String liveDriversMap = liveMap;
  static const String smartAssignment = smartDispatch;

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const DistributorLoginView());

      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const PasswordRecoveryView());

      case shell:
        final initialIndex = routeSettings.arguments as int? ?? 0;
        return MaterialPageRoute(builder: (_) => AppShell(initialIndex: initialIndex));

      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardHomeView());

      case dashboardInteractive:
        return MaterialPageRoute(builder: (_) => const HomeOperationalDashboardInteractive());

      case orders:
        return MaterialPageRoute(builder: (_) => const OrdersDispatchView());

      case orderDetails:
        return MaterialPageRoute(builder: (_) => const OrderDetailsView());

      case smartDispatch:
        return MaterialPageRoute(builder: (_) => const SmartAssignmentView());

      case fleet:
        return MaterialPageRoute(builder: (_) => const DriverFleetManagementView());

      case driverProfile:
        return MaterialPageRoute(builder: (_) => const DriverProfileView());

      case liveMap:
        return MaterialPageRoute(builder: (_) => const LiveDriversMapView());

      case directDistribution:
        return MaterialPageRoute(builder: (_) => const DriverDirectDistributionMapInteractive());

      case inventory:
        return MaterialPageRoute(builder: (_) => const InventoryStockView());

      case inventoryMovements:
        return MaterialPageRoute(builder: (_) => const InventoryMovementsView());

      case customers:
        return MaterialPageRoute(builder: (_) => const CustomerAccountsView());

      case staff:
        return MaterialPageRoute(builder: (_) => const StaffManagementView());

      case complaints:
        return MaterialPageRoute(builder: (_) => const ComplaintsSupportView());

      case reports:
        return MaterialPageRoute(builder: (_) => const OperationalReportsView());

      case notifications:
        return MaterialPageRoute(builder: (_) => const OperationalNotificationsView());

      case settings:
        return MaterialPageRoute(builder: (_) => const AgencySettingsView());

      case simulator:
        return MaterialPageRoute(builder: (_) => const InteractiveWorkflowSimulatorView());

      default:
        return MaterialPageRoute(builder: (_) => const DistributorLoginView());
    }
  }
}
