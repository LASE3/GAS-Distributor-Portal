import 'package:flutter/material.dart';
import '../../core/localization/app_locale.dart';
import '../../core/widgets/portal_bottom_nav.dart';
import '../notifications/operational_notifications_view.dart';

class InventoryMovementsView extends StatefulWidget {
  const InventoryMovementsView({super.key});

  @override
  State<InventoryMovementsView> createState() => _InventoryMovementsViewState();
}

class _InventoryMovementsViewState extends State<InventoryMovementsView> {
  String _selectedFilter = 'all';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _movements = [
    {
      'category': 'refinery',
      'title': 'توريد شحنة مصفاة الزرقاء',
      'badge': 'وارد رسمي',
      'code': '#REF-99201',
      'qty': '+250',
      'unit': 'أسطوانة ممتلئة',
      'isPositive': true,
      'desc': 'الصنف المورد: غاز منزلي 12.5 كغ (مختوم أزرق)\nالفحص الفني: تم فحص الصمامات 100% بنجاح',
      'person': 'المستلم: أمين المستودع خالد العمري',
      'time': 'اليوم 11:30 ص',
    },
    {
      'category': 'drivers',
      'title': 'تحميل وردية الصباح (صرف)',
      'badge': 'خروج ميداني',
      'code': '#DIS-8841',
      'qty': '-60',
      'unit': 'أسطوانة 12.5 كغ',
      'isPositive': false,
      'desc': 'السائق والمركبة: عمر الزعبي (كانتر 12-4402)\nملحقات مسلمة: 5 منظمات إيطالي + 10 خراطيم أمان',
      'person': 'التوقيع الإلكتروني مؤكد',
      'time': 'اليوم 07:15 ص',
    },
    {
      'category': 'returns',
      'title': 'إرجاع وتفريغ فوارغ الوردية',
      'badge': 'باحة الفوارغ',
      'code': '#RET-4412',
      'qty': '+45',
      'unit': 'أسطوانة فارغة',
      'isPositive': true,
      'desc': 'الكابتن المورد: أحمد العبادي (خط عبدون / دير غبار)\nسلامة الهيكل: سليمة وجاهزة للشحن إلى الزرقاء',
      'person': 'منصة التحميل B - مسار المصفاة',
      'time': 'اليوم 03:20 م',
    },
    {
      'category': 'drivers',
      'title': 'صرف قطاع تجاري وأمانات',
      'badge': 'حجم 50 كغ',
      'code': '#INV-9204',
      'qty': '-10',
      'unit': 'أسطوانة تجارية',
      'isPositive': false,
      'desc': 'الجهة المستلمة: سلسلة مطاعم قصر الشام\nالسائق الناقل: الكابتن بلال المصري (مركبة أمانات)',
      'person': 'سند قبض مؤجل معتمد',
      'time': 'اليوم 01:45 م',
    },
    {
      'category': 'adjustments',
      'title': 'استبعاد صمام تالف للصيانة',
      'badge': 'تسوية فنية',
      'code': '#ADJ-108',
      'qty': '-1',
      'unit': 'عزل أمان',
      'isPositive': false,
      'desc': 'استبعاد أسطوانة لوجود تآكل في حلقة الأمان والصمام المطاطي، حُولت إلى قسم فحص السلامة تمهيداً للإرسال إلى ورش مصفاة البترول.',
      'person': 'موافقة مدير السلامة والوكالة',
      'time': 'أمس 05:30 م',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isAr = LocaleNotifier.instance.isArabic;
    final filteredMovements = _movements.where((item) {
      final matchesCategory =
          _selectedFilter == 'all' || item['category'] == _selectedFilter;
      final matchesSearch =
          _searchQuery.isEmpty ||
          item['title'].toLowerCase().contains(_searchQuery) ||
          item['code'].toLowerCase().contains(_searchQuery) ||
          item['desc'].toLowerCase().contains(_searchQuery);
      return matchesCategory && matchesSearch;
    }).toList();

    return Directionality(
      textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FF),
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Operational Context Banner
              _buildContextBanner(),
              const SizedBox(height: 12),

              // 2. Operational Summary KPI Cards
              _buildKpiSummary(),
              const SizedBox(height: 12),

              // 3. Depot Visual Preview Card
              _buildDepotPreviewCard(),
              const SizedBox(height: 16),

              // 4. Search & Filter Section
              _buildSearchAndFilters(),
              const SizedBox(height: 16),

              // 5. Detailed Ledger List
              if (filteredMovements.isEmpty)
                _buildEmptyState()
              else
                ...filteredMovements.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: _buildLedgerItem(item),
                  ),
                ),

              const SizedBox(height: 16),

              // 6. Major Action Button
              _buildMajorActionBtn(),
              const SizedBox(height: 80), // Space for bottom navigation
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  // --- AppBar ---
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF0B1C30)),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      backgroundColor: const Color(0xFFF8F9FF).withValues(alpha: 0.95),
      elevation: 0,
      toolbarHeight: 64,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF006194).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.local_gas_station,
              color: Color(0xFF006194),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'سجل حركات وتوريدات المستودع',
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
                        color: const Color(0xFFCCE5FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            radius: 3,
                            backgroundColor: Color(0xFF006194),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            tr('بوابة الموزع', 'Distributor Portal'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
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
                    fontFamily: 'Tajawal',
                    fontSize: 11,
                    color: Color(0xFF3F4850),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const OperationalNotificationsView(),
                  ),
                );
              },
              icon: const Icon(
                Icons.notifications_outlined,
                color: Color(0xFF3F4850),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFFBA1A1A),
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '4',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: CircleAvatar(
            backgroundColor: const Color(0xFF006194).withOpacity(0.2),
            radius: 18,
            backgroundImage: const NetworkImage(
              'https://lh3.googleusercontent.com/aida/AEtjO1XLSIDp383cBt8pf3mxYU2WcxmgFxoq6ZKYjK7ekv8tN18cZdasWehCSK9cF1z42kd-DPZvmfkp_TcVpMdCdzHZVm0WQLUZt7dBDe9EXOpzxvp46kOPFfhTLJzfVnhmiDKOWqOcYEnrDJ8ADSyBlnpL6jQAqvf5lNNPekMnsoGBCBNe48b2TDD6hcKkTD3FdJN4KG2YCIo9WAwa3SECKjp2Q60aNm3NhpyVUuO9jKmkhW0tClhxIM8W9Ik',
            ),
          ),
        ),
      ],
    );
  }

  // --- Context Banner ---
  Widget _buildContextBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: Color(0xFF006948),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'مستودع خلدا المركزي • قطاع عمان الغربية',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 11,
                          color: Color(0xFF006948),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    'سجل حركات المخزون والتوريد',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B1C30),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'متابعة شحنات مصفاة البترول الأردنية وتدفقات الأسطوانات الميدانية',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 12,
                      color: Color(0xFF3F4850),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF006194).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.warehouse,
                  color: Color(0xFF006194),
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006194),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.tune, size: 18),
                  label: const Text(
                    'تسجيل حركة / تسوية',
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFD3E4FE),
                    foregroundColor: const Color(0xFF0B1C30),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.picture_as_pdf, size: 18),
                  label: const Text(
                    'تصدير السجل PDF',
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- KPI Summary ---
  Widget _buildKpiSummary() {
    return Row(
      children: [
        Expanded(
          child: _kpiCard(
            'وارد اليوم',
            '+320',
            'مصفاة الزرقاء',
            Icons.arrow_downward,
            const Color(0xFF006948),
            const Color(0xFF85F8C4),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _kpiCard(
            'صرف السائقين',
            '-214',
            '6 شاحنات توزيع',
            Icons.arrow_upward,
            const Color(0xFFBA1A1A),
            const Color(0xFFFFDAD6),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _kpiCard(
            'فوارغ مستلمة',
            '+210',
            'شحن للمصفاة',
            Icons.cached,
            const Color(0xFF006194),
            const Color(0xFFCCE5FF),
          ),
        ),
      ],
    );
  }

  Widget _kpiCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color,
    Color bgColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
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
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 11,
                  color: color,
                ),
              ),
              Icon(icon, size: 16, color: color),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0B1C30),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              subtitle,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // --- Depot Preview Card ---
  Widget _buildDepotPreviewCard() {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: NetworkImage(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuC6tHmpyhWM67QoFBSPG0t5toisSjv07rIdaHf1wmw7Gar7KbFujl10D0lkE-87aZR4X4vEpeSbYXub8YZhaiiPlIkh1DatYf01hiZQrLT96SmyNwDnqzpWJwm8gXcKiU5bIgem8WmRagb491kEj1sjdkft3DeOLmUYh_a7Bl-3Dsw8zh1D7WjfqWS57E88Cu4Cdfxupgh14nvwuKK2AfdVOUi-4fwG4gzcPnZ_8rZIJIYm7FxVauUK',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              const Color(0xFF213145),
              const Color(0xFF213145).withOpacity(0.4),
              Colors.transparent,
            ],
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.local_shipping,
                      color: Color(0xFF93CCFF),
                      size: 18,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'حالة خط الإمداد اللوجستي',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  'الرصيد: 1,480 أسطوانة',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    color: Color(0xFF85F8C4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Search & Filters ---
  Widget _buildSearchAndFilters() {
    final filters = [
      {'key': 'all', 'label': 'كافة الحركات'},
      {'key': 'refinery', 'label': 'توريدات المصفاة (وارد)'},
      {'key': 'drivers', 'label': 'صرف للسائقين'},
      {'key': 'returns', 'label': 'استلام فوارغ'},
      {'key': 'adjustments', 'label': 'تعديل وجرد فني'},
    ];

    return Column(
      children: [
        TextField(
          controller: _searchController,
          onChanged: (val) =>
              setState(() => _searchQuery = val.trim().toLowerCase()),
          decoration: InputDecoration(
            hintText: 'بحث برقم الإرسالية، السائق، أو نوع الحركة...',
            hintStyle: const TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 13,
              color: Color(0xFF707881),
            ),
            prefixIcon: const Icon(Icons.search, color: Color(0xFF707881)),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () => setState(() {
                      _searchController.clear();
                      _searchQuery = '';
                    }),
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final f = filters[index];
              final isSelected = _selectedFilter == f['key'];
              return ChoiceChip(
                selected: isSelected,
                label: Text(f['label']!),
                selectedColor: const Color(0xFF006194),
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12,
                  color: isSelected ? Colors.white : const Color(0xFF3F4850),
                  fontWeight: FontWeight.bold,
                ),
                onSelected: (_) =>
                    setState(() => _selectedFilter = f['key']!),
              );
            },
          ),
        ),
      ],
    );
  }

  // --- Ledger Item ---
  Widget _buildLedgerItem(Map<String, dynamic> item) {
    final isPositive = item['isPositive'] as bool;
    final color = isPositive
        ? const Color(0xFF006948)
        : const Color(0xFFBA1A1A);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
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
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCE5FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.local_shipping,
                      color: Color(0xFF006194),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            item['title']! as String,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF85F8C4).withOpacity(0.4),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              item['badge']! as String,
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF005137),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        item['code']! as String,
                        style: const TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 11,
                          color: Color(0xFF006194),
                          fontWeight: FontWeight.bold,
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
                    item['qty']! as String,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    item['unit']! as String,
                    style: const TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 10,
                      color: Color(0xFF707881),
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
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              item['desc']! as String,
              style: const TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 12,
                color: Color(0xFF3F4850),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item['person']! as String,
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 11,
                  color: Color(0xFF707881),
                ),
              ),
              Text(
                item['time']! as String,
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 11,
                  color: Color(0xFF707881),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Empty State ---
  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Icon(Icons.search_off, size: 48, color: Color(0xFF707881)),
          const SizedBox(height: 12),
          const Text(
            'لم يتم العثور على أي قيود',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'تأكد من كتابة رقم الإرسالية أو البحث بشكل صحيح، أو أعد ضبط الفلاتر.',
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 12,
              color: Color(0xFF707881),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF006194),
              foregroundColor: Colors.white,
            ),
            onPressed: () => setState(() {
              _selectedFilter = 'all';
              _searchController.clear();
              _searchQuery = '';
            }),
            child: const Text(
              'إعادة ضبط التصفية',
              style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  // --- Major Action Button ---
  Widget _buildMajorActionBtn() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF006194),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {},
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_shipping, size: 20),
          SizedBox(width: 8),
          Text(
            'إنشاء طلب توريد جديد من مصفاة البترول',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // --- Bottom Nav ---
  Widget _buildBottomNav() {
    return const PortalBottomNav(currentIndex: 3);
  }
}
