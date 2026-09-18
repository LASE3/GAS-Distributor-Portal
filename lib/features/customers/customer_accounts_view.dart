import 'package:flutter/material.dart';
import '../../core/localization/app_locale.dart';
import '../../core/widgets/portal_bottom_nav.dart';
import '../notifications/operational_notifications_view.dart';

class CustomerAccountsView extends StatefulWidget {
  final bool showAppBar;
  const CustomerAccountsView({super.key, this.showAppBar = true});

  @override
  State<CustomerAccountsView> createState() => _CustomerAccountsViewState();
}

class _CustomerAccountsViewState extends State<CustomerAccountsView> {
  String _selectedCategory = 'all';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _customers = [
    {
      'name': 'سلسلة مطاعم قصر الشام',
      'type': 'commercial',
      'badge': 'عقد تجاري ذهبي',
      'location': 'عمان الغربية - خلدا - شارع وصفي التل',
      'status': 'نشط VIP',
      'phone': '0795541234',
      'contact': 'م. حسام (079-5541234)',
      'consumption': '18 أسطوانة/شهر (50 كغ)',
      'lastSupply': 'أمس (18 أسطوانة - تم)',
      'debt': 'آجل 15 يوم (150.00 د.أ)',
      'hasDebt': true,
    },
    {
      'name': 'م. طارق العبادي',
      'type': 'residential',
      'badge': 'اشتراك منزلي دوري',
      'location': 'دابوق - حي الرحمانية - عمارة 14',
      'status': 'منزلي',
      'phone': '0788812456',
      'contact': '078-8812456',
      'note': 'ملاحظات: يفضل التوصيل بعد الساعة 4 مساءً - الطابق الثالث مصعد متوفر.',
      'lastSupply': 'منذ أسبوعين (12.5 كغ + خرطوم أمان)',
      'hasDebt': false,
    },
    {
      'name': 'مخابز النور الآلية',
      'type': 'commercial',
      'badge': 'مستحق السداد',
      'location': 'تلاع العلي - قرب دوار الواحة',
      'status': 'متأخر',
      'phone': '0774409122',
      'debtAmount': '550.00 د.أ',
      'consumption': '35 أسطوانة أسبوعياً (صناعي)',
      'hasDebt': true,
      'isUrgent': true,
    },
    {
      'name': 'د. سارة التميمي',
      'type': 'residential',
      'badge': 'عميل موثوق (5.0)',
      'location': 'عبدون - شارع دمشق - فيلا 9',
      'status': 'موثوق',
      'phone': '0791123488',
      'lastSupply': 'منذ 3 أيام (أسطوانة 12.5 كغ)',
      'hasDebt': false,
      'isVip': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCustomers = _customers.where((cust) {
      final matchesCategory = _selectedCategory == 'all' ||
          (_selectedCategory == 'commercial' && cust['type'] == 'commercial') ||
          (_selectedCategory == 'residential' && cust['type'] == 'residential') ||
          (_selectedCategory == 'debt' && cust['hasDebt'] == true) ||
          (_selectedCategory == 'vip' && (cust['status'] == 'نشط VIP' || cust['isVip'] == true));

      final matchesSearch = _searchQuery.isEmpty ||
          cust['name'].toLowerCase().contains(_searchQuery) ||
          cust['location'].toLowerCase().contains(_searchQuery) ||
          cust['phone'].contains(_searchQuery);

      return matchesCategory && matchesSearch;
    }).toList();

    final isAr = LocaleNotifier.instance.isArabic;
    return Directionality(
      textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FF),
        appBar: widget.showAppBar ? _buildAppBar() : null,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Interactive Header Overview Metrics
              _buildMetricsHeader(),
              const SizedBox(height: 16),

              // 2. Search & Filter Controls
              _buildSearchAndFilters(),
              const SizedBox(height: 16),

              // 3. Customer Cards List
              if (filteredCustomers.isEmpty)
                _buildEmptyState()
              else
                ...filteredCustomers.map((cust) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: _buildCustomerCard(cust),
                    )),

              const SizedBox(height: 80), // Space for floating button & bottom nav
            ],
          ),
        ),
        floatingActionButton: _buildFloatingAddButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: widget.showAppBar ? _buildBottomNav() : null,
      ),
    );
  }

  // --- AppBar ---
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF8F9FF).withOpacity(0.9),
      elevation: 0,
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
              color: const Color(0xFF006194).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.local_gas_station, color: Color(0xFF006194), size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.agencyName,
                style: const TextStyle(fontFamily: 'Cairo', fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF006194)),
              ),
              Text(
                tr('إدارة حسابات المشتركين', 'Customer Accounts Management'),
                style: const TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30)),
              ),
            ],
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
              icon: const Icon(Icons.notifications_outlined, color: Color(0xFF3F4850)),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(color: Color(0xFFBA1A1A), shape: BoxShape.circle),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 8),
          child: CircleAvatar(
            backgroundColor: Color(0xFF006194),
            radius: 16,
            child: Icon(Icons.person, color: Colors.white, size: 18),
          ),
        ),
      ],
    );
  }

  // --- Metrics Header ---
  Widget _buildMetricsHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.contact_phone, color: Color(0xFF006194), size: 22),
                const SizedBox(width: 8),
                Text(tr('إدارة حسابات المشتركين', 'Customer Accounts'), style: const TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFF85F8C4), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const CircleAvatar(radius: 3, backgroundColor: Color(0xFF006948)),
                  const SizedBox(width: 4),
                  Text(tr('تحديث فوري', 'Live Sync'), style: const TextStyle(fontFamily: 'Cairo', fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF002114))),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.5,
          children: [
            _metricBox(tr('إجمالي المشتركين', 'Total Customers'), '1,480', tr('عميل', 'clients'), tr('+١٢ عميل جديد هذا الأسبوع', '+12 new this week'), Icons.group, const Color(0xFFCCE5FF), const Color(0xFF006194)),
            _metricBox(tr('نسبة التكرار الشهري', 'Monthly Retention'), '84%', tr('نشط جداً', 'Very Active'), '', Icons.repeat, const Color(0xFF85F8C4), const Color(0xFF006948)),
            _breakdownBox(tr('منشآت تجارية (عقود)', 'Commercial Accounts'), '120', tr('مطاعم وفنادق ومخابز', 'Restaurants & Bakeries'), Icons.corporate_fare),
            _breakdownBox(tr('منازل ومجمعات سكنية', 'Residential Accounts'), '1,360', tr('اشتراكات أفراد دورية', 'Recurring Household Subscriptions'), Icons.cottage),
          ],
        ),
      ],
    );
  }

  Widget _metricBox(String title, String value, String unit, String subtext, IconData icon, Color iconBg, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontFamily: 'Tajawal', fontSize: 11, color: Color(0xFF565E74))),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, color: iconColor, size: 16),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: const TextStyle(fontFamily: 'Cairo', fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30))),
              const SizedBox(width: 4),
              Text(unit, style: const TextStyle(fontFamily: 'Tajawal', fontSize: 11, color: Color(0xFF565E74))),
            ],
          ),
          if (subtext.isNotEmpty)
            Text(subtext, style: const TextStyle(fontFamily: 'Tajawal', fontSize: 9, color: Color(0xFF006948)), overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _breakdownBox(String title, String count, String desc, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontFamily: 'Tajawal', fontSize: 10, color: Color(0xFF565E74)), overflow: TextOverflow.ellipsis),
                Text(count, style: const TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF006194))),
                Text(desc, style: const TextStyle(fontFamily: 'Tajawal', fontSize: 9, color: Color(0xFF3F4850)), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFFDAE2FD), borderRadius: BorderRadius.circular(20)),
            child: Icon(icon, color: const Color(0xFF006194), size: 18),
          ),
        ],
      ),
    );
  }

  // --- Search & Filters ---
  Widget _buildSearchAndFilters() {
    final filters = [
      {'key': 'all', 'label': tr('كافة العملاء', 'All Customers'), 'count': '1480'},
      {'key': 'commercial', 'label': tr('منشآت تجارية (عقود)', 'Commercial Accounts')},
      {'key': 'residential', 'label': tr('عملاء منازل دوريون', 'Residential Accounts')},
      {'key': 'debt', 'label': tr('عملاء ذمم آجلة', 'Accounts with Debt')},
      {'key': 'vip', 'label': tr('الأكثر طلباً', 'Top Accounts')},
    ];

    return Column(
      children: [
        TextField(
          controller: _searchController,
          onChanged: (val) => setState(() => _searchQuery = val.trim().toLowerCase()),
          decoration: InputDecoration(
            hintText: tr('بحث بالاسم، رقم الهاتف، الحي، أو رقم العداد...', 'Search by name, phone, area, or meter #...'),
            hintStyle: const TextStyle(fontFamily: 'Tajawal', fontSize: 13, color: Color(0xFF707881)),
            prefixIcon: const Icon(Icons.search, color: Color(0xFF707881)),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.cancel, size: 18),
                    onPressed: () => setState(() {
                      _searchController.clear();
                      _searchQuery = '';
                    }),
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
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
              final isSelected = _selectedCategory == f['key'];
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
                onSelected: (_) => setState(() => _selectedCategory = f['key']!),
              );
            },
          ),
        ),
      ],
    );
  }

  // --- Customer Card ---
  Widget _buildCustomerCard(Map<String, dynamic> cust) {
    final isUrgent = cust['isUrgent'] == true;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          if (isUrgent)
            Container(height: 4, decoration: const BoxDecoration(color: Color(0xFFBA1A1A), borderRadius: BorderRadius.vertical(top: Radius.circular(12)))),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isUrgent ? const Color(0xFFFFDAD6) : const Color(0xFFCCE5FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            cust['type'] == 'commercial' ? Icons.restaurant : Icons.person,
                            color: isUrgent ? const Color(0xFFBA1A1A) : const Color(0xFF006194),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(cust['name']! as String, style: const TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.bold)),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: isUrgent ? const Color(0xFFFFDAD6) : const Color(0xFFDAE2FD),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    cust['badge']! as String,
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: isUrgent ? const Color(0xFFBA1A1A) : const Color(0xFF3F465C),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(cust['location']! as String, style: const TextStyle(fontFamily: 'Tajawal', fontSize: 11, color: Color(0xFF707881))),
                          ],
                        ),
                      ],
                    ),
                    Text(cust['phone']! as String, style: const TextStyle(fontFamily: 'Tajawal', fontSize: 11, color: Color(0xFF565E74))),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isUrgent ? const Color(0xFFFFDAD6).withOpacity(0.4) : const Color(0xFFEFF4FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (cust['consumption'] != null)
                        Text('${tr('معدل الاستهلاك:', 'Consumption:')} ${cust['consumption']}', style: const TextStyle(fontFamily: 'Tajawal', fontSize: 11, color: Color(0xFF3F4850))),
                      if (cust['lastSupply'] != null)
                        Text('${tr('آخر توريد:', 'Last Supply:')} ${cust['lastSupply']}', style: const TextStyle(fontFamily: 'Tajawal', fontSize: 11, color: Color(0xFF006948))),
                      if (cust['debt'] != null)
                        Text('${tr('شروط الدفع / الذمة:', 'Payment Terms:')} ${cust['debt']}', style: const TextStyle(fontFamily: 'Tajawal', fontSize: 11, color: Color(0xFFBA1A1A), fontWeight: FontWeight.bold)),
                      if (cust['debtAmount'] != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(tr('رصيد الذمة المتأخر:', 'Overdue Balance:'), style: const TextStyle(fontFamily: 'Tajawal', fontSize: 11, color: Color(0xFFBA1A1A))),
                            Text(cust['debtAmount'], style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFFBA1A1A))),
                          ],
                        ),
                      if (cust['note'] != null)
                        Text(cust['note'], style: const TextStyle(fontFamily: 'Tajawal', fontSize: 11, color: Color(0xFF3F4850))),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isUrgent ? const Color(0xFFDAE2FD) : const Color(0xFF006194),
                          foregroundColor: isUrgent ? const Color(0xFF131B2E) : Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {},
                        child: Text(isUrgent ? tr('إرسال رابط CliQ', 'Send CliQ Link') : tr('طلب تعبئة جديد', 'New Refill Request'), style: const TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFFEFF4FF),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {},
                        child: Text(tr('سجل الطلبات', 'Order History'), style: const TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Color(0xFF0B1C30))),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      style: IconButton.styleFrom(backgroundColor: const Color(0xFFEFF4FF)),
                      onPressed: () {},
                      icon: const Icon(Icons.call, size: 18, color: Color(0xFF006194)),
                    ),
                  ],
                ),
              ],
            ),
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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          const Icon(Icons.person_search, size: 48, color: Color(0xFF707881)),
          const SizedBox(height: 12),
          Text(tr('لم يتم العثور على عميل', 'No customer found'), style: const TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(tr('تأكد من كتابة الاسم أو رقم العداد أو رقم الهاتف بشكل صحيح في منطقة عمان وضواحيها.', 'Make sure the name, meter, or phone number is entered correctly.'), style: const TextStyle(fontFamily: 'Tajawal', fontSize: 12, color: Color(0xFF707881)), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEFF4FF), foregroundColor: const Color(0xFF006194)),
            onPressed: () => setState(() {
              _selectedCategory = 'all';
              _searchController.clear();
              _searchQuery = '';
            }),
            child: Text(tr('إعادة تعيين الفلاتر', 'Reset Filters'), style: const TextStyle(fontFamily: 'Cairo', fontSize: 12)),
          ),
        ],
      ),
    );
  }

  // --- Floating Add Customer Button ---
  Widget _buildFloatingAddButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.transparent,
      child: ElevatedButton(
        onPressed: () {
          _showAddCustomerModal(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF006194),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_add, size: 20),
            const SizedBox(width: 8),
            Text(tr('إضافة عميل / منشأة جديدة', 'Add New Customer / Business'), style: const TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // --- Add Customer Modal Sheet ---
  void _showAddCustomerModal(BuildContext context) {
    final isAr = LocaleNotifier.instance.isArabic;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Directionality(
        textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
        child: Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr('تسجيل مشترك جديد', 'Register New Customer'),
                    style: const TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: tr('اسم العميل / اسم المنشأة أو المطعم', 'Customer / Business Name'),
                  labelStyle: const TextStyle(fontFamily: 'Tajawal', fontSize: 12),
                  filled: true,
                  fillColor: const Color(0xFFEFF4FF),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: tr('رقم الهاتف الأساسي', 'Primary Phone Number'),
                  labelStyle: const TextStyle(fontFamily: 'Tajawal', fontSize: 12),
                  filled: true,
                  fillColor: const Color(0xFFEFF4FF),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF006194), foregroundColor: Colors.white),
                onPressed: () => Navigator.pop(context),
                child: Text(tr('حفظ وتفعيل المشترك', 'Save & Activate Customer'), style: const TextStyle(fontFamily: 'Cairo', fontSize: 13)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // --- Bottom Nav ---
  Widget _buildBottomNav() {
    return const PortalBottomNav(currentIndex: 4);
  }
}