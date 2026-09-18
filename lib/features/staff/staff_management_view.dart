import 'package:flutter/material.dart';
import '../../core/localization/app_locale.dart';

class StaffManagementView extends StatefulWidget {
  final bool showAppBar;
  const StaffManagementView({super.key, this.showAppBar = true});

  @override
  State<StaffManagementView> createState() => _StaffManagementViewState();
}

class _StaffManagementViewState extends State<StaffManagementView> {
  String _selectedFilter = 'all';

  final List<Map<String, dynamic>> _users = [
    {
      'role': 'owner',
      'name': 'حاج توفيق النور',
      'title': 'مالك الوكالة (Agency Owner)',
      'badge': 'صلاحيات كاملة مطلقة (Super Admin)',
      'status': 'نشط الآن',
      'isOnline': true,
      'email': 't.alnoor@gas-portal.jo',
      'phone': '079-5001122',
      'phoneNote': 'خط الإدارة التنفيذية',
      'permissions': [
        'الإشراف المالي',
        'سحب الأرباح',
        'تفويض الصلاحيات',
        'تعديل العقود والمصفاة',
      ],
      'securityNote': 'مفتاح الحماية المزدوج (2FA) مفعل',
      'avatar': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCQKTXNxVImXx86kqTZoaZO6c1NGQUaPmRjjf6ypwMXUZX3BdW9Ia1haqL6cjwSJRgM2fSVXydHQPFN2oj78Snbb5mIKC3IqsRL5ui09lgAKqjp7scU-IXwNVBCMhq6ckRshBFTc9oTE1skIePCSdQit2kRykFa_rCOyZVNLqATjWpfNRtUxYrmRXec1w_TVAjsWqPmgzIz3soihSRrzRVownpU24uBIxC-428brImaH0_XSvTAX6xi',
    },
    {
      'role': 'manager',
      'name': 'م. سامي الخطيب',
      'title': 'مدير الوكالة (Agency Manager)',
      'badge': 'إدارة العمليات والمالية',
      'status': 'في العمل',
      'isOnline': true,
      'email': 's.khatib@gas-portal.jo',
      'phone': '079-6612984',
      'permissions': [
        'اعتماد الورديات',
        'تسوية الصندوق',
        'تعديل بيانات السائقين',
        'تقارير المصفاة',
      ],
      'avatar': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBuvwHBBCd4WGiCj3JhvabrO9r7ql2M3tP_64cMQlziY7HgUnrF7hPubI6-NItNLAG_bbAuKD79Rj7UOv5Z0TLb2NWQ_9fbF4LAn5dUIyT8C3vsgV77U7MZCvjd_aU4DolPi6A95YybnXUquj6ozwa48YK6k36M7MTy7Ee8dKRCWE57fvTRWLeDLbxzXTVrtRYWSPcorH3qjLJ7gh1nIyt5a3iWGkGexgMT1qG5e0Q9xviQXeXwoeEZ',
    },
    {
      'role': 'dispatcher',
      'name': 'يزن المجالي',
      'title': 'مسؤول الإسناد والتوجيه (Dispatcher)',
      'badge': 'الطلبات والميدان',
      'status': 'وردية صباحية',
      'isOnline': false,
      'email': 'y.majali@gas-portal.jo',
      'phone': '078-7714521',
      'permissions': [
        'إسناد الطلبات',
        'تتبع شاحنات GPS',
        'التواصل مع العملاء',
        'إدارة شكاوى التوصيل',
      ],
      'avatar': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAJESdywjCR9TN838QbXDtupOS4G4KHho1JW9D1WrxVl9n6DR81jvm3WBZ3HEwr4Z4jW3wGTCTXqzSxSHXyTjIrZyqCr-B_qmy-Yc2-VgQyjIDddSYFAFL0nhXm1zHzpVc9R7XNHDAnK0OCK7ZUro3gyHHGAJCQCqUImQ919iXzmozH5RxuSHHUgBR1k3W7RtNjeWlg-3gGSsDfaSEj-WlR-TdXSomSBbApQ7OjpymvPeMl4KzKZYR3',
    },
    {
      'role': 'inventory',
      'name': 'خالد العمري',
      'title': 'أمين المستودع المركزي (Inventory)',
      'badge': 'إدارة المخزون والمصفاة',
      'status': 'في المستودع',
      'isOnline': true,
      'email': 'k.omari@gas-portal.jo',
      'phone': '077-9923145',
      'permissions': [
        'استلام شحنات مصفاة البترول',
        'فحص الصمامات والأمان',
        'صرف عهدة الأسطوانات للورديات',
        'جرد التوالف والأسطوانات الصالحة',
      ],
      'avatar': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAwO9jJv7x7YfLYsCthuBYoiAmrcNyvSExtcEqk9bljpvSuGANaUvJDSEiV0QxGUmc-6ZgFh0FEIAIFNzQ_2hc2XqqvDw8hNz8G-nI-xe7qNoIpfCAX9HFbImaIP5l6l8ytb5aSrCjoOV0LbITk77xfoGARYuO9lAZM_Wx-IBtPNKv-EW0XfKIEXt74_U8d2KnQo_BjvuPBTVBLPIGNk7WgcDxTDPzmdcO6Zj1N9U400BhJHFu6fVU2',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isAr = LocaleNotifier.instance.isArabic;
    final filteredUsers = _users.where((user) {
      return _selectedFilter == 'all' || user['role'] == _selectedFilter;
    }).toList();

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
              // 1. Summary Banner with Telemetry Aura
              _buildSummaryBanner(),
              const SizedBox(height: 16),

              // 2. Role Filters Horizontal Bar
              _buildRoleFilters(),
              const SizedBox(height: 16),

              // 3. Primary Action Button: Add User
              _buildAddUserButton(),
              const SizedBox(height: 16),

              // 4. User Cards List
              ...filteredUsers.map(
                (user) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _buildUserCard(user),
                ),
              ),

              // 5. Security Audit Callout Box
              _buildSecurityAuditBox(),
              const SizedBox(height: 80), // Space for bottom nav
            ],
          ),
        ),
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
            child: const Icon(
              Icons.local_gas_station,
              color: Color(0xFF006194),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.agencyName,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF006194),
                ),
              ),
              Text(
                tr('إدارة فريق العمل والصلاحيات', 'Staff & Permissions Management'),
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B1C30),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: Color(0xFF3F4850),
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFBA1A1A),
                  shape: BoxShape.circle,
                ),
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

  // --- Summary Banner ---
  Widget _buildSummaryBanner() {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('وكالة النور • منظومة الأمان والرقابة', 'Al-Noor Agency • Security & Compliance'),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 11,
                      color: Color(0xFF006194),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tr('إدارة الطواقم والصلاحيات', 'Staff & Permissions Management'),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B1C30),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    tr('التحكم المركزي في صلاحيات نظام توزيع الغاز الميداني', 'Central management of permissions for gas operations'),
                    style: const TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 12,
                      color: Color(0xFF3F4850),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF006194).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.security,
                  color: Color(0xFF006194),
                  size: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF4FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.badge, color: Color(0xFF006948), size: 20),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '8',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            tr('موظفين معتمدين', 'Certified Staff'),
                            style: const TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 10,
                              color: Color(0xFF565E74),
                            ),
                          ),
                        ],
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
                  child: Row(
                    children: [
                      const Icon(
                        Icons.verified_user,
                        color: Color(0xFF006194),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '4',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            tr('أدوار تشغيلية', 'Operational Roles'),
                            style: const TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 10,
                              color: Color(0xFF565E74),
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
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 4, backgroundColor: Color(0xFF006948)),
                  const SizedBox(width: 6),
                  Text(
                    tr('بوابة الوكالة متصلة بالسيرفر الموحد', 'Agency connected to central server'),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 11,
                      color: Color(0xFF006948),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                tr('تحديث فوري (عمان)', 'Live Sync (Amman)'),
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

  // --- Role Filters ---
  Widget _buildRoleFilters() {
    final filters = [
      {'key': 'all', 'label': tr('كافة المستخدمين (8)', 'All Users (8)')},
      {'key': 'owner', 'label': tr('مالك الوكالة (Owner)', 'Owner')},
      {'key': 'manager', 'label': tr('مدير العمليات (Manager)', 'Manager')},
      {'key': 'dispatcher', 'label': tr('مسؤول الإسناد (Dispatcher)', 'Dispatcher')},
      {'key': 'inventory', 'label': tr('أمين المستودع (Inventory)', 'Inventory')},
    ];

    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final f = filters[index];
          final isSelected = _selectedFilter == f['key'];
          return ChoiceChip(
            selected: isSelected,
            label: Text(f['label']!),
            selectedColor: const Color(0xFF006194),
            backgroundColor: const Color(0xFFDCE9FF),
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
    );
  }

  // --- Add User Button ---
  Widget _buildAddUserButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF006194),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person_add, size: 20),
          const SizedBox(width: 8),
          Text(
            tr('إضافة موظف / مستخدم جديد للوكالة', 'Add New Staff / User'),
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // --- User Card ---
  Widget _buildUserCard(Map<String, dynamic> user) {
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
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(
                          user['avatar']! as String,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: user['isOnline'] == true
                                ? const Color(0xFF006948)
                                : const Color(0xFF565E74),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            user['name']! as String,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (user['role'] == 'owner') ...[
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.verified,
                              color: Color(0xFF006194),
                              size: 16,
                            ),
                          ],
                        ],
                      ),
                      Text(
                        user['title']! as String,
                        style: const TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 11,
                          color: Color(0xFF565E74),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDAE2FD),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          user['badge']! as String,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3F465C),
                          ),
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
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  user['status']! as String,
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
                  children: [
                    const Icon(Icons.mail, size: 14, color: Color(0xFF006194)),
                    const SizedBox(width: 6),
                    Text(
                      user['email']! as String,
                      style: const TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 11,
                        color: Color(0xFF0B1C30),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.call, size: 14, color: Color(0xFF006194)),
                    const SizedBox(width: 6),
                    Text(
                      user['phone']! as String,
                      style: const TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 11,
                        color: Color(0xFF0B1C30),
                      ),
                    ),
                    if (user['phoneNote'] != null) ...[
                      const SizedBox(width: 6),
                      Text(
                        '• ${user['phoneNote']}',
                        style: const TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 10,
                          color: Color(0xFF565E74),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            tr('الصلاحيات المصرحة:', 'Authorized Permissions:'),
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xFF565E74),
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: (user['permissions'] as List<String>).map((perm) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCE9FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  perm,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 10,
                    color: Color(0xFF0B1C30),
                  ),
                ),
              );
            }).toList(),
          ),
          if (user['securityNote'] != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.key, size: 14, color: Color(0xFF006948)),
                const SizedBox(width: 6),
                Text(
                  user['securityNote']! as String,
                  style: const TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 11,
                    color: Color(0xFF006948),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFDCE9FF),
                    foregroundColor: const Color(0xFF006194),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    tr('تعديل الصلاحيات', 'Edit Permissions'),
                    style: const TextStyle(fontFamily: 'Cairo', fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: user['role'] == 'owner'
                        ? const Color(0xFF006948)
                        : const Color(0xFFBA1A1A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    user['role'] == 'owner' ? tr('حساب محصّن', 'Secured Account') : tr('تجميد الحساب', 'Freeze Account'),
                    style: const TextStyle(fontFamily: 'Cairo', fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Security Audit Box ---
  Widget _buildSecurityAuditBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.enhanced_encryption,
            color: Color(0xFF006194),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('سجل الرقابة والأمان المشفر', 'Encrypted Security & Audit Log'),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B1C30),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tr(
                    'كافة إجراءات المستخدمين، تعديل الصلاحيات، وتسجيلات الدخول مشفرة بنظام 256-bit ومسجلة تلقائياً في سجل تدقيق الأمان (Audit Log) الخاص بهيئة تنظيم قطاع الطاقة والمعادن.',
                    'All user actions, permission changes, and logins are 256-bit encrypted and logged to the official EMRA regulatory audit log.',
                  ),
                  style: const TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 11,
                    color: Color(0xFF3F4850),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        tr('عرض سجل العمليات الأخير (Audit Log)', 'View Recent Audit Log'),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF006194),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_back,
                        size: 14,
                        color: Color(0xFF006194),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Bottom Nav ---
  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 4, // More tab selected
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: const Color(0xFF006194),
        unselectedItemColor: const Color(0xFF707881),
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 10,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_gas_station),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: 'الطلبات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.propane_tank),
            label: 'المخزون',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.payments), label: 'المالية'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'المزيد'),
        ],
      ),
    );
  }
}
