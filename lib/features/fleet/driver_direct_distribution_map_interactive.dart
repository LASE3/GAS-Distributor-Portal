import 'package:flutter/material.dart';
import '../../core/localization/app_locale.dart';
import '../../core/routes/app_routes.dart';
import '../../core/widgets/portal_bottom_nav.dart';

class DriverDirectDistributionMapInteractive extends StatefulWidget {
  const DriverDirectDistributionMapInteractive({super.key});

  @override
  State<DriverDirectDistributionMapInteractive> createState() =>
      _DriverDirectDistributionMapInteractiveState();
}

class _DriverDirectDistributionMapInteractiveState
    extends State<DriverDirectDistributionMapInteractive> {
  String _selectedDriverKey = 'omar';
  String _selectedFilter = 'all';

  Map<String, Map<String, dynamic>> _getDriversData() {
    return {
      'omar': {
        'name': tr('عمر الزعبي', 'Omar Al-Zoubi'),
        'badge': tr('كابتن مميز', 'Featured Captain'),
        'sub': tr('شاحنة هينو ديزل • لوحة 12-48201', 'Hino Diesel Truck • Plate 12-48201'),
        'order': tr('طلب #2409', 'Order #2409'),
        'orderColor': const Color(0xFFFEF3C7),
        'orderTextColor': const Color(0xFF78350F),
        'avatar':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuD_wBQ4cfzG-a5ktX1b_bAqDCnNleYngGmR5JqdyQuYSnWJCFLDNO7HH0yFxqE_EqFGpemjIKl-JUGMH05ndtYlBIvR9vgML4O-noUb0_UklzZ_NOoqXsX5LcaG92OAm_E_QuOKY6ImI8saynyGM4bElUjRZ7SGADpcKswB0c9HwoU-Xi_I-ikLCLZFxF-MAvgAJ-4dCB5bAQ0GCYtrvfUqEl6J5Px8VETlJkwI9rI_qzOwUEq1IFnF',
      },
      'ahmad': {
        'name': tr('أحمد العبادي', 'Ahmad Al-Abbadi'),
        'badge': tr('متاح للطلب', 'Available for Orders'),
        'sub': tr('شاحنة ايسوزو • لوحة 14-99120', 'Isuzu Truck • Plate 14-99120'),
        'order': tr('متاح للإسناد', 'Ready to Assign'),
        'orderColor': const Color(0xFFDCFCE7),
        'orderTextColor': const Color(0xFF14532D),
        'avatar':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDQxyUujRUq9JpfnGiE_MFzmF1mXf8OpxVckDs9bLluEIUHriU5QxGc8gRKly5vXqSdoaFy3cpuHTT1N2PZ-reVpyezHUSnH5bIpftd4FQ1f_4N88leMXCI87BHNcCw0wVJ_-w1HmCoQr-XH0P9s9OZtDJyqngqDRoVxWNUIhgbnQhfejE9Zs8WunXhMj6tcw6fpgLz4ShbobK6f-dAoH6SxYIAvvpsxw_ELYP2K58Ha-isjB1WuE3w',
      },
      'mahmoud': {
        'name': tr('محمود الخالد', 'Mahmoud Al-Khaled'),
        'badge': tr('في استراحة', 'On Break'),
        'sub': tr('شاحنة ميتسوبيشي • لوحة 10-33451', 'Mitsubishi Truck • Plate 10-33451'),
        'order': tr('استراحة مؤقتة', 'Temporary Break'),
        'orderColor': const Color(0xFFF1F5F9),
        'orderTextColor': const Color(0xFF1E293B),
        'avatar':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCQxyUujRUq9JpfnGiE_MFzmF1mXf8OpxVckDs9bLluEIUHriU5QxGc8gRKly5vXqSdoaFy3cpuHTT1N2PZ-reVpyezHUSnH5bIpftd4FQ1f_4N88leMXCI87BHNcCw0wVJ_-w1HmCoQr-XH0P9s9OZtDJyqngqDRoVxWNUIhgbnQhfejE9Zs8WunXhMj6tcw6fpgLz4ShbobK6f-dAoH6SxYIAvvpsxw_ELYP2K58Ha-isjB1WuE3w',
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    final isAr = LocaleNotifier.instance.isArabic;
    final driversData = _getDriversData();
    final currentDriver = driversData[_selectedDriverKey] ?? driversData['omar']!;

    return Directionality(
      textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FF),
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSyncHeader(),
              _buildFilterChips(),
              _buildInteractiveMap(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildDriverCard(currentDriver),
              ),
              _buildFleetStrip(),
              const SizedBox(height: 24),
            ],
          ),
        ),
        bottomNavigationBar: const PortalBottomNav(currentIndex: 2),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF0B1C30)),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      backgroundColor: const Color(0xFFF8F9FF).withValues(alpha: 0.85),
      elevation: 0,
      toolbarHeight: 64,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFE5EEFF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.local_shipping,
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
                    Flexible(
                      child: Text(
                        tr('خريطة التوزيع الميداني المباشر', 'Live Field Distribution Map'),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0B1C30),
                        ),
                        overflow: TextOverflow.ellipsis,
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            radius: 3,
                            backgroundColor: Color(0xFF006948),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            tr('مباشر', 'Live'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
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
                Navigator.of(context).pushNamed(AppRoutes.notifications);
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
                  '3',
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
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildSyncHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFD3E4FE).withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const CircleAvatar(radius: 4, backgroundColor: Color(0xFF006948)),
                const SizedBox(width: 6),
                Text(
                  tr('مزامنة GPS حية (منذ 5 ثوانٍ)', 'Live GPS Sync (5s ago)'),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    color: Color(0xFF0B1C30),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 4),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.satellite_alt, size: 16, color: Color(0xFF006948)),
                const SizedBox(width: 4),
                Text(
                  tr('8 مركبات متصلة', '8 Connected Vehicles'),
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
    );
  }

  Widget _buildFilterChips() {
    final filters = [
      {
        'key': 'all',
        'label': tr('الكل', 'All'),
        'count': '8',
        'color': const Color(0xFF006194),
      },
      {
        'key': 'available',
        'label': tr('متاح', 'Available'),
        'count': '4',
        'color': const Color(0xFF006948),
      },
      {
        'key': 'in-transit',
        'label': tr('في توصيل', 'Delivering'),
        'count': '3',
        'color': Colors.amber,
      },
      {
        'key': 'offline',
        'label': tr('استراحة/غير متصل', 'Break/Offline'),
        'count': '1',
        'color': const Color(0xFF565E74),
      },
    ];

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final f = filters[index];
          final isSelected = _selectedFilter == f['key'];
          return ChoiceChip(
            selected: isSelected,
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (f['key'] != 'all')
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: f['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                  ),
                if (f['key'] != 'all') const SizedBox(width: 6),
                Text(f['label']! as String),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.2)
                        : const Color(0xFFE5EEFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    f['count']! as String,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
            selectedColor: const Color(0xFF006194),
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              color: isSelected ? Colors.white : const Color(0xFF0B1C30),
              fontWeight: FontWeight.bold,
            ),
            onSelected: (_) {
              setState(() {
                _selectedFilter = f['key']! as String;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildInteractiveMap() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 320,
        decoration: BoxDecoration(
          color: const Color(0xFFDCE9FF),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: const Color(0xFFE5EEFF),
                  child: const Center(
                    child: Icon(Icons.map, size: 80, color: Color(0xFFBDC7D2)),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tr('خلدا - شارع وصفي التل', 'Khalda - Wasfi Al-Tal St.'),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 80,
              left: 100,
              child: GestureDetector(
                onTap: () => setState(() => _selectedDriverKey = 'ahmad'),
                child: _mapPinMarker(
                  tr('أحمد', 'Ahmad'),
                  const Color(0xFF006948),
                  _selectedDriverKey == 'ahmad',
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              right: 120,
              child: GestureDetector(
                onTap: () => setState(() => _selectedDriverKey = 'omar'),
                child: _mapPinMarker(
                  tr('عمر الزعبي', 'Omar Al-Zoubi'),
                  Colors.amber.shade700,
                  _selectedDriverKey == 'omar',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mapPinMarker(String name, Color color, bool isSelected) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
          ),
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: const Icon(
            Icons.local_shipping,
            size: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDriverCard(Map<String, dynamic> driver) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.shade200),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF006194).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, color: Color(0xFF006194)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            driver['name']! as String,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 15,
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
                              color: const Color(0xFFDAE2FD),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              driver['badge']! as String,
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        driver['sub']! as String,
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: driver['orderColor'] as Color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  driver['order']! as String,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: driver['orderTextColor'] as Color,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr('الزبون: رانية الحنيطي', 'Customer: Rania Al-Hunaiti'),
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      tr('14.50 د.أ', '14.50 JOD'),
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF006194),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  tr(
                    'خلدا - خلف مدارس الدر المنثور، عمارة الياسمين، ط 3',
                    'Khalda - Behind Al-Durr Al-Manthoor Schools, Jasmine Bldg, Fl 3',
                  ),
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
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006948),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.call, size: 16),
                  label: Text(
                    tr('اتصال', 'Call'),
                    style: const TextStyle(fontFamily: 'Cairo', fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
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
                  icon: const Icon(Icons.route, size: 16),
                  label: Text(
                    tr('مسار', 'Route'),
                    style: const TextStyle(fontFamily: 'Cairo', fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFDAE2FD),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.smartDispatch);
                  },
                  child: Text(
                    tr('إسناد طلب', 'Assign Order'),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      color: Color(0xFF0B1C30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFleetStrip() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr('أسطول التوزيع السريع', 'Express Distribution Fleet'),
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.fleet);
                },
                child: Text(
                  tr('عرض الجدول الكامل', 'View Full Roster'),
                  style: const TextStyle(fontFamily: 'Cairo', fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _fleetMiniCard(
                'omar',
                tr('عمر الزعبي', 'Omar Al-Zoubi'),
                tr('توصيل دابوق', 'Dabouq Delivery'),
                Colors.amber[800]!,
              ),
              const SizedBox(width: 10),
              _fleetMiniCard(
                'ahmad',
                tr('أحمد العبادي', 'Ahmad Al-Abbadi'),
                tr('متاح بالقرب', 'Available Nearby'),
                const Color(0xFF006948),
              ),
              const SizedBox(width: 10),
              _fleetMiniCard(
                'mahmoud',
                tr('محمود الخالد', 'Mahmoud Al-Khaled'),
                tr('استراحة غداء', 'Lunch Break'),
                const Color(0xFF565E74),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _fleetMiniCard(
    String key,
    String name,
    String subtitle,
    Color statusColor,
  ) {
    return GestureDetector(
      onTap: () => setState(() => _selectedDriverKey = key),
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: _selectedDriverKey == key
              ? Border.all(color: const Color(0xFF006194), width: 2)
              : null,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 6),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: const Color(0xFFE5EEFF),
                  child: Text(
                    name.isNotEmpty ? name.substring(0, 1) : '',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
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
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 10,
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${tr('البطارية', 'Battery')}: 92%',
                  style: const TextStyle(fontSize: 10, color: Color(0xFF707881)),
                ),
                Text(
                  '${tr('السرعة', 'Speed')}: 35 km/h',
                  style: const TextStyle(fontSize: 10, color: Color(0xFF707881)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
