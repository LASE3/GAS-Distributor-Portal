import 'package:flutter/material.dart';
import '../../core/localization/app_locale.dart';
import '../../core/routes/app_routes.dart';
import '../../core/widgets/portal_bottom_nav.dart';

class HomeOperationalDashboardInteractive extends StatefulWidget {
  final bool showAppBar;
  const HomeOperationalDashboardInteractive({super.key, this.showAppBar = true});

  @override
  State<HomeOperationalDashboardInteractive> createState() => _HomeOperationalDashboardInteractiveState();
}

class _HomeOperationalDashboardInteractiveState extends State<HomeOperationalDashboardInteractive> {
  bool _isDispatched = false;
  bool _isRestocked = false;

  @override
  Widget build(BuildContext context) {
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
              // 1. Operational Status Banner
              _buildStatusBanner(),
              const SizedBox(height: 12),

              // 2. Urgent Dispatch Alert
              if (!_isDispatched) _buildUrgentDispatchCard(),
              if (!_isDispatched) const SizedBox(height: 12),

              // 3. Key Operational KPI Cards (2x2 Grid)
              _buildKpiGrid(),
              const SizedBox(height: 12),

              // 4. Interactive Radar Map Module
              _buildRadarMapModule(),
              const SizedBox(height: 16),

              // 5. Quick Driver Status Strip
              _buildDriverStatusStrip(),
              const SizedBox(height: 12),

              // 6. Critical Hardware Stock Warning
              _buildStockWarningCard(),
              const SizedBox(height: 40),
            ],
          ),
        ),
        bottomNavigationBar: widget.showAppBar ? const PortalBottomNav(currentIndex: 0) : null,
      ),
    );
  }

  // --- 1. App Bar ---
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
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
            child: const Icon(Icons.local_shipping, color: Color(0xFF006194), size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      tr('لوحة العمليات المباشرة', 'Live Operations Dashboard'),
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B1C30),
                      ),
                    ),
                    const SizedBox(width: 8),
                    DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Color(0xFF85F8C4),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircleAvatar(radius: 3, backgroundColor: Color(0xFF006948)),
                            const SizedBox(width: 4),
                            Text(
                              tr('مباشر', 'LIVE'),
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
                    ),
                  ],
                ),
                Text(
                  tr('وكالة الأمانة لتوزيع الغاز - عمان', 'Al-Amanah Gas Distribution Agency - Amman'),
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
              icon: const Icon(Icons.notifications_outlined, color: Color(0xFF3F4850)),
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
                  style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- 2. Status Banner ---
  Widget _buildStatusBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
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
                  const CircleAvatar(radius: 4, backgroundColor: Color(0xFF006948)),
                  const SizedBox(width: 8),
                  Text(
                    tr('حالة الوكالة: جاهزية تامة', 'Agency Status: Fully Ready'),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5EEFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  tr('07:00 ص - 10:00 م', '07:00 AM - 10:00 PM'),
                  style: const TextStyle(fontFamily: 'Tajawal', fontSize: 11, color: Color(0xFF3F4850)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.alt_route, size: 16, color: Color(0xFF006194)),
                  const SizedBox(width: 4),
                  Text(
                    tr('قطاع عمان الغربية (خلدا، تلاع العلي، دابوق)', 'West Amman (Khalda, Tlaa Al-Ali, Dabouq)'),
                    style: const TextStyle(fontFamily: 'Tajawal', fontSize: 13, color: Color(0xFF3F4850)),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF85F8C4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  tr('الضغط: معتدل', 'Load: Moderate'),
                  style: const TextStyle(fontFamily: 'Cairo', fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF002114)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 3. Urgent Dispatch Alert ---
  Widget _buildUrgentDispatchCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFDAD6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.priority_high, color: Color(0xFFBA1A1A), size: 22),
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
                      style: const TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFBA1A1A)),
                    ),
                    Text(
                      tr('منذ 4 دقائق', '4m ago'),
                      style: const TextStyle(fontFamily: 'Tajawal', fontSize: 11, color: Color(0xFF707881)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  tr('حي الجامعة، تلاع العلي • أسطوانتين 12.5 كغ + ساعة ضغط', 'University District, Tlaa Al-Ali • 2x 12.5kg + Regulator'),
                  style: const TextStyle(fontFamily: 'Tajawal', fontSize: 12, color: Color(0xFF0B1C30)),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF006194),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          setState(() {
                            _isDispatched = true;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                tr('تم إسناد الطلب للسائق بنجاح', 'Order dispatched to driver successfully'),
                                style: const TextStyle(fontFamily: 'Cairo'),
                              ),
                              backgroundColor: const Color(0xFF006948),
                            ),
                          );
                        },
                        icon: const Icon(Icons.bolt, size: 16),
                        label: Text(
                          tr('إسناد فوري للسائق الأقرب (1.2 كم)', 'Instant assign to nearest driver (1.2 km)'),
                          style: const TextStyle(fontFamily: 'Cairo', fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFFDCE9FF),
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.orderDetails);
                      },
                      child: Text(
                        tr('تفاصيل', 'Details'),
                        style: const TextStyle(fontFamily: 'Cairo', fontSize: 11, color: Color(0xFF006194)),
                      ),
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

  // --- 4. KPI Grid ---
  Widget _buildKpiGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.4,
      children: [
        _buildKpiCard(
          tr('الطلبات النشطة', 'Active Orders'),
          '14',
          tr('طلب', 'orders'),
          tr('11 توصيل • 3 بالانتظار', '11 En Route • 3 Queued'),
          Icons.local_fire_department,
          const Color(0xFFCCE5FF),
          const Color(0xFF006194),
        ),
        _buildKpiCard(
          tr('السائقون', 'Active Drivers'),
          '5/8',
          tr('متاحين', 'available'),
          tr('3 في مسار التوصيل', '3 on delivery route'),
          Icons.sports_motorsports,
          const Color(0xFFDAE2FD),
          const Color(0xFF006948),
        ),
        _buildKpiCard(
          tr('المخزون الجاهز', 'Ready Stock'),
          '142',
          tr('أسطوانة', 'cylinders'),
          tr('الحد التشغيلي آمن', 'Safe Operating Level'),
          Icons.propane_tank,
          const Color(0xFFDAE2FD),
          const Color(0xFF565E74),
        ),
        _buildKpiCard(
          tr('إنجاز اليوم', 'Today Accomplished'),
          '68',
          tr('مكتمل', 'done'),
          tr('التحصيل: 612 د.أ', 'Revenue: 612 JOD'),
          Icons.payments,
          const Color(0xFFE5EEFF),
          const Color(0xFF0B1C30),
        ),
      ],
    );
  }

  Widget _buildKpiCard(String title, String value, String unit, String subtitle, IconData icon, Color iconBg, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
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
              Text(title, style: const TextStyle(fontFamily: 'Tajawal', fontSize: 12, color: Color(0xFF3F4850))),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
                child: Icon(icon, color: iconColor, size: 16),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: const TextStyle(fontFamily: 'Cairo', fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30))),
              const SizedBox(width: 4),
              Text(unit, style: const TextStyle(fontFamily: 'Tajawal', fontSize: 11, color: Color(0xFF707881))),
            ],
          ),
          Text(subtitle, style: TextStyle(fontFamily: 'Tajawal', fontSize: 11, color: iconColor, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  // --- 5. Radar Map Module ---
  Widget _buildRadarMapModule() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
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
                  const Icon(Icons.explore, color: Color(0xFF006194), size: 20),
                  const SizedBox(width: 8),
                  Text(
                    tr('رادار الأسطول الميداني', 'Field Fleet Radar'),
                    style: const TextStyle(fontFamily: 'Cairo', fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30)),
                  ),
                ],
              ),
              Text(
                tr('تحديث كل 5 ثوانٍ', 'Updates every 5s'),
                style: const TextStyle(fontFamily: 'Tajawal', fontSize: 11, color: Color(0xFF707881)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: const Color(0xFFDCE9FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.warehouse, size: 36, color: Color(0xFF213145)),
                      const SizedBox(height: 4),
                      Text(
                        tr('مستودع خلدا', 'Khalda Depot'),
                        style: const TextStyle(fontFamily: 'Cairo', fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white, backgroundColor: Color(0xAA213145)),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 40,
                  child: _mapPin(tr('102 - متاح', '102 - Ready'), const Color(0xFF006948)),
                ),
                Positioned(
                  bottom: 20,
                  left: 60,
                  child: _mapPin(tr('105 - توصيل', '105 - En Route'), const Color(0xFF006194)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFDCE9FF),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.liveDriversMap);
              },
              icon: const Icon(Icons.map, color: Color(0xFF006194), size: 18),
              label: Text(
                tr('فتح خريطة التتبع الكاملة المباشرة', 'Open Full Live Tracking Map'),
                style: const TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Color(0xFF006194), fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mapPin(String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)]),
          child: const Icon(Icons.local_shipping, size: 12, color: Colors.white),
        ),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)),
          child: Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
        ),
      ],
    );
  }

  // --- 6. Quick Driver Status Strip ---
  Widget _buildDriverStatusStrip() {
    final List<Map<String, dynamic>> drivers = [
      {
        'name': tr('أحمد العبادي', 'Ahmad Abbadi'),
        'truck': tr('شاحنة #1 • خلدا', 'Truck #1 • Khalda'),
        'status': tr('متاح (12 أسطوانة)', 'Ready (12 Cyl.)'),
        'color': const Color(0xFF006948),
        'bg': const Color(0xFF85F8C4),
        'rate': '4.9',
      },
      {
        'name': tr('عمر الزعبي', 'Omar Zoubi'),
        'truck': tr('شاحنة #2 • الجبيهة', 'Truck #2 • Jubeiha'),
        'status': tr('توصيل #2408', 'Delivering #2408'),
        'color': const Color(0xFF006194),
        'bg': const Color(0xFFCCE5FF),
        'rate': '4.7',
      },
      {
        'name': tr('طارق المناصير', 'Tareq Manaseer'),
        'truck': tr('شاحنة #3 • دابوق', 'Truck #3 • Dabouq'),
        'status': tr('متاح (8 أسطوانات)', 'Ready (8 Cyl.)'),
        'color': const Color(0xFF006948),
        'bg': const Color(0xFF85F8C4),
        'rate': '4.8',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr('كفاءة الأسطول السريع', 'Quick Fleet Status'),
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.fleet);
              },
              child: Text(
                tr('عرض الكل (8)', 'View All (8)'),
                style: const TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Color(0xFF006194), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: drivers.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final d = drivers[index];
              final String name = d['name'] as String;
              final String truck = d['truck'] as String;
              final String status = d['status'] as String;
              final String rate = d['rate'] as String;
              final Color color = d['color'] as Color;
              final Color bg = d['bg'] as Color;

              return Container(
                width: 180,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
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
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: const Color(0xFFE5EEFF),
                          child: Text(
                            name.isNotEmpty ? name.substring(0, 1) : '',
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF006194)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name, style: const TextStyle(fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                              Text(truck, style: const TextStyle(fontFamily: 'Tajawal', fontSize: 9, color: Color(0xFF707881)), overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
                          child: Text(status, style: TextStyle(fontFamily: 'Cairo', fontSize: 9, color: color, fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          children: [
                            Text(rate, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                            const Icon(Icons.star, size: 12, color: Color(0xFF565E74)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // --- 7. Critical Hardware Stock Warning ---
  Widget _buildStockWarningCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFFFFDAD6), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.warning_amber, color: Color(0xFFBA1A1A), size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('ساعات غاز إيطالي أصلية', 'Genuine Italian Gas Regulators'),
                    style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    tr('متبقي 6 قطع فقط (الحد الأدنى 10)', 'Only 6 units left (Threshold: 10)'),
                    style: const TextStyle(fontFamily: 'Tajawal', fontSize: 11, color: Color(0xFFBA1A1A)),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _isRestocked ? const Color(0xFF85F8C4) : const Color(0xFFDCE9FF),
              foregroundColor: _isRestocked ? const Color(0xFF002114) : const Color(0xFF006194),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onPressed: _isRestocked ? null : () {
              setState(() {
                _isRestocked = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    tr('تم إرسال طلب تزويد المستودع للمصفاة', 'Refinery restock request dispatched successfully'),
                    style: const TextStyle(fontFamily: 'Cairo'),
                  ),
                  backgroundColor: const Color(0xFF006948),
                ),
              );
            },
            child: Text(
              _isRestocked ? tr('تم إرسال الطلب ✓', 'Request Sent ✓') : tr('طلب تزويد', 'Restock Request'),
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
