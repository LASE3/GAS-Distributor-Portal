import 'package:flutter/material.dart';

/// Global helper function to get translated text based on current language.
String tr(String ar, String en) =>
    LocaleNotifier.instance.isArabic ? ar : en;

class LocaleNotifier extends ValueNotifier<Locale> {
  LocaleNotifier._() : super(const Locale('en'));

  static final LocaleNotifier instance = LocaleNotifier._();

  bool get isArabic => value.languageCode == 'ar';
  bool get isEnglish => value.languageCode == 'en';

  void toggleLocale() {
    value = isArabic ? const Locale('en') : const Locale('ar');
  }

  void setLocale(Locale newLocale) {
    if (value != newLocale) {
      value = newLocale;
    }
  }
}

class AppStrings {
  AppStrings._();

  static bool get isArabic => LocaleNotifier.instance.isArabic;

  // App & Identity
  static String get appTitle =>
      isArabic ? 'بوابة موزع الغاز - إدارة العمليات الميدانية' : 'Gas Distributor Portal - Field Operations Management';

  static String get agencyName =>
      isArabic ? 'وكالة النور لتوزيع الغاز - عمان الغربية' : 'Al-Noor Gas Agency - West Amman';

  static String get agencySubhead =>
      isArabic ? 'النظام متصل بالمصفاة - مباشر' : 'Connected to Jordan Petroleum Refinery - Live';

  static String get portalBadge =>
      isArabic ? 'بوابة الموزع' : 'Distributor Portal';

  // Master Navigation Titles
  static String get dashboard => isArabic ? 'الرئيسية' : 'Home';
  static String get dashboardFull => isArabic ? 'لوحة التحكم التشغيلية' : 'Operational Dashboard';
  static String get orders => isArabic ? 'الطلبات' : 'Orders';
  static String get ordersFull => isArabic ? 'إدارة وتوزيع الطلبات' : 'Orders & Dispatch';
  static String get fleet => isArabic ? 'الأسطول' : 'Fleet';
  static String get fleetFull => isArabic ? 'أسطول التوزيع والسائقين' : 'Fleet & Drivers';
  static String get inventory => isArabic ? 'المخزون' : 'Inventory';
  static String get inventoryFull => isArabic ? 'المخزون والأسطوانات' : 'Inventory & Cylinders';
  static String get customers => isArabic ? 'المشتركون' : 'Customers';
  static String get customersFull => isArabic ? 'حسابات المشتركين' : 'Customer Accounts';
  static String get staff => isArabic ? 'فريق العمل' : 'Staff';
  static String get staffFull => isArabic ? 'فريق العمل والصلاحيات' : 'Staff & Permissions';
  static String get complaints => isArabic ? 'الشكاوى' : 'Support';
  static String get complaintsFull => isArabic ? 'الشكاوى والدعم الفني' : 'Complaints & Support';
  static String get reports => isArabic ? 'التقارير' : 'Reports';
  static String get reportsFull => isArabic ? 'التقارير والإحصاءات' : 'Operational Reports';
  static String get notifications => isArabic ? 'التنبيهات' : 'Alerts';
  static String get notificationsFull => isArabic ? 'مركز التنبيهات الميدانية' : 'Notifications Center';
  static String get settings => isArabic ? 'الإعدادات' : 'Settings';
  static String get settingsFull => isArabic ? 'إعدادات الوكالة' : 'Agency Settings';
  static String get more => isArabic ? 'المزيد' : 'More';
  static String get simulator => isArabic ? 'محاكي المسار التشغيلي' : 'Workflow Simulator';
  static String get simulatorFull => isArabic ? 'النموذج التفاعلي الشامل وخريطة المسار' : 'Interactive Prototype & Flow Map';

  // Common Actions & Statuses
  static String get liveMap => isArabic ? 'الخريطة المباشرة' : 'Live Map';
  static String get liveMapFull => isArabic ? 'خريطة التوزيع الميداني المباشر' : 'Live Field Distribution Map';
  static String get interactiveDashboard => isArabic ? 'لوحة تفاعلية حية' : 'Interactive Dashboard';
  static String get logout => isArabic ? 'تسجيل الخروج' : 'Logout';
  static String get switchLanguage => isArabic ? 'English' : 'العربية';
  static String get search => isArabic ? 'بحث...' : 'Search...';
  static String get reset => isArabic ? 'إعادة تعيين' : 'Reset';
  static String get next => isArabic ? 'التالية' : 'Next';
  static String get previous => isArabic ? 'السابقة' : 'Previous';
  static String get active => isArabic ? 'نشط' : 'Active';
  static String get urgent => isArabic ? 'عاجل' : 'Urgent';
  static String get pending => isArabic ? 'معلق' : 'Pending';
  static String get completed => isArabic ? 'مكتمل' : 'Completed';
  static String get cancelled => isArabic ? 'ملغي' : 'Cancelled';
  static String get newBadge => isArabic ? 'جديد' : 'New';
  static String get readyToTry => isArabic ? 'جاهزة للتجربة' : 'Ready to Test';
  static String get launchLiveScreen => isArabic ? 'فتح الشاشة الحية' : 'Open Live Screen';
  static String get currencyJD => isArabic ? 'د.أ' : 'JOD';
  static String get cylinder => isArabic ? 'أسطوانة' : 'Cylinder';
  static String get driver => isArabic ? 'سائق' : 'Driver';
  static String get truck => isArabic ? 'شاحنة' : 'Truck';
}
