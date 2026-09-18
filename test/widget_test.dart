import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gas_distributor_portal/core/localization/app_locale.dart';
import 'package:gas_distributor_portal/core/widgets/portal_bottom_nav.dart';
import 'package:gas_distributor_portal/features/auth/distributor_login_view.dart';
import 'package:gas_distributor_portal/features/orders/order_details_view.dart';
import 'package:gas_distributor_portal/features/fleet/live_drivers_map_view.dart';
import 'package:gas_distributor_portal/features/notifications/operational_notifications_view.dart';
import 'package:gas_distributor_portal/features/simulator/interactive_workflow_simulator_view.dart';
import 'package:gas_distributor_portal/main.dart';

void main() {
  setUp(() {
    // Reset to default English before each test
    LocaleNotifier.instance.setLocale(const Locale('en'));
  });

  testWidgets('Start screen loads in English by default and bottom selector switches immediately', (WidgetTester tester) async {
    await tester.pumpWidget(const GasDistributorPortalApp());
    await tester.pumpAndSettle();

    // 1. Assert default is English
    expect(LocaleNotifier.instance.isEnglish, isTrue);
    expect(find.byType(DistributorLoginView), findsOneWidget);
    expect(find.text('Sign In to Dashboard'), findsOneWidget);
    expect(find.text('Certified Gas Distributor Portal'), findsOneWidget);

    // 2. Select Arabic at the bottom
    final arabicButton = find.text('العربية (RTL)');
    expect(arabicButton, findsOneWidget);
    await tester.ensureVisible(arabicButton);
    await tester.tap(arabicButton);
    await tester.pumpAndSettle();

    // 3. Assert immediate switch to Arabic
    expect(LocaleNotifier.instance.isArabic, isTrue);
    expect(find.text('تسجيل الدخول إلى لوحة التحكم'), findsOneWidget);
    expect(find.text('بوابة موزع الغاز المعتمد'), findsOneWidget);

    // 4. Select English again at the bottom
    final englishButton = find.text('English (LTR)');
    expect(englishButton, findsOneWidget);
    await tester.ensureVisible(englishButton);
    await tester.tap(englishButton);
    await tester.pumpAndSettle();

    expect(LocaleNotifier.instance.isEnglish, isTrue);
    expect(find.text('Sign In to Dashboard'), findsOneWidget);
  });

  testWidgets('Language setting persists after login into AppShell', (WidgetTester tester) async {
    // Test English persistence
    LocaleNotifier.instance.setLocale(const Locale('en'));
    await tester.pumpWidget(const GasDistributorPortalApp());
    await tester.pumpAndSettle();

    final signInButton = find.text('Sign In to Dashboard');
    await tester.tap(signInButton);
    // Let timer complete (1 second simulated verification in login)
    await tester.pump(const Duration(milliseconds: 1100));
    await tester.pumpAndSettle();

    // Language persisted into shell
    expect(LocaleNotifier.instance.isEnglish, isTrue);
    expect(AppStrings.dashboard, 'Home');

    // Tap language toggle in the top bar to switch immediately
    final topBarLangToggle = find.text('العربية');
    expect(topBarLangToggle, findsOneWidget);
    await tester.tap(topBarLangToggle);
    await tester.pumpAndSettle();

    // Switched immediately to Arabic
    expect(LocaleNotifier.instance.isArabic, isTrue);
    expect(AppStrings.dashboard, 'الرئيسية');
    expect(find.text('English'), findsOneWidget); // Top bar now shows English as target
  });

  testWidgets('OrderDetailsView displays properly in English and has persistent bottom nav', (WidgetTester tester) async {
    LocaleNotifier.instance.setLocale(const Locale('en'));
    await tester.pumpWidget(
      const MaterialApp(
        home: OrderDetailsView(),
      ),
    );
    await tester.pumpAndSettle();

    // Assert English translations
    expect(find.text('Order & Invoice Details'), findsOneWidget);
    expect(find.text('Direct from Refinery'), findsOneWidget);
    expect(find.text('Live Delivery Timeline'), findsOneWidget);
    expect(find.text('Stage 4 of 6'), findsOneWidget);
    expect(find.text('Order Received & Confirmed'), findsOneWidget);
    expect(find.text('Customer & Delivery Info'), findsOneWidget);
    expect(find.text('Dr. Samir Haddad'), findsOneWidget);
    expect(find.text('Invoice & Item Details'), findsOneWidget);
    expect(find.text('Total Amount Due (COD)'), findsOneWidget);
    expect(find.text('Assigned Driver & Dispatch'), findsOneWidget);
    expect(find.text('Omar Al-Zoubi'), findsOneWidget);

    // Assert persistent bottom nav
    expect(find.byType(PortalBottomNav), findsOneWidget);
  });

  testWidgets('LiveDriversMapView displays properly in English and has persistent bottom nav', (WidgetTester tester) async {
    LocaleNotifier.instance.setLocale(const Locale('en'));
    await tester.pumpWidget(
      const MaterialApp(
        home: LiveDriversMapView(),
      ),
    );
    await tester.pumpAndSettle();

    // Assert English translations
    expect(find.text('Live Drivers Map'), findsOneWidget);
    expect(find.text('Live GPS Sync (5s ago)'), findsOneWidget);
    expect(find.text('8 Connected Vehicles'), findsOneWidget);
    expect(find.text('Express Distribution Fleet'), findsOneWidget);
    expect(find.text('Omar Al-Zoubi'), findsWidgets);

    // Assert persistent bottom nav
    expect(find.byType(PortalBottomNav), findsOneWidget);
  });

  testWidgets('OperationalNotificationsView removes profile avatar, has working customize modal and bottom nav', (WidgetTester tester) async {
    LocaleNotifier.instance.setLocale(const Locale('en'));
    await tester.pumpWidget(
      const MaterialApp(
        home: OperationalNotificationsView(),
      ),
    );
    await tester.pumpAndSettle();

    // Assert profile avatar removed
    expect(find.byType(CircleAvatar), findsNothing);

    // Assert persistent bottom nav
    expect(find.byType(PortalBottomNav), findsOneWidget);

    // Assert customize preferences button exists and opens modal
    final customizeBtn = find.text('Customize alert tones & notification preferences');
    expect(customizeBtn, findsOneWidget);
    await tester.ensureVisible(customizeBtn);
    await tester.tap(customizeBtn);
    await tester.pumpAndSettle();

    // Modal is now visible
    expect(find.text('Alert Tones & Notification Preferences'), findsOneWidget);
    expect(find.text('Test Alert Siren Sound'), findsOneWidget);
    expect(find.text('Save Preferences'), findsOneWidget);

    // Tap test siren
    await tester.tap(find.text('Test Alert Siren Sound'));
    await tester.pump();

    // Tap save preferences
    await tester.tap(find.text('Save Preferences'));
    await tester.pumpAndSettle();

    // Modal closed
    expect(find.text('Alert Tones & Notification Preferences'), findsNothing);
    await tester.pump(const Duration(seconds: 4));
  });

  testWidgets('Interactive workflow simulator smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: InteractiveWorkflowSimulatorView(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(InteractiveWorkflowSimulatorView), findsOneWidget);
  });
}
