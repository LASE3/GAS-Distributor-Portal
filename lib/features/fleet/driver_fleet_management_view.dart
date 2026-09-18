import 'package:flutter/material.dart';
import '../../core/localization/app_locale.dart';
import '../../core/routes/app_routes.dart';

class DriverFleetManagementView extends StatefulWidget {
  final bool showAppBar;
  const DriverFleetManagementView({super.key, this.showAppBar = true});

  @override
  State<DriverFleetManagementView> createState() =>
      _DriverFleetManagementViewState();
}

class _DriverFleetManagementViewState extends State<DriverFleetManagementView> {
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
          backgroundColor: const Color(0xFFF8F9FF).withValues(alpha: 0.9),
          elevation: 0,
          flexibleSpace: ClipRect(
            child: Container(color: const Color(0xFFF8F9FF).withValues(alpha: 0.9)),
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
                  Icons.local_shipping_outlined,
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
                        tr('أسطول التوزيع والسائقين', 'Fleet & Drivers Management'),
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
                              tr('مباشر', 'Live'),
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
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Operational Quick Metrics Strip
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildQuickMetricItem(
                          tr('الأسطول', 'Fleet'),
                          '8',
                          tr('مركبة', 'Vehicles'),
                          const Color(0xFFEFF4FF),
                          const Color(0xFF006194),
                        ),
                        _buildQuickMetricItem(
                          tr('متاح', 'Available'),
                          '4',
                          tr('جاهز فوري', 'Ready Now'),
                          const Color(0xFF85F8C4),
                          const Color(0xFF002114),
                          isLive: true,
                        ),
                        _buildQuickMetricItem(
                          tr('بالتوصيل', 'Delivering'),
                          '3',
                          tr('في المسار', 'En Route'),
                          const Color(0xFFD3E4FE),
                          const Color(0xFF006194),
                          isPulse: true,
                        ),
                        _buildQuickMetricItem(
                          tr('استراحة', 'On Break'),
                          '1',
                          tr('غير نشط', 'Inactive'),
                          const Color(0xFFDAE2FD),
                          const Color(0xFF565E74),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 2. Search and Quick Filters
                  Column(
                    children: [
                      TextField(
                        textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
                        decoration: InputDecoration(
                          hintText: tr(
                            'بحث بالاسم، رقم الشاحنة أو المنطقة...',
                            'Search by name, truck #, or zone...',
                          ),
                          hintStyle: const TextStyle(
                            fontFamily: 'Tajawal',
                            color: Color(0xFF707881),
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0xFF3F4850),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.tune,
                              color: Color(0xFF3F4850),
                            ),
                            onPressed: () {},
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 36,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildFilterPill('all', tr('الكل', 'All'), '8'),
                            const SizedBox(width: 8),
                            _buildFilterPill(
                              'available',
                              tr('متاح للطلب', 'Available'),
                              '4',
                              color: const Color(0xFF006948),
                            ),
                            const SizedBox(width: 8),
                            _buildFilterPill(
                              'in-mission',
                              tr('في مهمة', 'In Mission'),
                              '3',
                              color: const Color(0xFF006194),
                            ),
                            const SizedBox(width: 8),
                            _buildFilterPill(
                              'offline',
                              tr('غير متصل', 'Offline'),
                              '1',
                              color: const Color(0xFF565E74),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 1,
                              height: 20,
                              color: Colors.grey[300],
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                            ),
                            const SizedBox(width: 8),
                            _buildLocationPill(tr('دابوق', 'Dabouq'), true),
                            const SizedBox(width: 8),
                            _buildLocationPill(tr('خلدا', 'Khalda'), false),
                            const SizedBox(width: 8),
                            _buildLocationPill(tr('تلاع العلي', 'Tlaa Al-Ali'), false),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 3. Live Dispatch Efficiency Banner
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF006194),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.bolt,
                                  color: Color(0xFF85F8C4),
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  tr('طلب فوري في خلدا', 'Instant Order in Khalda'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              tr('أسطوانتان منزلي 12.5 كغ - أقرب كابتن يبعد 4 دقائق', '2x 12.5kg Cylinders - Nearest driver 4m away'),
                              style: const TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 11,
                                color: Color(0xFFCCE5FF),
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _showSnackBar(
                            tr('تم إسناد الطلب تلقائياً لأقرب كابتن متاح!', 'Order auto-assigned to nearest driver!'),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF006948),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          icon: const Icon(Icons.fast_forward, size: 16),
                          label: Text(
                            tr('إسناد تلقائي', 'Auto Assign'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 4. Drivers List
                  Column(
                    children: [
                      // Driver 1: Available
                      _buildDriverCard(
                        name: tr('الكابتن أحمد العبادي', 'Capt. Ahmad Abbadi'),
                        status: tr('متاح فوراً', 'Available Now'),
                        statusColor: const Color(0xFF006948),
                        statusBg: const Color(0xFF85F8C4),
                        vehicle: tr('كيا بونجو #1', 'Kia Bongo #1'),
                        location: tr('دوار الواحة', 'Al-Waha Circle'),
                        rating: '4.90',
                        deliveries: tr('12 تسليم اليوم', '12 deliveries today'),
                        cargoLoad: 14,
                        maxCargo: 20,
                        regulatorCount: 2,
                        battery: '94%',
                        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDhIiF7SqZ7eKmT-BAYKGBscPwLQ2vQgBqoW7irU0XYL52FiwiCdQiy4NUMjdMnXzxCsA0fcoSchlofyqOZ_KAuATELcjF8iyz-UfNJRWgIwt18S67vVoVZJA_B_0UgNo4rJAXNeZwPRzS6rU-0lMriX_B_XpM2vOID4ni5Qv5uuDEsR9Swd-KrW-G8HW9L5IgDR0gGWH4x_eNqNCol-tkTHt3MmWMFpQ6bbsnkGQ7oOnqwdHp0oiv4',
                        actionButtonText: tr('إسناد طلب جديد', 'Assign Order'),
                        onAction: () => _showSnackBar(
                          tr('فتح نافذة إسناد طلب جديد للكابتن أحمد', 'Opening order assignment for Capt. Ahmad'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Driver 2: In Mission (Omar Al-Zoubi)
                      _buildDriverCard(
                        name: tr('الكابتن عمر الزعبي', 'Capt. Omar Zoubi'),
                        status: tr('في توصيل', 'Delivering'),
                        statusColor: const Color(0xFF001D31),
                        statusBg: const Color(0xFFDAE2FD),
                        vehicle: tr('هينو ديزل #2', 'Hino Diesel #2'),
                        location: tr('دابوق - حي الفيلات', 'Dabouq - Villas Area'),
                        rating: '4.85',
                        deliveries: tr('14 تسليم اليوم', '14 deliveries today'),
                        isMission: true,
                        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB-zv4HNvegA1J_r0ewsBdcSlm_4RyJp60EjVpEJBfDHouHcdQ2JdfaEjJajjxjr9Yu1tlUNFVgXh_mRENfFqxcKv7UARA6kFVta_MYVhP3gpuWZbW1TeR_N61HXlhRnQzjfPV4hA_EqpmlpfZTL8KeVUjK1o2h4fF6aBY0meamN8i4BVdKFiD34aM7c_IInxhuwvgtsYeJd3OKDli5Jiy7Wk1DrxFeIm3wIT377o96BV4j7Ua5P8ip',
                        actionButtonText: tr('تتبع المسار المباشر', 'Track Live Route'),
                        onAction: () => _showSnackBar(
                          tr('جارٍ تحميل الخريطة المباشرة للكابتن عمر', 'Loading live route for Capt. Omar'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Driver 3: In Mission (Tariq Al-Manaseer)
                      _buildDriverCard(
                        name: tr('الكابتن طارق المناصير', 'Capt. Tariq Manaseer'),
                        status: tr('في مهمة', 'In Mission'),
                        statusColor: const Color(0xFF001D31),
                        statusBg: const Color(0xFFDAE2FD),
                        vehicle: tr('تويوتا داينا #3', 'Toyota Dyna #3'),
                        location: tr('خلدا - قرب مجمع جبر', 'Khalda - Near Jaber Complex'),
                        rating: '4.70',
                        deliveries: tr('9 تسليم اليوم', '9 deliveries today'),
                        cargoSimple: tr('5 أسطوانات جاهزة', '5 cylinders ready'),
                        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAxyDM65D2rGOTOukcyaTkbRmEVEV6rhy4QzFf7JlDLWmp8fTNwZp1vD5pUSnTsdVSJprbIba92QEN6T0YL3Iy96gEezoEwvkYqdN-_b5aIduky9s9S3bLxcqo6aR5IzJ7jEtfiG4kEtAuEwAxPHlX8-rRKQuJmNdVw5wKoRYMEaUAKP-ixjy7ahqior4RXWnlCEr2AcWfYVI4LEqs_ge68eeLbfivmcpysLlX8lMJ2eMJHPdT0rmbq',
                        actionButtonText: tr('تفاصيل المهمة', 'Mission Details'),
                        onAction: () =>
                            _showSnackBar(tr('عرض تفاصيل مهمة الكابتن طارق', 'Viewing mission details for Capt. Tariq')),
                      ),
                      const SizedBox(height: 16),
                      // Driver 4: Inactive / Break (Bilal Al-Rawashdeh)
                      _buildDriverCard(
                        name: tr('الكابتن بلال الرواشدة', 'Capt. Bilal Rawashdeh'),
                        status: tr('استراحة مؤقتة', 'On Break'),
                        statusColor: const Color(0xFF565E74),
                        statusBg: const Color(0xFFEFF4FF),
                        vehicle: tr('ميتسوبيشي كانتر #4', 'Mitsubishi Canter #4'),
                        location: tr('محطة صويلح المركزية', 'Sweileh Central Station'),
                        rating: '4.92',
                        deliveries: tr('8 تسليم اليوم', '8 deliveries today'),
                        breakNotice:
                            tr('استراحة الغداء والصلاة • آخر اتصال منذ 45 دقيقة', 'Lunch & prayer break • Last contact 45m ago'),
                        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAqqVDpyZ_iPt0BqcWwNQV6u_uBCedL-4i_YBfkOJPOQTDlOkHLvOjEttaY08gDCuWO0y5bwrR8Gu6PqgJxx1CLZQdNYqWpBL61Mc9_PdlUWKv3iocPXcGayGSiZ-vlAYcb8J7ctGz6ve6GYHarMUW6puGPpBAVQRGuZEFzH_IU_IM5FsxFeRrF9hlekdiLuj42GCWLnf_Bys8r29yj9QaKV69lwqWNw90abNap8d7h6_eonpz-uuKA',
                        actionButtonText: tr('إعادة تنشيط للمناوبة', 'Reactivate for Shift'),
                        onAction: () => _showSnackBar(
                          tr('تم إرسال تنبيه إعادة التنشيط للكابتن بلال', 'Reactivation alert sent to Capt. Bilal'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 5. Secondary Actions & Fleet Management Summary
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
                                  Icons.analytics,
                                  color: Color(0xFF006194),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  tr('ملخص كفاءة توزيع اليوم', "Today's Distribution Summary"),
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
                                color: const Color(0xFF85F8C4),
                                borderRadius: BorderRadius.circular(9999),
                              ),
                              child: Text(
                                tr('نسبة الإنجاز 92%', '92% Completion'),
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
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF4FF),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tr('الأسطوانات الموزعة', 'Cylinders Delivered'),
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 11,
                                        color: Color(0xFF3F4850),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      tr('148 أسطوانة', '148 Cylinders'),
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0B1C30),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF4FF),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tr('متوسط زمن التوصيل', 'Avg. Delivery Time'),
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 11,
                                        color: Color(0xFF3F4850),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      tr('16.4 دقيقة', '16.4 mins'),
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF006194),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => _showSnackBar(
                                  tr('جاري تصدير تقرير المناوبة...', 'Exporting shift report...'),
                                ),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: const Color(0xFFEFF4FF),
                                  side: BorderSide.none,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.file_download,
                                  size: 16,
                                  color: Color(0xFF006194),
                                ),
                                label: Text(
                                  tr('تصدير تقرير المناوبة', 'Export Shift Report'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0B1C30),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton.icon(
                              onPressed: () =>
                                  _showSnackBar(tr('فتح إعدادات تبديل المناطق', 'Opening zone swap settings')),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xFFEFF4FF),
                                side: BorderSide.none,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                              ),
                              icon: const Icon(
                                Icons.swap_calls,
                                size: 16,
                                color: Color(0xFF3F4850),
                              ),
                              label: Text(
                                tr('تبديل المناطق', 'Swap Zones'),
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
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
            // Floating Action Button
            Positioned(
              bottom: 24,
              left: 16,
              child: FloatingActionButton.extended(
                onPressed: () =>
                    _showSnackBar(tr('فتح نافذة إضافة سائق جديد للنظام', 'Opening add driver dialog')),
                backgroundColor: const Color(0xFF006194),
                foregroundColor: Colors.white,
                icon: const Icon(Icons.person_add),
                label: Text(
                  tr('إضافة سائق', 'Add Driver'),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
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

  Widget _buildQuickMetricItem(
    String title,
    String count,
    String subtitle,
    Color bgColor,
    Color textColor, {
    bool isLive = false,
    bool isPulse = false,
  }) {
    return Column(
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            count,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
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
        ),
      ],
    );
  }

  Widget _buildFilterPill(
    String key,
    String label,
    String count, {
    Color? color,
  }) {
    bool isSelected = _selectedFilter == key;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
            if (color != null) ...[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
            ],
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

  Widget _buildLocationPill(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFCCE5FF) : Colors.white,
        borderRadius: BorderRadius.circular(9999),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSelected) ...[
            const Icon(Icons.location_on, size: 14, color: Color(0xFF006194)),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? const Color(0xFF001D31)
                  : const Color(0xFF3F4850),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverCard({
    required String name,
    required String status,
    required Color statusColor,
    required Color statusBg,
    required String vehicle,
    required String location,
    required String rating,
    required String deliveries,
    int? cargoLoad,
    int? maxCargo,
    int? regulatorCount,
    String? battery,
    bool isMission = false,
    String? cargoSimple,
    String? breakNotice,
    required String imageUrl,
    required String actionButtonText,
    required VoidCallback onAction,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.driverProfile);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      imageUrl,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
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
                              color: statusBg,
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            Icons.local_shipping,
                            size: 14,
                            color: Color(0xFF006194),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            vehicle,
                            style: const TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 11,
                              color: Color(0xFF3F4850),
                            ),
                          ),
                          const Text(
                            ' • ',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            location,
                            style: const TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 11,
                              color: Color(0xFF006194),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                      const Icon(Icons.star, size: 14, color: Colors.amber),
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
                    deliveries,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 10,
                      color: Color(0xFF3F4850),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (cargoLoad != null && maxCargo != null) ...[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('حمولة الأسطوانات', 'Cylinder Cargo'),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 10,
                          color: Color(0xFF3F4850),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '$cargoLoad',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF006194),
                            ),
                          ),
                          Text(
                            tr(' من $maxCargo', ' of $maxCargo'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11,
                              color: Color(0xFF565E74),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('منظم وساعة غاز', 'Gas Regulators'),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 10,
                          color: Color(0xFF3F4850),
                        ),
                      ),
                      Text(
                        '$regulatorCount ${tr('إيطالي ممتاز', 'Premium Italian')}',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF006948),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('حالة الأجهزة', 'Device Status'),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 10,
                          color: Color(0xFF3F4850),
                        ),
                      ),
                      Text(
                        'GPS ${tr('نشط', 'Active')} ($battery)',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF006948),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ] else if (isMission) ...[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr('الطلب النشط: #ORD-2410', 'Active Order: #ORD-2410'),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF006194),
                        ),
                      ),
                      Text(
                        tr('الوصول المتوقع: 8 دقائق', 'ETA: 8 mins'),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF006948),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: 0.75,
                    backgroundColor: Colors.grey[300],
                    color: const Color(0xFF006194),
                    minHeight: 6,
                  ),
                ],
              ),
            ),
          ] else if (cargoSimple != null) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.propane_tank,
                    size: 16,
                    color: Color(0xFF006194),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${tr('الحمولة الحالية:', 'Current Cargo:')} $cargoSimple',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
            ),
          ] else if (breakNotice != null) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.coffee, size: 16, color: Color(0xFF565E74)),
                  const SizedBox(width: 8),
                  Text(
                    breakNotice,
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
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onAction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006194),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.bolt, size: 16),
                  label: Text(
                    actionButtonText,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => _showSnackBar('الاتصال بالكابتن...'),
                icon: const Icon(
                  Icons.call,
                  size: 18,
                  color: Color(0xFF006948),
                ),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFF85F8C4).withOpacity(0.3),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}
