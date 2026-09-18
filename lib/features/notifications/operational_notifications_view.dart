import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/localization/app_locale.dart';
import '../../core/widgets/portal_bottom_nav.dart';

class OperationalNotificationsView extends StatefulWidget {
  final bool showAppBar;
  const OperationalNotificationsView({super.key, this.showAppBar = true});

  @override
  State<OperationalNotificationsView> createState() =>
      _OperationalNotificationsViewState();
}

class _OperationalNotificationsViewState
    extends State<OperationalNotificationsView> {
  String _selectedFilter = 'all';
  bool _allMarkedRead = false;
  int _unreadCount = 4;
  bool _showToast = false;
  String _toastMessage = '';
  Timer? _toastTimer;

  // Preferences State
  String _selectedTone = 'siren'; // 'siren', 'chime', 'horn'
  bool _vibrationEnabled = true;
  bool _smsEnabled = true;
  bool _highPriorityPush = true;

  @override
  void dispose() {
    _toastTimer?.cancel();
    super.dispose();
  }

  void _triggerToast(String message) {
    _toastTimer?.cancel();
    setState(() {
      _toastMessage = message;
      _showToast = true;
    });
    _toastTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showToast = false;
        });
      }
    });
  }

  void _markAllRead() {
    setState(() {
      _allMarkedRead = true;
      _unreadCount = 0;
    });
    _triggerToast(
      tr('تم تحديد جميع التنبيهات كمقروءة', 'All alerts marked as read'),
    );
  }

  void _showPreferencesModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final isAr = LocaleNotifier.instance.isArabic;
            return Directionality(
              textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
              child: Material(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: SafeArea(
                  top: false,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.tune,
                                    color: Color(0xFF006194),
                                    size: 22,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      tr('تخصيص نغمات وتفضيلات التنبيهات', 'Alert Tones & Notification Preferences'),
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0B1C30),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          tr('اختر نغمة التنبيه للطوارئ:', 'Select Emergency Alert Tone:'),
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3F4850),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: [
                            ChoiceChip(
                              label: Text(tr('صفارة إنذار عالية', 'High Siren')),
                              selected: _selectedTone == 'siren',
                              selectedColor: const Color(0xFF006194),
                              labelStyle: TextStyle(
                                fontFamily: 'Cairo',
                                color: _selectedTone == 'siren' ? Colors.white : const Color(0xFF0B1C30),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              onSelected: (val) {
                                setModalState(() => _selectedTone = 'siren');
                                setState(() => _selectedTone = 'siren');
                              },
                            ),
                            ChoiceChip(
                              label: Text(tr('جرس تنبيه حديث', 'Subtle Chime')),
                              selected: _selectedTone == 'chime',
                              selectedColor: const Color(0xFF006194),
                              labelStyle: TextStyle(
                                fontFamily: 'Cairo',
                                color: _selectedTone == 'chime' ? Colors.white : const Color(0xFF0B1C30),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              onSelected: (val) {
                                setModalState(() => _selectedTone = 'chime');
                                setState(() => _selectedTone = 'chime');
                              },
                            ),
                            ChoiceChip(
                              label: Text(tr('بوق قياسي', 'Standard Horn')),
                              selected: _selectedTone == 'horn',
                              selectedColor: const Color(0xFF006194),
                              labelStyle: TextStyle(
                                fontFamily: 'Cairo',
                                color: _selectedTone == 'horn' ? Colors.white : const Color(0xFF0B1C30),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              onSelected: (val) {
                                setModalState(() => _selectedTone = 'horn');
                                setState(() => _selectedTone = 'horn');
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: () {
                            _triggerToast(
                              tr(
                                '🔊 جاري تجربة نغمة التنبيه المحددة على مكبر الصوت...',
                                '🔊 Testing selected alert tone on speaker...',
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF006194),
                            side: const BorderSide(color: Color(0xFF006194)),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          icon: const Icon(Icons.volume_up, size: 18),
                          label: Text(
                            tr('تجربة صوت نغمة التنبيه', 'Test Alert Siren Sound'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Divider(height: 28),
                        _buildPreferenceSwitchRow(
                          title: tr('الاهتزاز عند استلام طوارئ حرجة', 'Haptic Vibration on Critical Alert'),
                          subtitle: tr('اهتزاز مستمر حتى يتم فتح التنبيه', 'Continuous vibration until alert opened'),
                          value: _vibrationEnabled,
                          onChanged: (val) {
                            setModalState(() => _vibrationEnabled = val);
                            setState(() => _vibrationEnabled = val);
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildPreferenceSwitchRow(
                          title: tr('إشعارات فورية عالية الأولوية', 'High-Priority Push Notifications'),
                          subtitle: tr('ظهور التنبيه فوق التطبيقات الأخرى', 'Display banner over other active apps'),
                          value: _highPriorityPush,
                          onChanged: (val) {
                            setModalState(() => _highPriorityPush = val);
                            setState(() => _highPriorityPush = val);
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildPreferenceSwitchRow(
                          title: tr('رسائل SMS فورية لحالات تسريب الغاز', 'SMS Alerts for Critical Gas Leaks'),
                          subtitle: tr('إرسال نسخة نصية لهاتف المشرف المناوب', 'Send copy to on-duty supervisor phone'),
                          value: _smsEnabled,
                          onChanged: (val) {
                            setModalState(() => _smsEnabled = val);
                            setState(() => _smsEnabled = val);
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _triggerToast(
                              tr(
                                'تم حفظ إعدادات ونغمات التنبيهات بنجاح',
                                'Notification preferences saved successfully',
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF006194),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            tr('حفظ التفضيلات', 'Save Preferences'),
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
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPreferenceSwitchRow({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0B1C30),
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 11,
                  color: Color(0xFF707881),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Switch(
          value: value,
          activeColor: const Color(0xFF006194),
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAr = LocaleNotifier.instance.isArabic;
    return Directionality(
      textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FF),
        appBar: widget.showAppBar ? _buildAppBar() : null,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Operational Header & KPIs
                  _buildHeaderSection(),
                  const SizedBox(height: 16),

                  // 2. Filter Tabs Rail
                  _buildFilterRail(),
                  const SizedBox(height: 16),

                  // 3. Notification Feed Stream
                  _buildNotificationFeed(),

                  // 4. Bottom Preference Action
                  _buildFooterSection(),
                  const SizedBox(height: 24),
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
                            Icons.check_circle_outline,
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
        bottomNavigationBar: widget.showAppBar ? const PortalBottomNav(currentIndex: 0) : null,
      ),
    );
  }

  // --- AppBar (Profile Avatar Removed as requested) ---
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF8F9FF).withValues(alpha: 0.95),
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
              color: const Color(0xFF007BB9).withValues(alpha: 0.1),
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
                    Text(
                      tr('مركز التنبيهات', 'Alerts Center'),
                      style: const TextStyle(
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
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFF006194),
                              shape: BoxShape.circle,
                            ),
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
                _triggerToast(
                  tr(
                    'لديك $_unreadCount تنبيهات تشغيلية نشطة تتطلب المتابعة',
                    'You have $_unreadCount active operational alerts pending',
                  ),
                );
              },
              icon: const Icon(
                Icons.notifications,
                color: Color(0xFF006194),
              ),
            ),
            if (_unreadCount > 0)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFBA1A1A),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$_unreadCount',
                    style: const TextStyle(
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

  // --- Header & KPIs ---
  Widget _buildHeaderSection() {
    return Padding(
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
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFFBA1A1A),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    tr('التنبيهات التشغيلية اللحظية', 'Operational Real-Time Alerts'),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (!_allMarkedRead && _unreadCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFDAD6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tr('$_unreadCount جديدة', '$_unreadCount New'),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF93000A),
                        ),
                      ),
                    ),
                ],
              ),
              TextButton.icon(
                onPressed: _markAllRead,
                icon: const Icon(Icons.done_all, size: 16, color: Color(0xFF006194)),
                label: Text(
                  tr('تحديد الكل كمقروء', 'Mark all read'),
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
          const SizedBox(height: 6),
          Text(
            tr(
              'متابعة فورية لسلامة الشبكة، شكاوى تسريب الغاز، حركات المستودع، ونشاط الأسطول في عمان الغربية.',
              'Real-time tracking of network safety, gas leak alerts, inventory moves, and fleet activity in West Amman.',
            ),
            style: const TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 12,
              color: Color(0xFF707881),
            ),
          ),
          const SizedBox(height: 16),
          // Metric Summary Cards
          Row(
            children: [
              Expanded(
                child: _buildMetricTile(
                  label: tr('حالات حرجة', 'Critical'),
                  count: '1',
                  color: const Color(0xFFBA1A1A),
                  bgColor: const Color(0xFFFFDAD6).withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildMetricTile(
                  label: tr('تنبيهات الأسطول', 'Fleet Alerts'),
                  count: '2',
                  color: const Color(0xFF006194),
                  bgColor: const Color(0xFFDAE2FD).withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildMetricTile(
                  label: tr('مجدولة لليوم', 'Scheduled'),
                  count: '9',
                  color: const Color(0xFF006948),
                  bgColor: const Color(0xFFD3E4FE).withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricTile({
    required String label,
    required String count,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            count,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // --- Filter Rail ---
  Widget _buildFilterRail() {
    final filters = [
      {'key': 'all', 'label': tr('الكل', 'All'), 'count': '12'},
      {'key': 'emergency', 'label': tr('طوارئ وتسريب', 'Emergencies'), 'count': '1'},
      {'key': 'stock', 'label': tr('نقص المخزون', 'Low Stock'), 'count': '2'},
      {'key': 'orders', 'label': tr('طلبات جديدة', 'New Orders'), 'count': '3'},
      {'key': 'fleet', 'label': tr('تنبيهات السائقين', 'Driver Alerts'), 'count': '4'},
    ];

    return SizedBox(
      height: 40,
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
                Text(f['label']!),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.25)
                        : const Color(0xFF006194).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    f['count']!,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : const Color(0xFF006194),
                    ),
                  ),
                ),
              ],
            ),
            selectedColor: const Color(0xFF006194),
            backgroundColor: const Color(0xFFE5EEFF),
            labelStyle: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              color: isSelected ? Colors.white : const Color(0xFF3F4850),
              fontWeight: FontWeight.bold,
            ),
            onSelected: (_) {
              setState(() {
                _selectedFilter = f['key']!;
              });
            },
          );
        },
      ),
    );
  }

  // --- Notification Feed Stream ---
  Widget _buildNotificationFeed() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // 1. Critical Emergency Alert
          if (_selectedFilter == 'all' || _selectedFilter == 'emergency')
            _buildNotificationCard(
              borderColor: const Color(0xFFBA1A1A),
              badgeColor: const Color(0xFFBA1A1A),
              badgeText: tr('طوارئ سلامة حرجة', 'Critical Safety Alert'),
              title: tr('شكوى تسريب غاز عاجلة', 'Urgent Gas Leak Complaint'),
              time: tr('منذ 4 دقائق', '4 mins ago'),
              content: tr(
                'عمارة اليرموك، شقة 4 - خلدا. العميل أبلغ عن انبعاث رائحة غاز نفاذة بعد استبدال أسطوانة المطبخ بـ 15 دقيقة. تم التنبيه بإخلاء المحيط وعدم تشغيل الإنارة.',
                'Yarmouk Bldg, Apt 4 - Khilda. Customer reported strong gas odor 15 mins after cylinder replacement. Evacuate vicinity and do not turn on switches.',
              ),
              icon: Icons.crisis_alert,
              iconBg: const Color(0xFFFFDAD6),
              iconColor: const Color(0xFF93000A),
              footerWidget: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFBA1A1A),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        _triggerToast(
                          tr(
                            'تم توجيه فني الطوارئ كابتن طارق لموقع العميل في خلدا (وصول 6 دقائق)',
                            'Emergency Tech Capt. Tariq dispatched to customer in Khalda (ETA 6 mins)',
                          ),
                        );
                      },
                      icon: const Icon(Icons.fmd_bad, size: 16),
                      label: Text(
                        tr('توجيه فني طوارئ ميداني', 'Dispatch Emergency Tech'),
                        style: const TextStyle(fontFamily: 'Cairo', fontSize: 11),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFDAD6),
                      foregroundColor: const Color(0xFF93000A),
                    ),
                    onPressed: () {
                      _triggerToast(
                        tr('جاري الاتصال برقم طوارئ العميل 0798765432...', 'Calling emergency customer 0798765432...'),
                      );
                    },
                    icon: const Icon(Icons.call, size: 16),
                    label: Text(
                      tr('اتصال', 'Call'),
                      style: const TextStyle(fontFamily: 'Cairo', fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),

          // 2. Low Stock Depletion Alert
          if (_selectedFilter == 'all' || _selectedFilter == 'stock')
            _buildNotificationCard(
              borderColor: Colors.amber.shade700,
              badgeColor: Colors.amber.shade800,
              badgeText: tr('هبوط أمان المستودع', 'Warehouse Safety Warning'),
              title: tr('مخزون أسطوانات الغاز 12.5 كغ', 'Gas Cylinders 12.5 kg Stock'),
              time: tr('منذ 18 دقيقة', '18 mins ago'),
              content: tr(
                'المستودع المركزي - بيادر وادي السير: الرصيد الحالي 18 أسطوانة ممتلئة فقط، متجاوزاً خط الأمان الأدنى المعتمد (25 أسطوانة).',
                'Central Depot - Bayader Wadi Seer: Current balance is only 18 full cylinders, below the safety threshold (25 cylinders).',
              ),
              icon: Icons.inventory_2,
              iconBg: const Color(0xFFD3E4FE),
              iconColor: Colors.amber.shade800,
              footerWidget: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006194),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  _triggerToast(
                    tr(
                      'تم إرسال طلب توريد عاجل (500 أسطوانة) إلى مصفاة البترول الأردنية',
                      'Urgent supply order (500 cylinders) sent to Jordan Petroleum Refinery',
                    ),
                  );
                },
                icon: const Icon(Icons.local_shipping, size: 16),
                label: Text(
                  tr('طلب توريد مصفاة البترول عاجل', 'Urgent Refinery Supply Order'),
                  style: const TextStyle(fontFamily: 'Cairo', fontSize: 11),
                ),
              ),
            ),
          const SizedBox(height: 12),

          // 3. Driver GPS Disconnection
          if (_selectedFilter == 'all' || _selectedFilter == 'fleet')
            _buildNotificationCard(
              borderColor: const Color(0xFF565E74),
              badgeColor: const Color(0xFF565E74),
              badgeText: tr('فقدان تتبع المركبة', 'Vehicle Tracking Lost'),
              title: tr('انقطاع GPS: شاحنة الكابتن خالد النجار', 'GPS Lost: Capt. Khaled Al-Najjar Truck'),
              time: tr('منذ 12 دقيقة', '12 mins ago'),
              content: tr(
                'شاحنة ميتسوبيشي كانتر رقم (14-8809) انقطع إرسال محدد الموقع في منطقة دابوق / بالقرب من إشارة المواصفات والمقاييس.',
                'Mitsubishi Canter truck #14-8809 GPS transmission lost in Dabouq / near Metrology signal.',
              ),
              icon: Icons.gps_off,
              iconBg: const Color(0xFFDAE2FD),
              iconColor: const Color(0xFF565E74),
              footerWidget: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF565E74),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  _triggerToast(
                    tr('جاري الاتصال اللاسلكي بالسائق خالد النجار...', 'Radio calling driver Khaled Al-Najjar...'),
                  );
                },
                icon: const Icon(Icons.phone_in_talk, size: 16),
                label: Text(
                  tr('اتصال مباشر بالسائق', 'Direct Call to Driver'),
                  style: const TextStyle(fontFamily: 'Cairo', fontSize: 11),
                ),
              ),
            ),
          const SizedBox(height: 12),

          // 4. Commercial Order
          if (_selectedFilter == 'all' || _selectedFilter == 'orders')
            _buildNotificationCard(
              borderColor: const Color(0xFF006194),
              badgeColor: const Color(0xFF006194),
              badgeText: tr('طلب تجاري ضخم', 'Large Commercial Order'),
              title: tr('مطاعم جبري المركزية #ORD-2420', 'Jabri Central Restaurants #ORD-2420'),
              time: tr('منذ 25 دقيقة', '25 mins ago'),
              content: tr(
                'طلب توريد دوري: 25 أسطوانة صناعية 50 كغ + 4 منظمات ضغط عالي مع خراطيم نحاسية آمنة. شارع وصفي التل.',
                'Periodic supply order: 25 industrial 50kg cylinders + 4 high-pressure regulators with copper safety hoses. Wasfi Al-Tal St.',
              ),
              icon: Icons.storefront,
              iconBg: const Color(0xFFD3E4FE),
              iconColor: const Color(0xFF006194),
              footerWidget: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006194),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  _triggerToast(
                    tr('تم إسناد الطلب التجاري بنجاح للشاحنة الثقيلة #07', 'Commercial order successfully assigned to Heavy Truck #07'),
                  );
                },
                icon: const Icon(Icons.assignment_ind, size: 16),
                label: Text(
                  tr('إسناد لشاحنة ثقيلة (كابتن تيسير)', 'Assign to Heavy Truck (Capt. Tayseer)'),
                  style: const TextStyle(fontFamily: 'Cairo', fontSize: 11),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required Color borderColor,
    required Color badgeColor,
    required String badgeText,
    required String title,
    required String time,
    required String content,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required Widget footerWidget,
  }) {
    return Container(
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
        border: Border(right: BorderSide(color: borderColor, width: 4)),
      ),
      child: Padding(
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
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: iconBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: iconColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: badgeColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            badgeText,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: badgeColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          title,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 11,
                    color: Color(0xFF707881),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 13,
                color: Color(0xFF3F4850),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(width: double.infinity, child: footerWidget),
          ],
        ),
      ),
    );
  }

  // --- Footer Section ---
  Widget _buildFooterSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFFEFF4FF),
              foregroundColor: const Color(0xFF006194),
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide.none,
            ),
            onPressed: _showPreferencesModal,
            icon: const Icon(Icons.tune, size: 18),
            label: Text(
              tr('تخصيص نغمات وتفضيلات التنبيهات الفورية', 'Customize alert tones & notification preferences'),
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            tr(
              'وكالة النور للغاز • نظام تتبع السلامة اللوجستية الإصدار 3.4.1',
              'Al-Noor Gas Agency • Logistics Safety Tracking v3.4.1',
            ),
            style: const TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 10,
              color: Color(0xFF707881),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
