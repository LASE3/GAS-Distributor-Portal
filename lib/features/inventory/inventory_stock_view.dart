import 'package:flutter/material.dart';
import '../../core/localization/app_locale.dart';
import '../../core/routes/app_routes.dart';

class InventoryStockView extends StatefulWidget {
  final bool showAppBar;
  const InventoryStockView({super.key, this.showAppBar = true});

  @override
  State<InventoryStockView> createState() => _InventoryStockViewState();
}

class _InventoryStockViewState extends State<InventoryStockView> {
  bool _isSupplyRequested = false;
  bool _showToast = false;
  String _toastMessage = '';
  bool _isModalOpen = false;
  String _modalItemName = 'تسوية رصيد المستودع';

  void _triggerToast(String message) {
    setState(() {
      _toastMessage = message;
      _showToast = true;
    });
    Future.delayed(const Duration(seconds: 4), () {
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
                  Icons.propane_tank,
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
                        tr('المخزون والأسطوانات', 'Inventory & Cylinders'),
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
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Interactive Stock Telemetry Bar
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
                                const Icon(
                                  Icons.warehouse,
                                  color: Color(0xFF006194),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  tr('مستودع الوكالة الرئيسي (خلدا)', 'Main Agency Warehouse (Khalda)'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
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
                                color: const Color(0xFF00855D),
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
                                        color: Color(0xFF85F8C4),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    tr('تحديث فوري', 'Live Sync'),
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr('السعة التشغيلية الإجمالية للمستودع', 'Total Depot Operational Capacity'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 11,
                                color: Color(0xFF3F4850),
                              ),
                            ),
                            Text(
                              tr('239 / 300 أسطوانة (80%)', '239 / 300 Cylinders (80%)'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B1C30),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(9999),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: LinearProgressIndicator(
                              value: 239 / 300,
                              backgroundColor: const Color(0xFFE5EEFF),
                              color: const Color(0xFF006194),
                              minHeight: 10,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              size: 8,
                              color: Color(0xFF006194),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              tr('ممتلئ (142)', 'Filled (142)'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 11,
                                color: Color(0xFF3F4850),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(
                              Icons.circle,
                              size: 8,
                              color: Color(0xFF565E74),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              tr('فارغ للتعبئة (86)', 'Empty to Refill (86)'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 11,
                                color: Color(0xFF3F4850),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(
                              Icons.circle,
                              size: 8,
                              color: Color(0xFF006948),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              tr('محجوز (11)', 'Reserved (11)'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 11,
                                color: Color(0xFF3F4850),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 2. Low Stock Alert Banner
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFDAD6),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 4,
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
                            color: const Color(0xFFBA1A1A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.warning,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tr('تنبيه مخزون منخفض حرج', 'Critical Low Stock Alert'),
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF93000A),
                                    ),
                                  ),
                                  Text(
                                    tr('متبقي 6 قطع', '6 units left'),
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF93000A),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                tr(
                                  'ساعة غاز إيطالي (أصلي) بلغت مستوى أدنى من حد الأمان المحدد (الحد الآمن: 12 قطعة). خطر نفاد وشيك مع الطلبات المسائية.',
                                  'Original Italian gas regulator is below safe threshold (Safe: 12 units). Shortage risk with evening orders.',
                                ),
                                style: const TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontSize: 12,
                                  color: Color(0xFF93000A),
                                ),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton.icon(
                                onPressed: _isSupplyRequested
                                    ? null
                                    : () {
                                        setState(() {
                                          _isSupplyRequested = true;
                                        });
                                        _triggerToast(
                                          tr(
                                            'تم رفع طلب تزويد عاجل بـ 25 ساعة غاز من مستودع الغاز المركزي!',
                                            'Urgent replenishment order for 25 regulators submitted to Central Depot!',
                                          ),
                                        );
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isSupplyRequested
                                      ? const Color(0xFF006948)
                                      : const Color(0xFFBA1A1A),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                icon: Icon(
                                  _isSupplyRequested
                                      ? Icons.done
                                      : Icons.add_shopping_cart,
                                  size: 16,
                                ),
                                label: Text(
                                  _isSupplyRequested
                                      ? tr('تم الطلب (قيد المعالجة)', 'Requested (Processing)')
                                      : tr('طلب تزويد مخزون من الإدارة المركزية', 'Request Supply from Central Admin'),
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 3. KPI Grid (2x2 Compact Grid)
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.25,
                    children: [
                      _buildKpiCard(
                        tr('ممتلئة وجاهزة', 'Filled & Ready'),
                        Icons.propane_tank,
                        const Color(0xFFCCE5FF),
                        const Color(0xFF006194),
                        '142',
                        tr('أسطوانة', 'Cylinders'),
                        tr('• 128 في المستودع الرئيسي\n• 14 على شاحنات السائقين', '• 128 in central depot\n• 14 on driver trucks'),
                      ),
                      _buildKpiCard(
                        tr('محجوزة لطلبات', 'Reserved for Orders'),
                        Icons.lock_clock,
                        const Color(0xFFDAE2FD),
                        const Color(0xFF565E74),
                        '11',
                        tr('أسطوانة', 'Cylinders'),
                        tr('✓ مخصصة لـ 7 طلبات جارية', '✓ Allocated for 7 active orders'),
                      ),
                      _buildKpiCard(
                        tr('فارغة مرتجعة', 'Empty Returned'),
                        Icons.sync_alt,
                        const Color(0xFFD3E4FE),
                        const Color(0xFF3F4850),
                        '86',
                        tr('أسطوانة', 'Cylinders'),
                        tr('• بانتظار شاحنة المصفاة\nموعد الشحن: 14:00', '• Awaiting refinery truck\nDispatch: 14:00'),
                      ),
                      _buildKpiCard(
                        tr('ملحقات السلامة', 'Safety Accessories'),
                        Icons.tune,
                        const Color(0xFF85F8C4),
                        const Color(0xFF006948),
                        '48',
                        tr('قطعة', 'Units'),
                        tr('• منظمات، خراطيم، مرابط\n1 صنف بحاجة لتوريد', '• Regulators, hoses, clamps\n1 item needs supply'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 4. Visual Depot Warehouse Quick Card
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
                      children: [
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuC8L8ZjeZm7M_8z3OP00G3Hka1tzjOi9PQf_ytjq_i2rploEZOytg_847QXBJg7guIqhmIqg26mOFFKRfQpmd8nN8iJSnm1QUxjarSKYlZ3FVgKkmG11IhClZHbaivo9TmLZw9rDmAnv2KAJl7uoeb0cuzgkoWn6aKIzWSk7Q5uI81uBsay_beniWMugJ5YQ75v1uExGy-LnLqzGHhYfkjglDca4DCenZqLlUx792gOy8Pu9hNjmgOk',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tr('فحص معايير السلامة والأمان', 'Safety & Compliance Inspection'),
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0B1C30),
                                    ),
                                  ),
                                  Text(
                                    tr('آخر جرد ومسح دوري لتسرب الغاز: اليوم 07:15 ص (معتمد)', 'Latest periodic gas leak audit: Today 07:15 AM (Certified)'),
                                    style: const TextStyle(
                                      fontFamily: 'Tajawal',
                                      fontSize: 11,
                                      color: Color(0xFF3F4850),
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.verified_user,
                                color: Color(0xFF006948),
                                size: 26,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 5. Detailed Product Section Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            tr('موجودات المستودع التفصيلية', 'Detailed Depot Inventory Items'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0B1C30),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            tr('4 أصناف مسجلة', '4 items registered'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11,
                              color: Color(0xFF3F4850),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.filter_list,
                            size: 16,
                            color: Color(0xFF006194),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            tr('تصفية', 'Filter'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF006194),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Product Cards
                  _buildProductCard(
                    tr('أسطوانة غاز منزلي 12.5 كغ', 'Domestic Gas Cylinder 12.5 kg'),
                    tr('غاز بترولي مسال مصفي - معيار المواصفات الأردنية', 'Refined LPG - Jordan Standard Specification'),
                    Icons.propane_tank,
                    const Color(0xFFCCE5FF),
                    const Color(0xFF006194),
                    tr('متوفر بكثرة', 'Abundant'),
                    '153',
                    '142',
                    '11',
                    const Color(0xFF006948),
                  ),
                  const SizedBox(height: 12),
                  _buildProductCard(
                    tr('منظم / ساعة غاز إيطالي أصلية', 'Original Italian Gas Regulator'),
                    tr('ضغط منزلي منخفض (30 ملي بار) مع صمام إغلاق أوتوماتيكي', 'Low household pressure (30 mbar) with auto shut-off valve'),
                    Icons.speed,
                    const Color(0xFFFFDAD6),
                    const Color(0xFFBA1A1A),
                    tr('منخفض (6 قطع)', 'Low (6 units)'),
                    '6',
                    '5',
                    '1',
                    const Color(0xFFBA1A1A),
                    isLow: true,
                  ),
                  const SizedBox(height: 12),
                  _buildProductCard(
                    tr('خرطوم غاز مقوى 2 متر', 'Reinforced Gas Hose 2m'),
                    tr('بربيش أصلي مقاوم للحرارة والتشقق مع 2 قفيز أمان مجلفن', 'Heat-resistant certified hose with 2 galvanized safety clamps'),
                    Icons.cable,
                    const Color(0xFFD3E4FE),
                    const Color(0xFF006194),
                    tr('متوفر', 'In Stock'),
                    '24',
                    '22',
                    '2',
                    const Color(0xFF006948),
                  ),
                  const SizedBox(height: 12),
                  _buildProductCard(
                    tr('مفتاح أمان ومفتاح فك وتركيب', 'Safety Valve & Wrench Tool'),
                    tr('مفتاح صمام أمان نحاسي مطابق لمعايير الدفاع المدني', 'Brass safety valve wrench meeting Civil Defense standards'),
                    Icons.build,
                    const Color(0xFFE5EEFF),
                    const Color(0xFF3F4850),
                    tr('متوفر', 'In Stock'),
                    '18',
                    '18',
                    '0',
                    const Color(0xFF006948),
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
                    color: const Color(0xFF006948),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 8),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _toastMessage,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                        onPressed: () => setState(() => _showToast = false),
                      ),
                    ],
                  ),
                ),
              ),
            // Floating Action Button
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _modalItemName = tr('تسوية رصيد المستودع', 'Warehouse Inventory Adjustment');
                      _isModalOpen = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006194),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                  icon: const Icon(Icons.tune, size: 20),
                  label: Text(
                    tr('إضافة / تسوية جرد المستودع', 'Add / Adjust Warehouse Stock'),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Simulated Bottom Sheet Modal
            if (_isModalOpen)
              Positioned.fill(
                child: Container(
                  color: Colors.black54,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _modalItemName,
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B1C30),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () =>
                                  setState(() => _isModalOpen = false),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          tr('الكمية المراد تسويتها أو إضافتها:', 'Quantity to adjust or add:'),
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            color: Color(0xFF3F4850),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFEFF4FF),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            setState(() => _isModalOpen = false);
                            _triggerToast(
                              tr('تم تحديث حركة المستودع بنجاح وتسجيلها في سجل الرقابة!', 'Warehouse movement updated successfully and recorded in audit log!'),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF006194),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            tr('تأكيد وحفظ الحركة', 'Confirm & Save Movement'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
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
                  borderRadius: BorderRadius.circular(8),
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
                  color: Color(0xFF3F4850),
                ),
              ),
            ],
          ),
          Text(
            subtext,
            style: const TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 10,
              color: Color(0xFF3F4850),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(
    String name,
    String desc,
    IconData icon,
    Color iconBg,
    Color iconColor,
    String statusText,
    String total,
    String available,
    String reserved,
    Color statusColor, {
    bool isLow = false,
  }) {
    return Container(
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
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: iconBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: iconColor, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(
                        width: 180,
                        child: Text(
                          desc,
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  statusText,
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
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildProductMetric(tr('الإجمالي', 'Total'), total, const Color(0xFF0B1C30)),
                _buildProductMetric(
                  tr('المتاح للبيع', 'Available'),
                  available,
                  isLow ? const Color(0xFFBA1A1A) : const Color(0xFF006194),
                ),
                _buildProductMetric(
                  tr('المحجوز', 'Reserved'),
                  reserved,
                  const Color(0xFF565E74),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.inventoryMovements),
                style: OutlinedButton.styleFrom(
                  side: BorderSide.none,
                  backgroundColor: const Color(0xFFEFF4FF),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                ),
                icon: const Icon(
                  Icons.history,
                  size: 14,
                  color: Color(0xFF3F4850),
                ),
                label: Text(
                  tr('سجل الحركات', 'Movement Log'),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    color: Color(0xFF3F4850),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _modalItemName = '${tr('تسوية:', 'Adjust:')} $name';
                    _isModalOpen = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLow
                      ? const Color(0xFF007BB9)
                      : const Color(0xFF006194),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                ),
                icon: Icon(isLow ? Icons.add_box : Icons.edit_note, size: 14),
                label: Text(
                  isLow ? tr('تزويد المستودع', 'Restock Warehouse') : tr('تسوية رصيد', 'Adjust Stock'),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
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
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
