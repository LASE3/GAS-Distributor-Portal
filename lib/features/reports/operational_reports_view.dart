import 'package:flutter/material.dart';
import '../../core/localization/app_locale.dart';

class OperationalReportsView extends StatefulWidget {
  final bool showAppBar;
  const OperationalReportsView({super.key, this.showAppBar = true});

  @override
  State<OperationalReportsView> createState() => _OperationalReportsViewState();
}

class _OperationalReportsViewState extends State<OperationalReportsView> {
  String _selectedTimeframe = 'this_month';

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontFamily: 'Cairo')),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAr = LocaleNotifier.instance.isArabic;
    return Scaffold(
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
                        Icons.bar_chart,
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
                              tr('التقارير التشغيلية والإحصاءات', 'Operational Reports & Statistics'),
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
                          children: const [
                            SizedBox(
                              width: 6,
                              height: 6,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Color(0xFF006194),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'بوابة الموزع',
                              style: TextStyle(
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
                    AppStrings.agencyName,
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
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Header Banner & Timeframe Selector
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
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFF006194).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.query_stats,
                                color: Color(0xFF006194),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tr('التقارير والتحليلات التشغيلية', 'Operational Reports & Analytics'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0B1C30),
                                  ),
                                ),
                                Text(
                                  tr('ملخص أداء المبيعات والتوزيع للفترة الحالية', 'Sales & distribution summary for current period'),
                                  style: const TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontSize: 12,
                                    color: Color(0xFF3F4850),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () =>
                              _showSnackBar(tr('تم تحديث البيانات بنجاح', 'Data refreshed successfully')),
                          icon: const Icon(
                            Icons.sync,
                            color: Color(0xFF006194),
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xFFEFF4FF),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF4FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          _buildTimeframeButton('today', tr('اليوم', 'Today')),
                          _buildTimeframeButton('this_week', tr('هذا الأسبوع', 'This Week')),
                          _buildTimeframeButton('this_month', tr('هذا الشهر', 'This Month')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 2. Quick KPI Summary 2x2 Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.35,
                children: [
                  _buildKpiCard(
                    tr('المبيعات المحصلة', 'Collected Revenue'),
                    Icons.payments,
                    const Color(0xFF00855D).withOpacity(0.15),
                    const Color(0xFF00855D),
                    '4,820',
                    tr('د.أ', 'JOD'),
                    tr('+12% نمو شهري', '+12% monthly growth'),
                    const Color(0xFF006948),
                  ),
                  _buildKpiCard(
                    tr('الأسطوانات الموزعة', 'Cylinders Delivered'),
                    Icons.propane_tank,
                    const Color(0xFF006194).withOpacity(0.1),
                    const Color(0xFF006194),
                    '688',
                    tr('أسطوانة', 'cylinders'),
                    tr('حجم 12.5 كغ المنزلي', '12.5kg domestic'),
                    const Color(0xFF3F4850),
                  ),
                  _buildKpiCard(
                    tr('نسبة نجاح التوصيل', 'Delivery Success Rate'),
                    Icons.verified,
                    const Color(0xFF85F8C4).withOpacity(0.4),
                    const Color(0xFF002114),
                    '98.4%',
                    '',
                    tr('فشل 11 طلب فقط', 'Only 11 failed orders'),
                    const Color(0xFF3F4850),
                  ),
                  _buildKpiCard(
                    tr('متوسط زمن التوصيل', 'Avg. Delivery Time'),
                    Icons.timer,
                    const Color(0xFFDAE2FD),
                    const Color(0xFF565E74),
                    '15.8',
                    tr('دقيقة', 'mins'),
                    tr('أسرع بـ 3 دقائق', '3m faster'),
                    const Color(0xFF006948),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 3. Distribution by Neighborhood (Visual Bar Chart)
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
                            const Icon(Icons.map, color: Color(0xFF006194), size: 20),
                            const SizedBox(width: 8),
                            Text(
                              tr('الطلبات الموزعة حسب المناطق', 'Orders Distributed by Zone'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B1C30),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          tr('عمان الغربية', 'West Amman'),
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 11,
                            color: Color(0xFF3F4850),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(9999),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 35,
                              child: Container(
                                height: 12,
                                color: const Color(0xFF006194),
                              ),
                            ),
                            Expanded(
                              flex: 28,
                              child: Container(
                                height: 12,
                                color: const Color(0xFF007BB9),
                              ),
                            ),
                            Expanded(
                              flex: 22,
                              child: Container(
                                height: 12,
                                color: const Color(0xFF93CCFF),
                              ),
                            ),
                            Expanded(
                              flex: 15,
                              child: Container(
                                height: 12,
                                color: const Color(0xFFCBDBF5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildNeighborhoodRow(
                      tr('تلاع العلي', 'Tlaa Al-Ali'),
                      tr('240 طلب', '240 orders'),
                      '35%',
                      const Color(0xFF006194),
                    ),
                    const SizedBox(height: 8),
                    _buildNeighborhoodRow(
                      tr('خلدا', 'Khalda'),
                      tr('192 طلب', '192 orders'),
                      '28%',
                      const Color(0xFF007BB9),
                    ),
                    const SizedBox(height: 8),
                    _buildNeighborhoodRow(
                      tr('دابوق', 'Dabouq'),
                      tr('151 طلب', '151 orders'),
                      '22%',
                      const Color(0xFF93CCFF),
                    ),
                    const SizedBox(height: 8),
                    _buildNeighborhoodRow(
                      tr('الجبيهة وصويلح', 'Jubeiha & Sweileh'),
                      tr('105 طلب', '105 orders'),
                      '15%',
                      const Color(0xFF565E74),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 4. Gas Accessories & Safety Equipment Sales
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
                              Icons.health_and_safety,
                              color: Color(0xFF006948),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tr('مبيعات الملحقات وإكسسوارات الأمان', 'Accessories & Safety Equipment Sales'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0B1C30),
                                  ),
                                ),
                                Text(
                                  tr('إجمالي إيراد الإكسسوارات: 290 د.أ', 'Total Accessories Revenue: 290 JOD'),
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
                            tr('فحص أمان', 'Safety Checked'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF002114),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildAccessoryItem(
                      tr('ساعات غاز إيطالية أصلية', 'Italian Regulators'),
                      tr('تم تركيب 34 قطعة عبر السائقين', '34 installed by drivers'),
                      tr('170 د.أ', '170 JOD'),
                      tr('5 د.أ / وحدة', '5 JOD / unit'),
                      Icons.speed,
                    ),
                    const SizedBox(height: 8),
                    _buildAccessoryItem(
                      tr('برابيش غاز مقواة 2م', 'Reinforced 2m Hoses'),
                      tr('تم استبدال 52 قطعة منتهية الصلاحية', '52 expired replaced'),
                      tr('78 د.أ', '78 JOD'),
                      tr('1.5 د.أ / وحدة', '1.5 JOD / unit'),
                      Icons.cable,
                    ),
                    const SizedBox(height: 8),
                    _buildAccessoryItem(
                      tr('مرابط ومفاتيح أمان صلبة', 'Safety Clamps & Keys'),
                      tr('تم توزيع 28 مجموعة', '28 sets distributed'),
                      tr('42 د.أ', '42 JOD'),
                      tr('1.5 د.أ / طقم', '1.5 JOD / set'),
                      Icons.build,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 5. Driver Performance Leaderboard
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
                              Icons.military_tech,
                              color: Color(0xFF006194),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tr('ترتيب كفاءة الكباتن لهذا الأسبوع', 'Driver Efficiency Leaderboard'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0B1C30),
                                  ),
                                ),
                                Text(
                                  tr('استناداً لسرعة التوصيل ومعدل رضا الزبائن', 'Based on delivery speed & satisfaction rating'),
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
                        Text(
                          tr('فريق النخبة', 'Elite Team'),
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF006948),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildLeaderboardItem(
                      '1',
                      tr('أحمد العبادي', 'Ahmad Abbadi'),
                      tr('شاحنة هيونداي (تلاع العلي)', 'Hyundai Truck (Tlaa Al-Ali)'),
                      '4.90',
                      tr('128 طلب منجز', '128 orders completed'),
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuAai2p_475zmAr3GMfRLn6AJjXO5lgN23Oxwv6ux-45HKEtEStNUQsG6TRmm8Djf18UXq3n5ldaOQj-mEB-o31tHWzOmYa0sKPY-VRoAxlkCTtnXMkoNjvwWZVtdNtCg8KWrG6MR-PzA6_RedtaV24-kPgzP6VPdQocqKsFwwAhtpgz3OXqL8ZFeSPRmrPgrookJuDgvvwacSk5OIGCmV7Oz0aCmgjHKL8CZZSP9OTKmbd8vkA45cS1',
                      const Color(0xFF006194),
                    ),
                    const SizedBox(height: 8),
                    _buildLeaderboardItem(
                      '2',
                      tr('عمر الزعبي', 'Omar Zoubi'),
                      tr('شاحنة إيسوزو (خلدا ودابوق)', 'Isuzu Truck (Khalda & Dabouq)'),
                      '4.85',
                      tr('114 طلب منجز', '114 orders completed'),
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuDh9kLrwtXWWsFt-MKogurGnfBxDeBMEBQncw1fDvv3BR-o4ip3JB-WlUhEUWO3jfPDXQKVRdb5TwrAUoYmKfBgFULO-0KnVvPdX_FAfTHM3QmrT9VpAyWJnJxMrDTJWEtchzBQIlGdiKn3PG-iGx1nLIYBX9Fr9K4RxTnrS9mjhHiAdOaxnTjUzQD30wB_aaSMfgdXMMrKhqp679gSmsJELNb5SGt0q6da-517Q2BJKxobzjo-Vpyi',
                      const Color(0xFF565E74),
                    ),
                    const SizedBox(height: 8),
                    _buildLeaderboardItem(
                      '3',
                      tr('طارق المناصير', 'Tariq Manaseer'),
                      tr('شاحنة هيونداي (صويلح والجبيهة)', 'Hyundai Truck (Sweileh & Jubeiha)'),
                      '4.75',
                      tr('98 طلب منجز', '98 orders completed'),
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuCkbN0KxxPRzXG0T7riycp612DibJ3GfIFhMtRE0ROFZmKaPC16c6GykVgyLfKOFIYxcaUGyP7M2MI08LGCn068qGuAo7WKhcx4JieTH_bArkBgoo_6ap-UvyeCWa6h4PiJKlHjT0oQJptZbUSXz7DMDj5uVBMX0GEUvf12gpeceqYNgshtCtBCR1U74--V_ipfRaHFpPgV3hmShGlphFCoJeRMXvov_ajbJ0kPCBTvxEIG1ciuOX3p',
                      const Color(0xFF707881),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 6. Export & Report Sharing Actions
              ElevatedButton.icon(
                onPressed: () => _showSnackBar(
                  tr('جاري تجهيز وتصدير كشف PDF للضريبة والمحاسبة...', 'Preparing and exporting PDF tax statement...'),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006194),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(Icons.picture_as_pdf, size: 20),
                label: Text(
                  tr('تصدير كشف PDF للضريبة والمحاسبة', 'Export PDF for Tax & Accounting'),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () =>
                    _showSnackBar(tr('تم نسخ رابط تقرير الإنجاز اليومي للمشاركة', 'Daily report link copied to clipboard')),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFEFF4FF),
                  foregroundColor: const Color(0xFF0B1C30),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(
                  Icons.share,
                  size: 20,
                  color: Color(0xFF006194),
                ),
                label: Text(
                  tr('مشاركة تقرير الإنجاز اليومي', 'Share Daily Report'),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeframeButton(String key, String label) {
    bool isSelected = _selectedTimeframe == key;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTimeframe = key),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 4,
                    ),
                  ]
                : [],
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? const Color(0xFF006194)
                  : const Color(0xFF3F4850),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildKpiCard(
    String title,
    IconData icon,
    Color iconBg,
    Color iconColor,
    String metric,
    String unit,
    String subtext,
    Color subTextColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4),
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
                  borderRadius: BorderRadius.circular(6),
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
                  fontSize: 24,
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
                  color: Color(0xFF3F4850),
                ),
              ),
            ],
          ),
          Text(
            subtext,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 10,
              color: subTextColor,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildNeighborhoodRow(
    String name,
    String count,
    String percentage,
    Color color,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0B1C30),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              count,
              style: const TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 11,
                color: Color(0xFF3F4850),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 36,
              child: Text(
                percentage,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAccessoryItem(
    String title,
    String desc,
    String price,
    String unitPrice,
    IconData icon,
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
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: const Color(0xFF006194), size: 18),
              ),
              const SizedBox(width: 10),
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
                    desc,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B1C30),
                ),
              ),
              Text(
                unitPrice,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 10,
                  color: Color(0xFF006948),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardItem(
    String rank,
    String name,
    String subtitle,
    String rating,
    String completed,
    String imageUrl,
    Color rankColor,
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
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: rankColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  rank,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imageUrl,
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                ),
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
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 10,
                      color: Color(0xFF3F4850),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, size: 14, color: Color(0xFF006194)),
                  const SizedBox(width: 2),
                  Text(
                    rating,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
              Text(
                completed,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF006194),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
