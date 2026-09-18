import 'package:flutter/material.dart';
import '../../core/localization/app_locale.dart';
import '../../core/routes/app_routes.dart';
import '../../core/widgets/portal_bottom_nav.dart';

class DashboardHomeView extends StatefulWidget {
  final bool showAppBar;
  const DashboardHomeView({super.key, this.showAppBar = true});

  @override
  State<DashboardHomeView> createState() => _DashboardHomeViewState();
}

class _DashboardHomeViewState extends State<DashboardHomeView> {
  bool _isDispatched = false;
  bool _isDispatchedVisible = true;
  bool _isRestocked = false;

  @override
  Widget build(BuildContext context) {
    final isAr = LocaleNotifier.instance.isArabic;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: widget.showAppBar
          ? PreferredSize(
              preferredSize: const Size.fromHeight(64),
              child: AppBar(
                backgroundColor: const Color(0xFFF8F9FF).withValues(alpha: 0.85),
                elevation: 0,
                flexibleSpace: ClipRect(
                  child: Container(color: const Color(0xFFF8F9FF).withValues(alpha: 0.85)),
                ),
                title: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.local_fire_department,
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
                              tr('لوحة التحكم الإدارية', 'Admin Dashboard'),
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
                                color: const Color(0xFF85F8C4),
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
                                        color: Color(0xFF006948),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    tr('مباشر', 'LIVE'),
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF002114),
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
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.notifications);
                        },
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
                              '3',
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
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFF006194),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            )
          : null,
      body: Directionality(
        textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Operational Status Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF006948),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  tr('حالة الوكالة: جاهزية تامة', 'Agency Status: Fully Operational'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF0B1C30),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5EEFF),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            tr('07:00 ص - 10:00 م', '07:00 AM - 10:00 PM'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF3F4850),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.near_me,
                                size: 16,
                                color: Color(0xFF006194),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  tr('قطاع عمان الغربية (خلدا، تلاع العلي، دابوق)', 'West Amman (Khalda, Tlaa Al-Ali, Dabouq)'),
                                  style: const TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF3F4850),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF85F8C4),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            tr('الضغط: معتدل', 'Load: Moderate'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF002114),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 2. Operational Dispatch Alert
              if (_isDispatchedVisible)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFDAD6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.priority_high,
                          color: Color(0xFF93000A),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tr('إسناد يدوي فوري', 'Immediate Manual Dispatch'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFBA1A1A),
                                  ),
                                ),
                                Text(
                                  tr('منذ 4 دقائق', '4m ago'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF3F4850),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              tr('حي الجامعة، تلاع العلي • أسطوانتين 12.5 كغ + ساعة ضغط', 'University District, Tlaa Al-Ali • 2x 12.5kg + Regulator'),
                              style: const TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 13,
                                color: Color(0xFF0B1C30),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        _isDispatched = true;
                                      });
                                      Future.delayed(
                                        const Duration(milliseconds: 700),
                                        () {
                                          if (mounted) {
                                            setState(() {
                                              _isDispatchedVisible = false;
                                            });
                                          }
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _isDispatched
                                          ? const Color(0xFF006948)
                                          : const Color(0xFF006194),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      elevation: 0,
                                    ),
                                    icon: Icon(
                                      _isDispatched ? Icons.check : Icons.bolt,
                                      size: 16,
                                    ),
                                    label: Text(
                                      _isDispatched
                                          ? tr('تم الإسناد بنجاح', 'Assigned Successfully')
                                          : tr('إسناد للسائق أحمد (1.2 كم)', 'Assign to Driver Ahmad (1.2 km)'),
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(AppRoutes.orderDetails);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: const Color(0xFFDCE9FF),
                                    side: BorderSide.none,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                  ),
                                  child: Text(
                                    tr('تفاصيل', 'Details'),
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF0B1C30),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              if (_isDispatchedVisible) const SizedBox(height: 16),

              // 3. Key Operational KPI Cards (2x2 Grid)
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.35,
                children: [
                  _buildKpiCard(
                    title: tr('الطلبات النشطة', 'Active Orders'),
                    icon: Icons.local_fire_department,
                    iconBg: const Color(0xFFCCE5FF),
                    iconColor: const Color(0xFF006194),
                    metric: '14',
                    unit: tr('طلب', 'orders'),
                    footer: tr('11 توصيل • 3 بالانتظار', '11 En Route • 3 Queued'),
                    footerColor: const Color(0xFF006194),
                  ),
                  _buildKpiCard(
                    title: tr('السائقون', 'Active Fleet'),
                    icon: Icons.electric_scooter,
                    iconBg: const Color(0xFF85F8C4),
                    iconColor: const Color(0xFF006948),
                    metric: '5/8',
                    unit: tr('متاحين', 'ready'),
                    footer: tr('3 في مسار التوصيل', '3 on delivery run'),
                    footerColor: const Color(0xFF3F4850),
                  ),
                  _buildKpiCard(
                    title: tr('المخزون الجاهز', 'Ready Cylinders'),
                    icon: Icons.propane_tank,
                    iconBg: const Color(0xFFDAE2FD),
                    iconColor: const Color(0xFF565E74),
                    metric: '142',
                    unit: tr('أسطوانة', 'cylinders'),
                    footer: tr('الحد التشغيلي آمن', 'Safe Operating Level'),
                    footerColor: const Color(0xFF006948),
                    hasCheck: true,
                  ),
                  _buildKpiCard(
                    title: tr('إنجاز اليوم', 'Today Accomplished'),
                    icon: Icons.payments,
                    iconBg: const Color(0xFFE5EEFF),
                    iconColor: const Color(0xFF3F4850),
                    metric: '68',
                    unit: tr('مكتمل', 'done'),
                    footerWidget: RichText(
                      text: TextSpan(
                        text: tr('التحصيل: ', 'Revenue: '),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 11,
                          color: Color(0xFF3F4850),
                        ),
                        children: [
                          TextSpan(
                            text: tr('612 د.أ', '612 JOD'),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0B1C30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 4. Interactive Radar Map Module
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
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
                            const Icon(
                              Icons.explore,
                              color: Color(0xFF006194),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              tr('رادار الأسطول الميداني', 'Field Fleet Radar'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0B1C30),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          tr('تحديث كل 5 ثوانٍ', 'Updates every 5s'),
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF3F4850),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 208,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCE9FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Depot Hub
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF213145),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.warehouse,
                                  color: Color(0xFFEAF1FF),
                                  size: 18,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF213145).withValues(alpha: 0.9),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  tr('مستودع خلدا', 'Khalda Depot'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.liveDriversMap);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDCE9FF),
                          foregroundColor: const Color(0xFF006194),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.map, size: 18),
                        label: Text(
                          tr('فتح خريطة التتبع الكاملة المباشرة', 'Open Full Live Tracking Map'),
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 5. Quick Driver Status Strip
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr('كفاءة الأسطول السريع', 'Quick Fleet Status'),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0B1C30),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes.fleet);
                        },
                        child: Text(
                          tr('عرض الكل (8)', 'View All (8)'),
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF006194),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 96,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildDriverCard(
                          isAr ? 'أ.ع' : 'A.A',
                          tr('أحمد العبادي', 'Ahmad Abbadi'),
                          tr('شاحنة #1 • خلدا', 'Truck #1 • Khalda'),
                          tr('متاح (12 أسطوانة)', 'Ready (12 Cyl.)'),
                          true,
                          '4.9',
                        ),
                        const SizedBox(width: 8),
                        _buildDriverCard(
                          isAr ? 'ع.ز' : 'O.Z',
                          tr('عمر الزعبي', 'Omar Zoubi'),
                          tr('شاحنة #2 • الجبيهة', 'Truck #2 • Jubeiha'),
                          tr('توصيل #2408', 'Delivering #2408'),
                          false,
                          '4.7',
                        ),
                        const SizedBox(width: 8),
                        _buildDriverCard(
                          isAr ? 'ط.م' : 'T.M',
                          tr('طارق المناصير', 'Tareq Manaseer'),
                          tr('شاحنة #3 • دابوق', 'Truck #3 • Dabouq'),
                          tr('متاح (8 أسطوانات)', 'Ready (8 Cyl.)'),
                          true,
                          '4.8',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 6. Critical Hardware Stock Warning Pill
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFDAD6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.warning_amber_rounded,
                            color: Color(0xFF93000A),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr('ساعات غاز إيطالي أصلية', 'Genuine Italian Gas Regulators'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              tr('متبقي 6 قطع فقط (الحد الأدنى 10)', 'Only 6 units left (Threshold: 10)'),
                              style: const TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFBA1A1A),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: _isRestocked
                          ? null
                          : () {
                              setState(() {
                                _isRestocked = true;
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isRestocked
                            ? const Color(0xFF85F8C4)
                            : const Color(0xFFDCE9FF),
                        foregroundColor: _isRestocked
                            ? const Color(0xFF002114)
                            : const Color(0xFF006194),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      child: Text(
                        _isRestocked ? tr('تم إرسال الطلب ✓', 'Request Sent ✓') : tr('طلب تزويد', 'Restock Request'),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: widget.showAppBar ? const PortalBottomNav(currentIndex: 0) : null,
    );
  }

  Widget _buildKpiCard({
    required String title,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String metric,
    required String unit,
    String? footer,
    Color? footerColor,
    bool hasCheck = false,
    Widget? footerWidget,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3F4850),
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 16),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                metric,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B1C30),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3F4850),
                ),
              ),
            ],
          ),
          footerWidget ??
              Row(
                children: [
                  if (hasCheck) ...[
                    const Icon(
                      Icons.check_circle,
                      size: 14,
                      color: Color(0xFF006948),
                    ),
                    const SizedBox(width: 4),
                  ] else ...[
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: footerColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                  Expanded(
                    child: Text(
                      footer ?? '',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: footerColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }

  Widget _buildDriverCard(
    String initials,
    String name,
    String subtitle,
    String statusText,
    bool isAvailable,
    String rating,
  ) {
    return Container(
      width: 210,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFE5EEFF),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  initials,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3F4850),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0B1C30),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 10,
                        color: Color(0xFF3F4850),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isAvailable
                        ? const Color(0xFF85F8C4)
                        : const Color(0xFFCCE5FF),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: isAvailable
                              ? const Color(0xFF006948)
                              : const Color(0xFF006194),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          statusText,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: isAvailable
                                ? const Color(0xFF002114)
                                : const Color(0xFF001D31),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    rating,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B1C30),
                    ),
                  ),
                  const Icon(Icons.star, size: 12, color: Color(0xFF565E74)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
