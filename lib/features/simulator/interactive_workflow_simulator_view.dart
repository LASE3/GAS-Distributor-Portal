import 'package:flutter/material.dart';

import '../../core/localization/app_locale.dart';
import '../../core/routes/app_routes.dart';

class SimulatorScreenItem {
  final String id;
  final int stage;
  final int stepNo;
  final String titleAr;
  final String titleEn;
  final String categoryAr;
  final String categoryEn;
  final String roleAr;
  final String roleEn;
  final String icon;
  final String descAr;
  final String descEn;
  final List<SimulatorConnection> connections;
  final String nextActionAr;
  final String nextActionEn;
  final String? routeName;

  const SimulatorScreenItem({
    required this.id,
    required this.stage,
    required this.stepNo,
    required this.titleAr,
    required this.titleEn,
    required this.categoryAr,
    required this.categoryEn,
    required this.roleAr,
    required this.roleEn,
    required this.icon,
    required this.descAr,
    required this.descEn,
    required this.connections,
    required this.nextActionAr,
    required this.nextActionEn,
    this.routeName,
  });

  String get title => AppStrings.isArabic ? titleAr : titleEn;
  String get category => AppStrings.isArabic ? categoryAr : categoryEn;
  String get role => AppStrings.isArabic ? roleAr : roleEn;
  String get desc => AppStrings.isArabic ? descAr : descEn;
  String get nextAction => AppStrings.isArabic ? nextActionAr : nextActionEn;
}

class SimulatorConnection {
  final int targetStep;
  final String labelAr;
  final String labelEn;

  const SimulatorConnection({
    required this.targetStep,
    required this.labelAr,
    required this.labelEn,
  });

  String get label => AppStrings.isArabic ? labelAr : labelEn;
}

class InteractiveWorkflowSimulatorView extends StatefulWidget {
  final bool showAppBar;
  const InteractiveWorkflowSimulatorView({super.key, this.showAppBar = true});

  @override
  State<InteractiveWorkflowSimulatorView> createState() =>
      _InteractiveWorkflowSimulatorViewState();
}

class _InteractiveWorkflowSimulatorViewState
    extends State<InteractiveWorkflowSimulatorView>
    with SingleTickerProviderStateMixin {
  int _currentStepIndex = 0;
  final ScrollController _scrollController = ScrollController();

  final List<SimulatorScreenItem> _screens = const [
    // STAGE 1: Authentication & Security
    SimulatorScreenItem(
      id: 'screen_1',
      stage: 1,
      stepNo: 1,
      titleAr: 'تسجيل دخول الموزع (تفاعلية)',
      titleEn: 'Distributor Login (Interactive)',
      categoryAr: 'الدخول والأمان',
      categoryEn: 'Auth & Security',
      roleAr: 'كافة المستخدمين',
      roleEn: 'All Portal Users',
      icon: '🔐',
      descAr:
          'نقطة الدخول المركزية للموزع المسجل لدى نقابة أصحاب المحروقات بالرقم الوطني ورخصة المنشأة.',
      descEn:
          'Central login for gas distributors accredited by Syndicate of Fuel & Gas Stations with national ID and trade license.',
      connections: [
        SimulatorConnection(targetStep: 2, labelAr: 'استعادة كلمة المرور (OTP)', labelEn: 'Recover Password (OTP)'),
        SimulatorConnection(targetStep: 3, labelAr: 'تسجيل الدخول والبدء', labelEn: 'Login and Start'),
      ],
      nextActionAr: 'تسجيل الدخول والانتقال إلى المستودع',
      nextActionEn: 'Login and proceed to Warehouse',
      routeName: AppRoutes.login,
    ),
    SimulatorScreenItem(
      id: 'screen_2',
      stage: 1,
      stepNo: 2,
      titleAr: 'استعادة وتعيين كلمة المرور',
      titleEn: 'Password Recovery & Reset',
      categoryAr: 'الدخول والأمان',
      categoryEn: 'Auth & Security',
      roleAr: 'مالك الوكالة / المدير',
      roleEn: 'Agency Owner / Manager',
      icon: '📩',
      descAr:
          'إرسال رمز تحقق مؤقت (SMS OTP) للرقم المسجل للتحقق الفوري وإعادة تعيين كلمة المرور المشفرة.',
      descEn:
          'Sends encrypted SMS OTP to the registered mobile number for instant identity verification and secure password reset.',
      connections: [
        SimulatorConnection(targetStep: 1, labelAr: 'العودة لتسجيل الدخول', labelEn: 'Back to Login'),
      ],
      nextActionAr: 'إتمام التحقق والعودة للدخول',
      nextActionEn: 'Complete verification and return to Login',
      routeName: AppRoutes.forgotPassword,
    ),

    // STAGE 2: Warehouse Readiness & Logistics
    SimulatorScreenItem(
      id: 'screen_3',
      stage: 2,
      stepNo: 3,
      titleAr: 'سجل حركات المخزون وتوريدات المصفاة',
      titleEn: 'Inventory Movements & Refinery Supplies',
      categoryAr: 'جاهزية المستودع',
      categoryEn: 'Warehouse Readiness',
      roleAr: 'أمين المستودع المركزي',
      roleEn: 'Central Storekeeper',
      icon: '🚛',
      descAr:
          'استلام إرساليات مصفاة البترول (الزرقاء)، الفحص الفني لسلامة الصمامات، وفرز الأسطوانات التالفة.',
      descEn:
          'Reception of Jordan Petroleum Refinery consignments (Zarqa), technical valve safety inspections, and damaged cylinder triage.',
      connections: [
        SimulatorConnection(targetStep: 4, labelAr: 'مطابقة المخزون بالمستودع', labelEn: 'Reconcile Warehouse Stock'),
        SimulatorConnection(targetStep: 5, labelAr: 'تحميل حمولات الشاحنات', labelEn: 'Load Truck Fleet'),
      ],
      nextActionAr: 'الانتقال إلى جرد المخزون العام',
      nextActionEn: 'Proceed to General Stock Count',
      routeName: AppRoutes.inventoryMovements,
    ),
    SimulatorScreenItem(
      id: 'screen_4',
      stage: 2,
      stepNo: 4,
      titleAr: 'إدارة المخزون والمستودع (تفاعلية)',
      titleEn: 'Inventory & Warehouse Management (Interactive)',
      categoryAr: 'جاهزية المستودع',
      categoryEn: 'Warehouse Readiness',
      roleAr: 'أمين المستودع المركزي',
      roleEn: 'Central Storekeeper',
      icon: '📦',
      descAr:
          'جرد لحظي للأسطوانات الممتلئة، الفارغة، صمامات الأمان، وساعات الغاز ومستلزمات التركيب.',
      descEn:
          'Real-time inventory of full/empty cylinders, safety relief valves, pressure regulators, and installation accessories.',
      connections: [
        SimulatorConnection(targetStep: 3, labelAr: 'عرض سجل التوريدات', labelEn: 'View Supply Logs'),
        SimulatorConnection(targetStep: 5, labelAr: 'توزيع الحصص على السائقين', labelEn: 'Allocate Quotas to Drivers'),
      ],
      nextActionAr: 'الانتقال إلى تجهيز أسطول السائقين',
      nextActionEn: 'Proceed to Driver Fleet Preparation',
      routeName: AppRoutes.inventory,
    ),
    SimulatorScreenItem(
      id: 'screen_5',
      stage: 2,
      stepNo: 5,
      titleAr: 'إدارة السائقين والأسطول (تفاعلية)',
      titleEn: 'Driver Fleet Management (Interactive)',
      categoryAr: 'جاهزية المستودع',
      categoryEn: 'Warehouse Readiness',
      roleAr: 'مدير العمليات',
      roleEn: 'Operations Manager',
      icon: '🚚',
      descAr:
          'توزيع حصص الأسطوانات اليومية، فحص رخص المركبات، وتفعيل الجاهزية الميدانية في عمان الغربية.',
      descEn:
          'Daily cylinder quota allocation, vehicle roadworthiness verification, and active field readiness across West Amman.',
      connections: [
        SimulatorConnection(targetStep: 6, labelAr: 'فتح لوحة التحكم التشغيلية', labelEn: 'Open Operational Dashboard'),
        SimulatorConnection(targetStep: 12, labelAr: 'ملف السائق عمر الزعبي', labelEn: 'Driver Profile: Omar Zoubi'),
      ],
      nextActionAr: 'فتح لوحة التحكم وبدء استقبال الطلبات',
      nextActionEn: 'Open Dashboard and start receiving orders',
      routeName: AppRoutes.fleet,
    ),

    // STAGE 3: Central Dispatch & Order Ingestion
    SimulatorScreenItem(
      id: 'screen_6',
      stage: 3,
      stepNo: 6,
      titleAr: 'الرئيسية - لوحة التحكم التشغيلية (تفاعلية)',
      titleEn: 'Dashboard Home - Operations (Interactive)',
      categoryAr: 'الإسناد والطلبات',
      categoryEn: 'Orders & Dispatch',
      roleAr: 'مدير الوكالة / المالك',
      roleEn: 'Agency Manager / Owner',
      icon: '📊',
      descAr:
          'لوحة القيادة التشغيلية: مؤشرات الأداء الحية، عدد الأسطوانات الموزعة، الإيراد، وحالة أسطول التوصيل.',
      descEn:
          'Live operational cockpit: real-time KPIs, distributed cylinders, revenue ticker, and fleet active status.',
      connections: [
        SimulatorConnection(targetStep: 7, labelAr: 'عرض قائمة الطلبات الواردة', labelEn: 'Incoming Orders List'),
        SimulatorConnection(targetStep: 9, labelAr: 'الإسناد والتوزيع الذكي', labelEn: 'Smart AI Dispatch'),
        SimulatorConnection(targetStep: 10, labelAr: 'خريطة السائقين المباشرة', labelEn: 'Live Drivers GPS Map'),
      ],
      nextActionAr: 'الانتقال إلى قائمة الطلبات',
      nextActionEn: 'Proceed to Orders Dispatch list',
      routeName: AppRoutes.dashboard,
    ),
    SimulatorScreenItem(
      id: 'screen_7',
      stage: 3,
      stepNo: 7,
      titleAr: 'إدارة الطلبات والتوزيع',
      titleEn: 'Orders Dispatch & Queue',
      categoryAr: 'الإسناد والطلبات',
      categoryEn: 'Orders & Dispatch',
      roleAr: 'مسؤول الإسناد والتوجيه',
      roleEn: 'Dispatch Officer',
      icon: '📋',
      descAr:
          'فرز وإدارة طلبات التوصيل: الطلبات الجديدة، قيد التجهيز، المسندة، مع فلترة الأحياء (خلدا، تلاع العلي).',
      descEn:
          'Triage and manage delivery orders: new, in-prep, dispatched, with zone filtering (Khalda, Tlaa Al-Ali, Dabouq).',
      connections: [
        SimulatorConnection(targetStep: 8, labelAr: 'سجل المشتركين والعملاء', labelEn: 'Customer Accounts Log'),
        SimulatorConnection(targetStep: 9, labelAr: 'إسناد طلب لسائق', labelEn: 'Smart Assign to Driver'),
        SimulatorConnection(targetStep: 11, labelAr: 'تفاصيل الطلب #ORD-2410', labelEn: 'Order Details #ORD-2410'),
      ],
      nextActionAr: 'فتح سجل المشتركين وعقود المطاعم',
      nextActionEn: 'Open Customer Accounts & Contracts',
      routeName: AppRoutes.orders,
    ),
    SimulatorScreenItem(
      id: 'screen_8',
      stage: 3,
      stepNo: 8,
      titleAr: 'سجل وقائمة عملاء الوكالة',
      titleEn: 'Customer Accounts & Subscriptions',
      categoryAr: 'الإسناد والطلبات',
      categoryEn: 'Orders & Dispatch',
      roleAr: 'خدمة العملاء والإسناد',
      roleEn: 'Customer Service & Dispatch',
      icon: '👥',
      descAr:
          'إدارة بيانات 1,480 مشترك، عقود المنشآت والمطاعم الدورية، وحسابات أسطوانات الأمانة والتسليم الآجل.',
      descEn:
          'Manages 1,480 residential and commercial accounts, periodic restaurant contracts, deposits, and deferred credit terms.',
      connections: [
        SimulatorConnection(targetStep: 7, labelAr: 'العودة للطلبات', labelEn: 'Back to Orders'),
        SimulatorConnection(targetStep: 9, labelAr: 'طلب تعبئة فوري وإسناد', labelEn: 'Instant Refill & Dispatch'),
      ],
      nextActionAr: 'الانتقال إلى الإسناد الذكي',
      nextActionEn: 'Proceed to Smart Dispatch',
      routeName: AppRoutes.customers,
    ),

    // STAGE 4: Smart Dispatch & Live Field Operations
    SimulatorScreenItem(
      id: 'screen_9',
      stage: 4,
      stepNo: 9,
      titleAr: 'الإسناد والتوزيع الذكي (تفاعلية)',
      titleEn: 'Smart Automated Assignment (Interactive)',
      categoryAr: 'التوزيع والتتبع الميداني',
      categoryEn: 'Field Tracking',
      roleAr: 'مسؤول الإسناد (Dispatcher)',
      roleEn: 'Dispatcher',
      icon: '⚡',
      descAr:
          'خوارزمية الإسناد الذكية لاقتراح السائق الأقرب جغرافياً بالحمولة المطابقة وسرعة الوصول.',
      descEn:
          'Intelligent AI dispatch algorithm matching nearest driver geographically with correct cylinder weight and fastest ETA.',
      connections: [
        SimulatorConnection(targetStep: 10, labelAr: 'تتبع السائق على الخريطة', labelEn: 'Track Driver on GPS Map'),
        SimulatorConnection(targetStep: 11, labelAr: 'متابعة مسار الطلب', labelEn: 'Monitor Order Timeline'),
      ],
      nextActionAr: 'فتح خريطة التتبع المباشر',
      nextActionEn: 'Open Live GPS Tracking Map',
      routeName: AppRoutes.smartDispatch,
    ),
    SimulatorScreenItem(
      id: 'screen_10',
      stage: 4,
      stepNo: 10,
      titleAr: 'خريطة السائقين والتوزيع المباشر (تفاعلية)',
      titleEn: 'Live Drivers GPS Map (Interactive)',
      categoryAr: 'التوزيع والتتبع الميداني',
      categoryEn: 'Field Tracking',
      roleAr: 'مسؤول الإسناد / المدير',
      roleEn: 'Dispatcher / Manager',
      icon: '🗺️',
      descAr:
          'تتبع حي لشاحنات الغاز عبر GPS في أحياء عمان الغربية مع نبضات حية للحالة والسرعة والموقع.',
      descEn:
          'Real-time GPS telemetry for distribution trucks in West Amman with speed, heartbeat, active route, and cargo telemetry.',
      connections: [
        SimulatorConnection(targetStep: 11, labelAr: 'تفاصيل الطلب الجاري', labelEn: 'Current Order Details'),
        SimulatorConnection(targetStep: 12, labelAr: 'ملف السائق الميداني', labelEn: 'Field Driver Profile'),
      ],
      nextActionAr: 'معاينة تفاصيل الطلب والمسار الزمني',
      nextActionEn: 'Preview Order Details and Timeline',
      routeName: AppRoutes.liveMap,
    ),
    SimulatorScreenItem(
      id: 'screen_11',
      stage: 4,
      stepNo: 11,
      titleAr: 'تفاصيل الطلب #ORD-2410 (تفاعلية)',
      titleEn: 'Order Details #ORD-2410 (Interactive)',
      categoryAr: 'التوزيع والتتبع الميداني',
      categoryEn: 'Field Tracking',
      roleAr: 'السائق / مسؤول الإسناد',
      roleEn: 'Driver / Dispatcher',
      icon: '📦',
      descAr:
          'خط التتبع الزمني، بيانات العميل، نوع الأسطوانة، فحص رغوة الصابون للتسريب، والتحصيل النقدي COD.',
      descEn:
          'Step-by-step order journey, recipient data, cylinder spec, soap bubble leak inspection verification, and COD collection.',
      connections: [
        SimulatorConnection(targetStep: 10, labelAr: 'العودة للخريطة', labelEn: 'Back to Map'),
        SimulatorConnection(targetStep: 12, labelAr: 'كابتن الطلب: عمر الزعبي', labelEn: 'Assigned Driver Profile'),
        SimulatorConnection(targetStep: 14, labelAr: 'إبلاغ عن شكوى أو طارئ', labelEn: 'Report Support Incident'),
      ],
      nextActionAr: 'عرض ملف السائق التفصيلي',
      nextActionEn: 'Open Detailed Driver Profile',
      routeName: AppRoutes.orderDetails,
    ),
    SimulatorScreenItem(
      id: 'screen_12',
      stage: 4,
      stepNo: 12,
      titleAr: 'ملف السائق - عمر الزعبي (تفاعلية)',
      titleEn: 'Driver Profile - Omar Al-Zoubi (Interactive)',
      categoryAr: 'التوزيع والتتبع الميداني',
      categoryEn: 'Field Tracking',
      roleAr: 'مدير العمليات',
      roleEn: 'Operations Manager',
      icon: '👤',
      descAr:
          'سجل الكابتن الميداني: معدل التوصيل، تقييمات السلامة، رصيد العهدة النقدية، وحمولة الشاحنة الحالية.',
      descEn:
          'Field driver dossier: completion rate, safety ratings, cash-in-hand float, and real-time truck cargo breakdown.',
      connections: [
        SimulatorConnection(targetStep: 15, labelAr: 'إغلاق وردية السائق ومطابقة العهدة', labelEn: 'Close Shift & Settle Float'),
        SimulatorConnection(targetStep: 10, labelAr: 'موقعه على الخريطة', labelEn: 'Show on Live Map'),
      ],
      nextActionAr: 'الانتقال إلى مركز الإشعارات والرقابة',
      nextActionEn: 'Proceed to Alerts & Supervision',
      routeName: AppRoutes.driverProfile,
    ),

    // STAGE 5: Incidents & Supervision
    SimulatorScreenItem(
      id: 'screen_13',
      stage: 5,
      stepNo: 13,
      titleAr: 'مركز الإشعارات والتنبيهات التشغيلية',
      titleEn: 'Operational Notifications Center',
      categoryAr: 'الطوارئ والرقابة',
      categoryEn: 'Incidents & Safety',
      roleAr: 'كافة مسؤولي النظام',
      roleEn: 'All System Operators',
      icon: '🔔',
      descAr:
          'رصد فوري للتنبيهات الحرجة: حالات تسريب الغاز، انخفاض الأمان، وفقدان إشارة GPS للمركبة.',
      descEn:
          'Real-time critical alarms: suspected gas leak alerts, low safety inventory, and truck GPS offline warnings.',
      connections: [
        SimulatorConnection(targetStep: 14, labelAr: 'مركز الشكاوى وبلاغات الطوارئ', labelEn: 'Complaints & Emergency Support'),
        SimulatorConnection(targetStep: 10, labelAr: 'تحديد موقع الإنذار', labelEn: 'Locate Incident on GPS'),
      ],
      nextActionAr: 'الانتقال إلى مركز الشكاوى والدعم',
      nextActionEn: 'Proceed to Support Center',
      routeName: AppRoutes.notifications,
    ),
    SimulatorScreenItem(
      id: 'screen_14',
      stage: 5,
      stepNo: 14,
      titleAr: 'مركز الشكاوى والدعم (تفاعلية)',
      titleEn: 'Complaints & Support Center (Interactive)',
      categoryAr: 'الطوارئ والرقابة',
      categoryEn: 'Incidents & Safety',
      roleAr: 'فريق الدعم الفني والسلامة',
      roleEn: 'Safety & Support Team',
      icon: '🚨',
      descAr:
          'معالجة بلاغات السلامة الطارئة، شكاوى تأخر التوصيل، وفروقات الأسعار مع سرعة الإغلاق والتوثيق.',
      descEn:
          'Dispatches safety officers for leak emergencies, late delivery tickets, and tariff audits with full SLA tracking.',
      connections: [
        SimulatorConnection(targetStep: 13, labelAr: 'سجل الإشعارات', labelEn: 'Notifications Log'),
        SimulatorConnection(targetStep: 15, labelAr: 'بدء إغلاق ورديات نهاية اليوم', labelEn: 'Start End-of-Day Shift Close'),
      ],
      nextActionAr: 'الانتقال إلى تسوية وإغلاق الوردية',
      nextActionEn: 'Proceed to Shift Settlement',
      routeName: AppRoutes.complaints,
    ),

    // STAGE 6: Settlement, Reconciliation & Admin
    SimulatorScreenItem(
      id: 'screen_15',
      stage: 6,
      stepNo: 15,
      titleAr: 'تسوية عهدة السائق النقدية وإغلاق الوردية (تفاعلية)',
      titleEn: 'Driver Cash Float Settlement & Shift Close',
      categoryAr: 'التقفيل المالي والإغلاق',
      categoryEn: 'Reconciliation & Admin',
      roleAr: 'أمين الصندوق / المدير',
      roleEn: 'Cashier / Agency Manager',
      icon: '💵',
      descAr:
          'مطابقة فئات النقد الورقي والمعدني، موازنة الأسطوانات المرجعة، والاعتماد الرقمي المزدوج.',
      descEn:
          'Denomination cash reconciliation, returned empty cylinder tallying, and dual digital sign-off authorization.',
      connections: [
        SimulatorConnection(targetStep: 16, labelAr: 'كشف الحساب المالي المفصل', labelEn: 'Financial Ledger & Dues'),
        SimulatorConnection(targetStep: 4, labelAr: 'تحديث جرد المستودع النهائي', labelEn: 'Update Final Warehouse Stock'),
      ],
      nextActionAr: 'ترحيل الصندوق إلى كشف الحساب المالي',
      nextActionEn: 'Post to Financial Statement Ledger',
      routeName: AppRoutes.fleet,
    ),
    SimulatorScreenItem(
      id: 'screen_16',
      stage: 6,
      stepNo: 16,
      titleAr: 'كشف الحساب المالي المفصل والذمم',
      titleEn: 'Detailed Financial Ledger & Receivables',
      categoryAr: 'التقفيل المالي والإغلاق',
      categoryEn: 'Reconciliation & Admin',
      roleAr: 'مالك الوكالة / المحاسب',
      roleEn: 'Agency Owner / Accountant',
      icon: '📈',
      descAr:
          'حركة الصندوق اليومي، تحصيلات كليك (CliQ)، فواتير مصفاة الزرقاء، وذمم المنشآت والمطاعم الآجلة.',
      descEn:
          'Daily cash register, CliQ electronic collections, Zarqa refinery settlement invoices, and commercial receivables.',
      connections: [
        SimulatorConnection(targetStep: 17, labelAr: 'التقارير والتحليلات التشغيلية', labelEn: 'Operational Reports & Analytics'),
        SimulatorConnection(targetStep: 15, labelAr: 'سندات تسوية السائقين', labelEn: 'Driver Settlement Vouchers'),
      ],
      nextActionAr: 'فتح التقارير والتحليلات البيانية',
      nextActionEn: 'Open Reports & Performance Analytics',
      routeName: AppRoutes.reports,
    ),
    SimulatorScreenItem(
      id: 'screen_17',
      stage: 6,
      stepNo: 17,
      titleAr: 'التقارير والتحليلات التشغيلية (تفاعلية)',
      titleEn: 'Operational Reports & Analytics (Interactive)',
      categoryAr: 'التقفيل المالي والإغلاق',
      categoryEn: 'Reconciliation & Admin',
      roleAr: 'مالك الوكالة',
      roleEn: 'Agency Owner',
      icon: '📉',
      descAr:
          'مؤشرات نمو المبيعات، توزيع الطلب حسب المناطق، ومعدلات الأداء الشهرية وتحليلات الأسطول.',
      descEn:
          'Sales volume trajectory, geographic neighborhood demand density, monthly growth rates, and fleet KPIs.',
      connections: [
        SimulatorConnection(targetStep: 18, labelAr: 'إدارة صلاحيات مستخدمي الوكالة', labelEn: 'Agency Staff Permissions'),
        SimulatorConnection(targetStep: 6, labelAr: 'العودة للوحة التحكم', labelEn: 'Back to Dashboard'),
      ],
      nextActionAr: 'مراجعة صلاحيات فريق عمل الوكالة',
      nextActionEn: 'Review Agency Staff Permissions',
      routeName: AppRoutes.reports,
    ),
    SimulatorScreenItem(
      id: 'screen_18',
      stage: 6,
      stepNo: 18,
      titleAr: 'إدارة مستخدمي الوكالة والأدوار',
      titleEn: 'Agency Staff Roles & Access Control',
      categoryAr: 'التقفيل المالي والإغلاق',
      categoryEn: 'Reconciliation & Admin',
      roleAr: 'مالك الوكالة (Owner)',
      roleEn: 'Agency Owner',
      icon: '🛡️',
      descAr:
          'هيكل صلاحيات الوكالة: المالك، المدير، مسؤول الإسناد، وأمين المستودع، مع سجل التدقيق المشفر (Audit Log).',
      descEn:
          'Agency role-based access control: Owner, Manager, Dispatcher, Storekeeper, with encrypted security audit logs.',
      connections: [
        SimulatorConnection(targetStep: 19, labelAr: 'إعدادات الوكالة والتغطية', labelEn: 'Agency Settings & Coverage'),
        SimulatorConnection(targetStep: 6, labelAr: 'العودة للرئيسية', labelEn: 'Return to Main Dashboard'),
      ],
      nextActionAr: 'الانتقال إلى إعدادات الوكالة',
      nextActionEn: 'Proceed to Agency Settings',
      routeName: AppRoutes.staff,
    ),
    SimulatorScreenItem(
      id: 'screen_19',
      stage: 6,
      stepNo: 19,
      titleAr: 'إعدادات الوكالة والصلاحيات (تفاعلية)',
      titleEn: 'Agency Settings & Regional Coverage (Interactive)',
      categoryAr: 'التقفيل المالي والإغلاق',
      categoryEn: 'Reconciliation & Admin',
      roleAr: 'مالك الوكالة',
      roleEn: 'Agency Owner',
      icon: '⚙️',
      descAr:
          'ضبط نطاقات التغطية الجغرافية، أوقات العمل، تسعيرة الملحقات المعتمدة، وتسجيل الخروج الآمن.',
      descEn:
          'Configure West Amman geographic zones, working shifts, ministry accessory tariffs, and secure session logout.',
      connections: [
        SimulatorConnection(targetStep: 1, labelAr: 'تسجيل الخروج الآمن', labelEn: 'Secure Session Logout'),
        SimulatorConnection(targetStep: 6, labelAr: 'العودة للوحة الرئيسية', labelEn: 'Return to Home Dashboard'),
      ],
      nextActionAr: 'إنهاء الجولة والعودة للبداية',
      nextActionEn: 'Finish Walkthrough and Return to Start',
      routeName: AppRoutes.settings,
    ),
  ];

  void _switchStage(int stageNum) {
    final targetIndex = _screens.indexWhere((s) => s.stage == stageNum);
    if (targetIndex != -1) {
      setState(() => _currentStepIndex = targetIndex);
    }
  }

  void _jumpToStep(int stepNo) {
    final targetIndex = _screens.indexWhere((s) => s.stepNo == stepNo);
    if (targetIndex != -1) {
      setState(() => _currentStepIndex = targetIndex);
    }
  }

  void _nextScreen() {
    if (_currentStepIndex < _screens.length - 1) {
      setState(() => _currentStepIndex++);
    } else {
      setState(() => _currentStepIndex = 0);
    }
  }

  void _prevScreen() {
    if (_currentStepIndex > 0) {
      setState(() => _currentStepIndex--);
    }
  }

  void _resetFlow() {
    setState(() => _currentStepIndex = 0);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = _screens[_currentStepIndex];
    final isAr = AppStrings.isArabic;

    return Directionality(
      textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FF),
        appBar: widget.showAppBar ? _buildAppBar() : null,
        body: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Prototype Progress HUD
              _buildProgressHud(screen),
              const SizedBox(height: 14),

              // 2. Phase Selector Horizontal Rail
              _buildPhaseSelector(screen.stage),
              const SizedBox(height: 14),

              // 3. Active Screen Spotlight Card
              _buildActiveSpotlightCard(screen),
              const SizedBox(height: 16),

              // 4. Complete Sequence Workflow List
              _buildWorkflowList(),
              const SizedBox(height: 16),

              // 5. System Interconnectivity Info Card
              _buildArchitectureInfoCard(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      toolbarHeight: 64,
      leading: Navigator.of(context).canPop()
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF006194)),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF006194).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.hub_outlined, color: Color(0xFF006194), size: 22),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.simulator,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B1C30),
                  ),
                ),
                Text(
                  AppStrings.agencyName,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    color: Color(0xFF006194),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          tooltip: AppStrings.reset,
          icon: const Icon(Icons.restart_alt, color: Color(0xFF565E74)),
          onPressed: _resetFlow,
        ),
      ],
    );
  }

  Widget _buildProgressHud(SimulatorScreenItem screen) {
    final progress = (_currentStepIndex + 1) / _screens.length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0284C7).withValues(alpha: 0.2),
                      border: Border.all(color: const Color(0xFF0284C7).withValues(alpha: 0.4)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      AppStrings.isArabic
                          ? 'المرحلة الحالية المحددة'
                          : 'CURRENT SELECTED PHASE',
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF38BDF8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${AppStrings.isArabic ? "المرحلة" : "Stage"} ${screen.stage}: ${screen.category}',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        screen.stepNo.toString().padLeft(2, '0'),
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF38BDF8),
                        ),
                      ),
                      const Text(
                        ' / 19',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    AppStrings.isArabic ? 'شاشة تشغيلية' : 'Flow Screens',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 10,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Animated Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: progress),
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              builder: (context, val, _) {
                return LinearProgressIndicator(
                  value: val,
                  backgroundColor: const Color(0xFF334155),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0EA5E9)),
                  minHeight: 8,
                );
              },
            ),
          ),
          const SizedBox(height: 14),

          // Controls & Role Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton.icon(
                onPressed: _currentStepIndex > 0 ? _prevScreen : null,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                icon: const Icon(Icons.chevron_right, size: 18),
                label: Text(
                  AppStrings.previous,
                  style: const TextStyle(fontFamily: 'Cairo', fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  border: Border.all(color: const Color(0xFF475569)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  screen.role,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFCBD5E1),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _nextScreen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0284C7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                icon: Text(
                  AppStrings.next,
                  style: const TextStyle(fontFamily: 'Cairo', fontSize: 11, fontWeight: FontWeight.bold),
                ),
                label: const Icon(Icons.chevron_left, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhaseSelector(int activeStage) {
    final stages = [
      {'stage': 1, 'icon': '🔐', 'ar': '1. الدخول والأمان', 'en': '1. Auth & Security'},
      {'stage': 2, 'icon': '🏭', 'ar': '2. جاهزية المستودع', 'en': '2. Warehouse'},
      {'stage': 3, 'icon': '📊', 'ar': '3. الإسناد والطلبات', 'en': '3. Dispatch'},
      {'stage': 4, 'icon': '🚚', 'ar': '4. التوزيع والتتبع', 'en': '4. Live Field'},
      {'stage': 5, 'icon': '🚨', 'ar': '5. الطوارئ والرقابة', 'en': '5. Safety & SLA'},
      {'stage': 6, 'icon': '💰', 'ar': '6. التقفيل المالي', 'en': '6. Closing'},
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: stages.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final s = stages[index];
          final stageNum = s['stage'] as int;
          final isSelected = stageNum == activeStage;
          final title = AppStrings.isArabic ? s['ar'] as String : s['en'] as String;

          return InkWell(
            onTap: () => _switchStage(stageNum),
            borderRadius: BorderRadius.circular(12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF0284C7) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? const Color(0xFF0284C7) : const Color(0xFFE2E8F0),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF0284C7).withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )
                      ]
                    : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(s['icon'] as String, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      color: isSelected ? Colors.white : const Color(0xFF334155),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActiveSpotlightCard(SimulatorScreenItem screen) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Spotlight Meta Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F2FE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(screen.icon, style: const TextStyle(fontSize: 20)),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppStrings.isArabic ? "الشاشة رقم" : "Screen #"} ${screen.stepNo} ${AppStrings.isArabic ? "من" : "of"} 19',
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0284C7),
                          ),
                        ),
                        Text(
                          screen.title,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFA7F3D0)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF10B981),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        AppStrings.readyToTry,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF047857),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Content Description
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  screen.desc,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    height: 1.6,
                    color: Color(0xFF475569),
                  ),
                ),
                const SizedBox(height: 14),

                // Interactive Hotspot Jump Connectors
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.isArabic
                                ? 'إجراءات الانتقال التفاعلية المباشرة (Hotspots):'
                                : 'Direct Interactive Hotspots:',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          Text(
                            AppStrings.isArabic ? 'اضغط للتنقل' : 'Tap to Jump',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0284C7),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ...screen.connections.map((conn) {
                            final target = _screens.firstWhere((s) => s.stepNo == conn.targetStep);
                            return ActionChip(
                              avatar: Text(target.icon, style: const TextStyle(fontSize: 13)),
                              label: Text(
                                conn.label,
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0369A1),
                                ),
                              ),
                              backgroundColor: Colors.white,
                              side: const BorderSide(color: Color(0xFFBAE6FD)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              onPressed: () => _jumpToStep(conn.targetStep),
                            );
                          }),
                          if (screen.routeName != null)
                            ActionChip(
                              avatar: const Icon(Icons.open_in_new, size: 14, color: Color(0xFF059669)),
                              label: Text(
                                AppStrings.launchLiveScreen,
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF047857),
                                ),
                              ),
                              backgroundColor: const Color(0xFFECFDF5),
                              side: const BorderSide(color: Color(0xFFA7F3D0)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              onPressed: () {
                                Navigator.of(context).pushNamed(screen.routeName!);
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Primary Next Step Button
                ElevatedButton(
                  onPressed: _nextScreen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0284C7),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 1,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        screen.nextAction,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_back, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  AppStrings.isArabic
                      ? '🗺️ قائمة شاشات المسار التشغيلي الكامل (19 شاشة)'
                      : '🗺️ Full Operational Sequence Map (19 Screens)',
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                AppStrings.isArabic ? 'مرتبة حسب العمليات' : 'Ordered by Workflow',
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 11,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _screens.length,
            separatorBuilder: (_, _) => const SizedBox(height: 6),
            itemBuilder: (context, idx) {
              final s = _screens[idx];
              final isActive = idx == _currentStepIndex;

              return InkWell(
                onTap: () => setState(() => _currentStepIndex = idx),
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFFEFF6FF) : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isActive ? const Color(0xFF0284C7) : const Color(0xFFE2E8F0),
                      width: isActive ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isActive ? const Color(0xFF0284C7) : const Color(0xFFCBD5E1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          s.stepNo.toString().padLeft(2, '0'),
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(s.icon, style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              s.title,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12,
                                fontWeight: isActive ? FontWeight.w900 : FontWeight.bold,
                                color: isActive ? const Color(0xFF0369A1) : const Color(0xFF1E293B),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${s.category} • ${s.role}',
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 10,
                                color: Color(0xFF64748B),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (isActive)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0284C7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            AppStrings.active,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )
                      else
                        const Icon(Icons.chevron_left, size: 16, color: Color(0xFF94A3B8)),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildArchitectureInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFBAE6FD)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.verified, color: Color(0xFF0284C7), size: 20),
              const SizedBox(width: 8),
              Text(
                AppStrings.isArabic
                    ? 'الترابط مع الشاشات السابقة وتأكيد التفاعل'
                    : 'End-to-End Operational Lifecycle Verification',
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0C4A6E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            AppStrings.isArabic
                ? 'يربط هذا النموذج التفاعلي كافة شاشات المنظومة الـ 19 التي تم توليدها مسبقاً. تمكنك أزرار الإجراءات السريعة في الأعلى من اختبار تدفق التوصيل اليومي كاملاً بدءاً من ورود شحنات المصفاة، وإسناد الشاحنات، وحتى مطابقة الفئات النقدية وإغلاق الوردية.'
                : 'This interactive prototype simulator connects all 19 views of the gas distribution portal. Test the complete daily lifecycle from refinery deliveries and automated dispatch to driver cash reconciliation and daily closure.',
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 11,
              height: 1.6,
              color: Color(0xFF0369A1),
            ),
          ),
        ],
      ),
    );
  }
}
