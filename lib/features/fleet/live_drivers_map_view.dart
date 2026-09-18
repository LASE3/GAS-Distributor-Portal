import 'package:flutter/material.dart';
import '../../core/localization/app_locale.dart';
import '../../core/routes/app_routes.dart';
import '../../core/widgets/portal_bottom_nav.dart';

class LiveDriversMapView extends StatefulWidget {
  const LiveDriversMapView({super.key});

  @override
  State<LiveDriversMapView> createState() => _LiveDriversMapViewState();
}

class _LiveDriversMapViewState extends State<LiveDriversMapView> {
  String _selectedFilter = 'all';
  String _selectedDriver = 'omar'; // 'omar' or 'ahmad'
  bool _showToast = false;
  String _toastMessage = '';

  void _triggerToast(String message) {
    setState(() {
      _toastMessage = message;
      _showToast = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: AppBar(
            leading: IconButton(
              icon: Icon(
                isAr ? Icons.arrow_back : Icons.arrow_back,
                color: const Color(0xFF0B1C30),
              ),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            backgroundColor: const Color(0xFFF8F9FF).withValues(alpha: 0.85),
            elevation: 0,
            flexibleSpace: ClipRect(
              child: Container(
                color: const Color(0xFFF8F9FF).withValues(alpha: 0.85),
              ),
            ),
            title: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.local_shipping,
                    color: Color(0xFF006194),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              tr('خريطة السائقين اللحظية', 'Live Drivers Map'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
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
                                    fontSize: 10,
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
                          fontWeight: FontWeight.w600,
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
              const SizedBox(width: 8),
            ],
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Sync & Vehicle count banner
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD3E4FE).withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
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
                              const SizedBox(width: 6),
                              Text(
                                tr('مزامنة GPS حية (منذ 5 ثوانٍ)', 'Live GPS Sync (5s ago)'),
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0B1C30),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(9999),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.satellite_alt,
                                size: 16,
                                color: Color(0xFF006948),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                tr('8 مركبات متصلة', '8 Connected Vehicles'),
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF3F4850),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Filter Chips
                  SizedBox(
                    height: 44,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildFilterChip('all', tr('الكل', 'All'), '8'),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          'available',
                          tr('متاح', 'Available'),
                          '4',
                          color: const Color(0xFF006948),
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          'in-transit',
                          tr('في توصيل', 'Delivering'),
                          '3',
                          color: Colors.amber[800],
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          'offline',
                          tr('استراحة/غير متصل', 'Break/Offline'),
                          '1',
                          color: const Color(0xFF565E74),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Map Canvas Container
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 320,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5EEFF),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          // Background styled map
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF006194).withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          // Top location status card
                          Positioned(
                            top: 12,
                            right: isAr ? 12 : null,
                            left: isAr ? null : 12,
                            child: Column(
                              crossAxisAlignment: isAr
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.95),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.signpost,
                                        size: 16,
                                        color: Color(0xFF006194),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        tr('خلدا - شارع وصفي التل', 'Khalda - Wasfi Al-Tal St.'),
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
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.95),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.speed,
                                        size: 12,
                                        color: Color(0xFF565E74),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        tr('حركة السير: سلسة نسبياً', 'Traffic: Smooth Flow'),
                                        style: const TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 10,
                                          color: Color(0xFF3F4850),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Map Zoom Controls
                          Positioned(
                            bottom: 12,
                            right: isAr ? 12 : null,
                            left: isAr ? null : 12,
                            child: Column(
                              children: [
                                _buildMapButton(Icons.add, () {}),
                                const SizedBox(height: 4),
                                _buildMapButton(Icons.remove, () {}),
                                const SizedBox(height: 6),
                                _buildMapButton(
                                  Icons.my_location,
                                  () => _triggerToast(
                                    tr('تم تحديد موقع المستودع المركزي', 'Central depot location centered'),
                                  ),
                                  isPrimary: true,
                                ),
                              ],
                            ),
                          ),
                          // Main Depot Marker
                          Positioned(
                            top: 100,
                            right: isAr ? 80 : null,
                            left: isAr ? null : 80,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF006194),
                                    borderRadius: BorderRadius.circular(9999),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.warehouse,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        tr('المستودع الرئيسي', 'Main Depot'),
                                        style: const TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF006194),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.propane_tank,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Available Driver (Ahmad)
                          Positioned(
                            top: 60,
                            right: isAr ? 180 : null,
                            left: isAr ? null : 180,
                            child: InkWell(
                              onTap: () =>
                                  setState(() => _selectedDriver = 'ahmad'),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: const Color(0xFF006948),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          tr('أحمد', 'Ahmad'),
                                          style: const TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF006948),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          tr('0.8 كم', '0.8 km'),
                                          style: const TextStyle(
                                            fontFamily: 'Tajawal',
                                            fontSize: 9,
                                            color: Color(0xFF3F4850),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF006948),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.local_shipping,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // In-Transit Driver (Omar)
                          Positioned(
                            bottom: 60,
                            left: isAr ? 120 : null,
                            right: isAr ? null : 120,
                            child: InkWell(
                              onTap: () =>
                                  setState(() => _selectedDriver = 'omar'),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.amber[600],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          tr('عمر الزعبي', 'Omar Al-Zoubi'),
                                          style: const TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        const Icon(
                                          Icons.navigation,
                                          size: 12,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.amber[600],
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.local_shipping,
                                          size: 22,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Container(
                                        width: 16,
                                        height: 16,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF006948),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            '8',
                                            style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Dynamic Selected Driver Card Details
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: _selectedDriver == 'omar'
                          ? _buildOmarCard()
                          : _buildAhmadCard(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Fleet Status Strip Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tr('أسطول التوزيع السريع', 'Express Distribution Fleet'),
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0B1C30),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoutes.fleet);
                          },
                          child: Text(
                            tr('عرض الجدول الكامل', 'View Full Roster'),
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
                  ),
                  const SizedBox(height: 8),

                  // Fleet Mini Cards Horizontal Scroll
                  SizedBox(
                    height: 104,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildMiniDriverCard(
                          tr('عمر الزعبي', 'Omar Al-Zoubi'),
                          tr('توصيل دابوق', 'Dabouq Delivery'),
                          '92%',
                          tr('35 كم/س', '35 km/h'),
                          tr('قوي', 'Strong'),
                          '9/12',
                          Colors.amber[800]!,
                          onTap: () => setState(() => _selectedDriver = 'omar'),
                        ),
                        const SizedBox(width: 8),
                        _buildMiniDriverCard(
                          tr('أحمد العبادي', 'Ahmad Al-Abbadi'),
                          tr('متاح بالقرب', 'Available Nearby'),
                          '88%',
                          tr('متوقف', 'Stopped'),
                          tr('ممتاز', 'Excellent'),
                          '14/15',
                          const Color(0xFF006948),
                          onTap: () => setState(() => _selectedDriver = 'ahmad'),
                        ),
                        const SizedBox(width: 8),
                        _buildMiniDriverCard(
                          tr('محمود الخالد', 'Mahmoud Al-Khaled'),
                          tr('استراحة غداء', 'Lunch Break'),
                          '64%',
                          tr('0 كم/س', '0 km/h'),
                          tr('قوي', 'Strong'),
                          '11/11',
                          const Color(0xFF565E74),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Toast Notification
            if (_showToast)
              Positioned(
                top: 20,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF006194),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 8),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
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
          ],
        ),
        bottomNavigationBar: const PortalBottomNav(currentIndex: 2),
      ),
    );
  }

  Widget _buildFilterChip(
    String key,
    String label,
    String count, {
    Color? color,
  }) {
    bool isSelected = _selectedFilter == key;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF006194) : Colors.white,
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
            ),
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
                    ? Colors.white.withValues(alpha: 0.2)
                    : const Color(0xFFE5EEFF),
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

  Widget _buildMapButton(
    IconData icon,
    VoidCallback onPressed, {
    bool isPrimary = false,
  }) {
    return SizedBox(
      width: 32,
      height: 32,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? const Color(0xFFDCE9FF) : Colors.white,
          foregroundColor: isPrimary
              ? const Color(0xFF006194)
              : const Color(0xFF0B1C30),
          padding: EdgeInsets.zero,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }

  Widget _buildOmarCard() {
    return Container(
      key: const ValueKey('omar'),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            tr('عمر الزعبي', 'Omar Al-Zoubi'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0B1C30),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            tr('كابتن مميز', 'Featured Captain'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 10,
                              color: Color(0xFF5C647A),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        tr('شاحنة هينو ديزل • لوحة 12-48201', 'Hino Diesel Truck • Plate 12-48201'),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      tr('طلب #2409', 'Order #2409'),
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB45309),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    tr('وصول متوقع: 6 دقائق', 'Est. Arrival: 6 mins'),
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
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B1C30),
                      ),
                    ),
                    Text(
                      tr('14.50 د.أ', '14.50 JOD'),
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 13,
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
                    fontSize: 12,
                    color: Color(0xFF3F4850),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildInventoryBadge(
                '8',
                tr('ممتلئة متبقية', 'Full Remaining'),
                const Color(0xFF006194),
              ),
              const SizedBox(width: 8),
              _buildInventoryBadge(
                '4',
                tr('فارغة مرتجعة', 'Empty Returned'),
                const Color(0xFF565E74),
              ),
              const SizedBox(width: 8),
              _buildInventoryBadge(
                '2',
                tr('ساعة غاز إيطالي', 'Regulators'),
                const Color(0xFF006948),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _triggerToast(
                    tr('جاري الاتصال بالكابتن عمر...', 'Calling Capt. Omar...'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006948),
                    foregroundColor: Colors.white,
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.call, size: 16),
                  label: Text(
                    tr('اتصال', 'Call'),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _triggerToast(
                    tr('جاري عرض مسار التوصيل المباشر...', 'Displaying live delivery route...'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006194),
                    foregroundColor: Colors.white,
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.route, size: 16),
                  label: Text(
                    tr('مسار', 'Route'),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.smartDispatch);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDAE2FD),
                    foregroundColor: const Color(0xFF0B1C30),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.add_task, size: 16),
                  label: Text(
                    tr('إسناد طلب', 'Assign Order'),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
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

  Widget _buildAhmadCard() {
    return Container(
      key: const ValueKey('ahmad'),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      color: const Color(0xFF006948).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, color: Color(0xFF006948)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            tr('أحمد العبادي', 'Ahmad Al-Abbadi'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0B1C30),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            tr('متاح بالقرب', 'Available Nearby'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 10,
                              color: Color(0xFF006948),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        tr('شاحنة #1 • خلدا', 'Truck #1 • Khalda'),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF85F8C4),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  tr('جاهز للإسناد', 'Ready to Assign'),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF002114),
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
                  tr('الموقع الحالي: بالقرب من دوار دابوق', 'Current: Near Dabouq Circle'),
                  style: const TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 12,
                    color: Color(0xFF0B1C30),
                  ),
                ),
                Text(
                  tr('البطارية: 88%', 'Battery: 88%'),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006948),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.smartDispatch);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF006194),
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            icon: const Icon(Icons.bolt, size: 16),
            label: Text(
              tr('إسناد طلب فوري للسائق أحمد', 'Instant Dispatch to Driver Ahmad'),
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryBadge(String count, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
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

  Widget _buildMiniDriverCard(
    String name,
    String status,
    String battery,
    String speed,
    String gps,
    String progress,
    Color statusColor, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 240,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.person, size: 14),
                      ),
                      const SizedBox(width: 6),
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
                                color: Color(0xFF0B1C30),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              status,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 9,
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
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
              children: [
                Expanded(child: _buildMiniMetric(tr('البطارية', 'Battery'), battery)),
                Expanded(child: _buildMiniMetric(tr('السرعة', 'Speed'), speed)),
                Expanded(child: _buildMiniMetric('GPS', gps)),
                Expanded(child: _buildMiniMetric(tr('الإنجاز', 'Done'), progress)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniMetric(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 8,
            color: Color(0xFF3F4850),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B1C30),
          ),
        ),
      ],
    );
  }
}
