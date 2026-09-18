import 'package:flutter/material.dart';
import '../../core/localization/app_locale.dart';

class ComplaintsSupportView extends StatefulWidget {
  final bool showAppBar;
  const ComplaintsSupportView({super.key, this.showAppBar = true});

  @override
  State<ComplaintsSupportView> createState() => _ComplaintsSupportViewState();
}

class _ComplaintsSupportViewState extends State<ComplaintsSupportView> {
  String _selectedFilter = 'all';

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
                        Icons.support_agent,
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
                              tr('مركز الشكاوى والدعم الفني', 'Complaints & Support Center'),
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
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Rapid Response Metric Strip
                  Container(
                    padding: const EdgeInsets.all(12),
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
                    child: Row(
                      children: [
                        _buildMetricBox(
                          tr('نشطة للمتابعة', 'Active Follow-ups'),
                          '02',
                          tr('أولوية فورية', 'Immediate Priority'),
                          const Color(0xFFBA1A1A),
                        ),
                        const SizedBox(width: 8),
                        _buildMetricBox(
                          tr('حُلت اليوم', 'Resolved Today'),
                          '05',
                          tr('زمن وسطي 18 د', 'Avg. Time 18m'),
                          const Color(0xFF006948),
                        ),
                        const SizedBox(width: 8),
                        _buildMetricBox(
                          tr('معدل الرضا', 'Satisfaction Rate'),
                          '96.2%',
                          tr('+1.4% هذا الأسبوع', '+1.4% this week'),
                          const Color(0xFF006194),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 2. Unit Response Banner
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCE9FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: Color(0xFF006194),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.support_agent,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tr('وحدة الاستجابة السريعة - قطاع غرب عمان', 'Rapid Response Unit - West Amman'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0B1C30),
                                  ),
                                ),
                                Text(
                                  tr('جاهزية كاملة لفحص تسريبات الغاز وتأخير الموزعين', 'Full readiness for leak checks & driver delays'),
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
                            tr('مفعل 24/7', 'Active 24/7'),
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
                  ),
                  const SizedBox(height: 16),

                  // 3. Filter Pills
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildFilterPill('all', tr('الكل', 'All'), '7'),
                        const SizedBox(width: 8),
                        _buildFilterPill('following', tr('قيد المتابعة', 'In Progress'), '2'),
                        const SizedBox(width: 8),
                        _buildFilterPill('delay', tr('تأخر توصيل', 'Delivery Delay'), '1'),
                        const SizedBox(width: 8),
                        _buildFilterPill('safety', tr('فحص الأمان والسلامة', 'Safety Check'), '1'),
                        const SizedBox(width: 8),
                        _buildFilterPill('resolved', tr('تم الحل والمطابقة', 'Resolved'), '4'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 4. Incident Cards Stream
                  Column(
                    children: [
                      // Card 1: #CMP-104 (Delivery Delay)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Color(0xFF007BB9),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            '#CMP-104',
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF006194),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFDAE2FD),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              tr('تأخر توصيل', 'Delivery Delay'),
                                              style: const TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF131B2E),
                                              ),
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
                                          color: const Color(0xFFCCE5FF),
                                          borderRadius: BorderRadius.circular(
                                            9999,
                                          ),
                                        ),
                                        child: Text(
                                          tr('قيد المتابعة الآن', 'In Progress Now'),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 36,
                                              height: 36,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF006194),
                                                shape: BoxShape.circle,
                                              ),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                'م.ف',
                                                style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  tr('م. فراس التميمي', 'Eng. Firas Tamimi'),
                                                  style: const TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF0B1C30),
                                                  ),
                                                ),
                                                Text(
                                                  tr('حي الجامعة - دابوق (شارع المواصفات)', 'University District - Dabouq'),
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
                                        const Text(
                                          '#ORD-2408',
                                          style: TextStyle(
                                            fontFamily: 'monospace',
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF006194),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFDAD6)
                                          .withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.hourglass_bottom,
                                          color: Color(0xFFBA1A1A),
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                tr('تجاوز نافذة التسليم بـ 25 دقيقة', 'Exceeded delivery window by 25 mins'),
                                                style: const TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF93000A),
                                                ),
                                              ),
                                              Text(
                                                tr('العميل بانتظار تبديل أسطوانتي غاز للتدفئة المنزلية، السائق تأخر بسبب إغلاق مروري مؤقت.', 'Customer waiting for 2 heating cylinders; driver delayed by temporary traffic closure.'),
                                                style: const TextStyle(
                                                  fontFamily: 'Tajawal',
                                                  fontSize: 11,
                                                  color: Color(0xFF3F4850),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () => _showSnackBar(
                                            tr('جاري الاتصال واعتذار العميل...', 'Calling customer to apologize...'),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFF006194,
                                            ),
                                            foregroundColor: Colors.white,
                                            elevation: 0,
                                          ),
                                          icon: const Icon(
                                            Icons.call,
                                            size: 16,
                                          ),
                                          label: Text(
                                            tr('اتصال واعتذار للعميل', 'Call & Apologize'),
                                            style: const TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: OutlinedButton.icon(
                                          onPressed: () => _showSnackBar(
                                            tr('فتح خريطة تتبع السائق بلال الهنداوي', 'Opening live map tracking for Bilal'),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFFEFF4FF,
                                            ),
                                            side: BorderSide.none,
                                          ),
                                          icon: const Icon(
                                            Icons.near_me,
                                            size: 16,
                                            color: Color(0xFF006194),
                                          ),
                                          label: Text(
                                            tr('متابعة خط سير السائق', 'Track Driver Route'),
                                            style: const TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF0B1C30),
                                            ),
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
                      const SizedBox(height: 16),

                      // Card 2: #CMP-102 (Safety Inspection Resolved)
                      Container(
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Color(0xFF006948),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            '#CMP-102',
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF0B1C30),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFFDAD6),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              tr('فحص أمان وتسريب', 'Safety & Leak Check'),
                                              style: const TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF93000A),
                                              ),
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
                                          color: const Color(0xFF85F8C4),
                                          borderRadius: BorderRadius.circular(
                                            9999,
                                          ),
                                        ),
                                        child: Text(
                                          tr('تم الحل والإغلاق', 'Resolved & Closed'),
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            tr('سناء حدادين', 'Sana Haddadin'),
                                            style: const TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF0B1C30),
                                            ),
                                          ),
                                          Text(
                                            tr('عمان - خلدا قرب مجمع الداوود', 'Amman - Khalda near Dawood Complex'),
                                            style: const TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 11,
                                              color: Color(0xFF3F4850),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            tr('الموزع الميداني', 'Field Driver'),
                                            style: const TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 10,
                                              color: Color(0xFF707881),
                                            ),
                                          ),
                                          Text(
                                            tr('عمر الزعبي', 'Omar Zoubi'),
                                            style: const TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF0B1C30),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF85F8C4)
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tr('الإجراء الفوري المنفذ:', 'Immediate Action Taken:'),
                                          style: const TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF006948),
                                          ),
                                        ),
                                        Text(
                                          tr('تم تحريك فني الصيانة والطوارئ فوراً؛ تم فحص جلدة الصمام برغوة الصابون وتبين تلف مانع التسريب وتم استبدال الساعة وفحص الأمان.', 'Emergency tech dispatched; valve seal tested with soap foam, replaced regulator and verified safety.'),
                                          style: const TextStyle(
                                            fontFamily: 'Tajawal',
                                            fontSize: 11,
                                            color: Color(0xFF0B1C30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Sticky Action Bar
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: ElevatedButton.icon(
                onPressed: () =>
                    _showSnackBar(tr('فتح نافذة تسجيل بلاغ أو شكوى هاتفية جديدة', 'Opening new complaint registration dialog')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006194),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.add_call, size: 20),
                label: Text(
                  tr('تسجيل بلاغ أو شكوى جديدة', 'Register New Report / Complaint'),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricBox(
    String title,
    String value,
    String subtitle,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF4FF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 10,
                color: Color(0xFF3F4850),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 9,
                color: Color(0xFF3F4850),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterPill(String key, String label, String count) {
    bool isSelected = _selectedFilter == key;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF006194) : Colors.white,
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF0B1C30),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                count,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : const Color(0xFF3F4850),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
