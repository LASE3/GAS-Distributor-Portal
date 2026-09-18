import 'package:flutter/material.dart';
import '../../core/localization/app_locale.dart';

class AgencySettingsView extends StatefulWidget {
  final bool showAppBar;
  const AgencySettingsView({super.key, this.showAppBar = true});

  @override
  State<AgencySettingsView> createState() => _AgencySettingsViewState();
}

class _AgencySettingsViewState extends State<AgencySettingsView> {
  bool _khildaZone = true;
  bool _tlaaZone = true;
  bool _dabouqZone = true;
  bool _jubaihaZone = true;
  bool _sweilehZone = false;

  bool _instantAlerts = true;
  bool _shortageAlerts = true;

  bool _showToast = false;
  String _toastMessage = 'تم حفظ التعديلات بنجاح';

  void _triggerToast(String message) {
    setState(() {
      _toastMessage = message;
      _showToast = true;
    });
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(() {
          _showToast = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAr = LocaleNotifier.instance.isArabic;
    return Directionality(
      textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FF),
        appBar: widget.showAppBar
            ? PreferredSize(
                preferredSize: const Size.fromHeight(64),
                child: AppBar(
                  backgroundColor: const Color(0xFFF8F9FF).withValues(alpha: 0.95),
                  elevation: 0,
                  flexibleSpace: ClipRect(
                    child: Container(color: const Color(0xFFF8F9FF).withValues(alpha: 0.95)),
                  ),
                  leading: Navigator.of(context).canPop()
                      ? IconButton(
                          icon: const Icon(Icons.arrow_back, color: Color(0xFF006194)),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      : null,
                  title: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFF006194).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.local_gas_station,
                          color: Color(0xFF006194),
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                tr('إعدادات الوكالة', 'Agency Settings'),
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0B1C30),
                                ),
                              ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFCCE5FF),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              width: 6,
                              height: 6,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Color(0xFF006194),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              tr('بوابة الموزع', 'Distributor Portal'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF001D31),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    tr('وكالة النور لتوزيع الغاز - عمان الغربية', 'Al-Noor Gas Agency - West Amman'),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3F4850),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFF3F4850),
                  ),
                  onPressed: () {},
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Color(0xFFBA1A1A),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '4',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 4),
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFF006194),
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida/AEtjO1XLSIDp383cBt8pf3mxYU2WcxmgFxoq6ZKYjK7ekv8tN18cZdasWehCSK9cF1z42kd-DPZvmfkp_TcVpMdCdzHZVm0WQLUZt7dBDe9EXOpzxvp46kOPFfhTLJzfVnhmiDKOWqOcYEnrDJ8ADSyBlnpL6jQAqvf5lNNPekMnsoGBCBNe48b2TDD6hcKkTD3FdJN4KG2YCIo9WAwa3SECKjp2Q60aNm3NhpyVUuO9jKmkhW0tClhxIM8W9Ik',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
          : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Agency Profile Hero Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF006194).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.admin_panel_settings,
                                  color: Color(0xFF006194),
                                  size: 32,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tr('وكالة النور لتوزيع الغاز المحروقات', 'Al-Noor Gas & Fuel Agency'),
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0B1C30),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    tr(
                                      'وكالة معتمدة رسمياً لدى نقابة أصحاب المحروقات وغاز الأردن',
                                      'Officially certified by Fuel Syndicate & Jordan Gas',
                                    ),
                                    style: const TextStyle(
                                      fontFamily: 'Tajawal',
                                      fontSize: 11,
                                      color: Color(0xFF3F4850),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                            IconButton(
                              onPressed: () => _triggerToast(
                                tr('جاري تحرير البيانات الرسمية للوكالة...', 'Editing official agency profile...'),
                              ),
                              icon: const Icon(
                                Icons.edit,
                                color: Color(0xFF3F4850),
                                size: 20,
                              ),
                              style: IconButton.styleFrom(
                                backgroundColor: const Color(0xFFEFF4FF),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF4FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 8,
                                height: 8,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF006948),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                tr('نظام التوزيع نشط ومربوط بـ GPS', 'Distribution system active & GPS synced'),
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF006948),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                tr('آخر مزامنة: منذ دقيقتين', 'Last sync: 2 mins ago'),
                                style: const TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontSize: 11,
                                  color: Color(0xFF3F4850),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.warehouse,
                              size: 18,
                              color: Color(0xFF006194),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              tr('المستودع المركزي - شارع وصفي التل، خلدا، عمان', 'Central Depot - Wasfi Al-Tal St, Khilda, Amman'),
                              style: const TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 12,
                                color: Color(0xFF3F4850),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: const [
                            Icon(
                              Icons.call,
                              size: 18,
                              color: Color(0xFF006194),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '06-5544321 / 079-0001122',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12,
                                color: Color(0xFF3F4850),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Operational Coverage Settings
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.map,
                                  color: Color(0xFF006194),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  tr('مناطق التغطية التشغيلية', 'Operational Coverage Zones'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0B1C30),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF4FF),
                                borderRadius: BorderRadius.circular(9999),
                              ),
                              child: Text(
                                tr('4 مفعّلة', '4 Active'),
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF006194),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF4FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tr('ساعات العمل والخدمة:', 'Working & Service Hours:'),
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12,
                                  color: Color(0xFF3F4850),
                                ),
                              ),
                              Text(
                                tr('من 07:00 صباحاً حتى 10:00 مساءً', '07:00 AM to 10:00 PM'),
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF006194),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildCoverageToggle(
                          tr('منطقة خلدا (القطاع المركزي)', 'Khilda Zone (Central Sector)'),
                          tr('نشط - تغطية بمعدل شاحنتين بالخدمة', 'Active - 2 trucks on duty'),
                          _khildaZone,
                          (v) {
                            setState(() => _khildaZone = v);
                            _triggerToast(tr('تم تحديث حالة منطقة خلدا', 'Khilda zone updated'));
                          },
                        ),
                        const SizedBox(height: 8),
                        _buildCoverageToggle(
                          tr('تلاع العلي وسوق السلطان', 'Tlaa Al-Ali & Sultan Market'),
                          tr('نشط - طلبات التوصيل السريع', 'Active - Express delivery orders'),
                          _tlaaZone,
                          (v) {
                            setState(() => _tlaaZone = v);
                            _triggerToast(tr('تم تحديث حالة منطقة تلاع العلي', 'Tlaa Al-Ali zone updated'));
                          },
                        ),
                        const SizedBox(height: 8),
                        _buildCoverageToggle(
                          tr('دابوق والحمر', 'Dabouq & Al-Hummar'),
                          tr('نشط - أسطوانات منزلية وتجارية', 'Active - Domestic & commercial'),
                          _dabouqZone,
                          (v) {
                            setState(() => _dabouqZone = v);
                            _triggerToast(tr('تم تحديث حالة منطقة دابوق', 'Dabouq zone updated'));
                          },
                        ),
                        const SizedBox(height: 8),
                        _buildCoverageToggle(
                          tr('الجبيهة والجامعة الأردنية', 'Jubaiha & Jordan University'),
                          tr('نشط - تغطية مسار التوزيع الشمالي', 'Active - Northern route coverage'),
                          _jubaihaZone,
                          (v) {
                            setState(() => _jubaihaZone = v);
                            _triggerToast(tr('تم تحديث حالة منطقة الجبيهة', 'Jubaiha zone updated'));
                          },
                        ),
                        const SizedBox(height: 8),
                        _buildCoverageToggle(
                          tr('صويلح ومثلث الدوريات', 'Sweileh & Patrols Intersection'),
                          tr('مغلق مؤقتاً لصيانة شاحنة التوزيع رقم 4', 'Temporarily closed for maintenance on Truck #4'),
                          _sweilehZone,
                          (v) {
                            setState(() => _sweilehZone = v);
                            _triggerToast(tr('تم تحديث حالة منطقة صويلح', 'Sweileh zone updated'));
                          },
                          isError: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Agency Team & User Roles Management
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.badge,
                                  color: Color(0xFF006194),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  tr('فريق عمل الوكالة والصلاحيات', 'Agency Team & Roles'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0B1C30),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              tr('3 مستخدمين', '3 Users'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 11,
                                color: Color(0xFF3F4850),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildTeamMember(
                          tr('الحاج منير النور', 'Haj Muneer Al-Noor'),
                          tr('مالك الوكالة • كامل الصلاحيات والتحكم الإداري', 'Agency Owner • Full administrative privileges'),
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuACTBivktV14KbnofY6w006VAnliyGEoJAQMWAOcdRgc_ZgkQunegvUxf2UIA5Eri5oBTflktXx7UV2dpN3SGrbgQFk4A49EXo5qS-MmUbq0SgnETBwfBFMSNiDAYiYKctf18PIEQ24Q3AQP-2P7MHxaYgLsD_V8AUABoBFJvHTwTPK0yC6DMmcISD7RV3EryM_pcfvYuEhhcy-SIJc2duBykKtRAAv9IATpvaolxcqQ3223enPrc_D',
                          const Color(0xFF006948),
                        ),
                        const SizedBox(height: 8),
                        _buildTeamMember(
                          tr('فراس عبد الجليل', 'Firas Abdul-Jalil'),
                          tr('موزع حركة • إدارة الطلبات وتوجيه أسطول السائقين', 'Dispatcher • Orders & fleet routing'),
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuB948a4P5TgsSgRkq73p1zKwFx4W7fdxEBmt53IjF2VaA3DOevreGqbGZ_xBJqRl4giyGSCECNqqCkAnPdYZ4P9zPXujhtmT6-_UOPs096UTspVXdrRAEgyyaISaECKKjNRdNR72BCDg62kccluvmomoH7BF3VYzfGsFD1SKVSpxQZ1q3SkgtHF0bKX-3pkeWy9yynR6-R4U0kfElwveb5_VxSgF6xTt1HOu7EN0BahrWtsoBSu91fF',
                          const Color(0xFF006948),
                        ),
                        const SizedBox(height: 8),
                        _buildTeamMember(
                          tr('خالد العمري', 'Khaled Al-Omari'),
                          tr('أمين مستودع • إدارة التوريد وفحص الأسطوانات', 'Storekeeper • Supply handling & cylinder checks'),
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuA52zdkQ8UkD5SlNjdSM-6BEYpZOBXhPWGSaD4_0lsW0gxk2ZN5U0TE0VgqpItlz893ZQzFJMHTvBtrsVIv-y7xbLJfuMluuxiYiLzskRFFNdJn03--M6DWK9G3x9uxoU8i_y6rTH05uD3HSOUPa7Wk0cvTuYIwnP8_Ewme3CIKrINfACScIsQk-vFgXBE2qyIBeMzPbopBkyayfCQEiX83mT4ooPgRyO62aMCD8DPgl4DQFu_aewXt',
                          const Color(0xFF565E74),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: () => _triggerToast(
                            tr('فتح نموذج إضافة وتعيين صلاحيات موظف جديد', 'Opening new employee registration form'),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: const Color(0xFFEFF4FF),
                            foregroundColor: const Color(0xFF006194),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(Icons.person_add, size: 18),
                          label: Text(
                            tr('إضافة موظف جديد بالوكالة', 'Add New Agency Staff Member'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Security & System Preferences Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.tune,
                              color: Color(0xFF006194),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              tr('إعدادات الأمان وتفضيلات النظام', 'Security & System Preferences'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B1C30),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildPreferenceToggle(
                          tr('إشعارات الطلبات الفورية', 'Instant Order Notifications'),
                          tr('تنبيه صوتي عالي النبرة عند ورود طلب جديد بالمستودع', 'Audible alert when new order is received'),
                          _instantAlerts,
                          (v) {
                            setState(() => _instantAlerts = v);
                            _triggerToast(tr('تم تحديث إعداد "إشعارات الطلبات"', 'Order alerts updated'));
                          },
                        ),
                        const SizedBox(height: 8),
                        _buildPreferenceToggle(
                          tr('تنبيه حرج لنقص الأسطوانات', 'Critical Cylinder Shortage Alert'),
                          tr('إرسال SMS للمدير عند انخفاض المخزون عن 15 أسطوانة', 'Send SMS alert when stock is under 15 cylinders'),
                          _shortageAlerts,
                          (v) {
                            setState(() => _shortageAlerts = v);
                            _triggerToast(tr('تم تحديث إعداد "تنبيه المخزون"', 'Stock shortage alert updated'));
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Logout Action Module
                  ElevatedButton.icon(
                    onPressed: () =>
                        _triggerToast(tr('جاري إنهاء الجلسة وحفظ السجلات...', 'Ending session and saving logs...')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFDAD6),
                      foregroundColor: const Color(0xFFBA1A1A),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.logout, size: 20),
                    label: Text(
                      tr('تسجيل الخروج من البوابة التشغيلية', 'Logout from Operational Portal'),
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Toast Notification
            if (_showToast)
              Positioned(
                top: 80,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF213145),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 8),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xFF85F8C4),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _toastMessage,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverageToggle(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged, {
    bool isError = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B1C30),
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 11,
                  color: isError
                      ? const Color(0xFFBA1A1A)
                      : const Color(0xFF006948),
                ),
              ),
            ],
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: const Color(0xFF006194),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember(
    String name,
    String role,
    String imageUrl,
    Color statusColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      imageUrl,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B1C30),
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: Text(
                      role,
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 10,
                        color: Color(0xFF3F4850),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              size: 18,
              color: Color(0xFF3F4850),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceToggle(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B1C30),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 11,
                    color: Color(0xFF3F4850),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: const Color(0xFF006194),
          ),
        ],
      ),
    );
  }
}
