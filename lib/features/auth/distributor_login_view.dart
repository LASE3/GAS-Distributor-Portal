import 'package:flutter/material.dart';
import '../../core/localization/app_locale.dart';
import '../../core/routes/app_routes.dart';

class DistributorLoginView extends StatefulWidget {
  const DistributorLoginView({super.key});

  @override
  State<DistributorLoginView> createState() => _DistributorLoginViewState();
}

class _DistributorLoginViewState extends State<DistributorLoginView> {
  bool _obscurePassword = true;
  bool _rememberDevice = false;
  bool _isLoading = false;

  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              tr(
                'تم التحقق بنجاح، جاري فتح لوحة التحكم التشغيلية...',
                'Verified successfully, opening operational dashboard...',
              ),
              style: const TextStyle(fontFamily: 'Cairo'),
            ),
            backgroundColor: const Color(0xFF006948),
            duration: const Duration(seconds: 1),
          ),
        );
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: LocaleNotifier.instance,
      builder: (context, locale, _) {
        final isAr = locale.languageCode == 'ar';
        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FF),
          body: Directionality(
            textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
            child: Stack(
          children: [
            // Ambient Glow
            Positioned(
              top: 40,
              left: MediaQuery.of(context).size.width / 2 - 96,
              child: Container(
                width: 192,
                height: 192,
                decoration: BoxDecoration(
                  color: const Color(0xFFCCE5FF).withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Brand Header
                    Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.local_fire_department,
                            size: 48,
                            color: Color(0xFF006194),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD3E4FE),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.verified,
                                size: 14,
                                color: Color(0xFF006194),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                tr('مخصص لوكلاء وموزعي الغاز المرخصين في المملكة', 'Licensed Gas Distributors & Agents Portal'),
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF001D31),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          tr('بوابة موزع الغاز المعتمد', 'Certified Gas Distributor Portal'),
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0B1C30),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tr('منصة إدارة وتوزيع أسطوانات الغاز والأسطول الميداني', 'Gas Cylinder Distribution & Field Fleet Management Platform'),
                          style: const TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 13,
                            color: Color(0xFF3F4850),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Login Form Card
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Column(
                          children: [
                            Container(height: 4, color: const Color(0xFF006194)),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Input 1: Agency ID / Email
                                  Text(
                                    tr('رقم الوكالة أو البريد الإلكتروني', 'Agency ID or Email'),
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0B1C30),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  TextField(
                                    controller: _identifierController,
                                    textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
                                    decoration: InputDecoration(
                                      hintText: tr('مثال: agency-104 أو info@alnoorgas.jo', 'e.g. agency-104 or info@alnoorgas.jo'),
                                      hintStyle: const TextStyle(
                                        fontFamily: 'Tajawal',
                                        color: Color(0xFF707881),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.badge,
                                        color: Color(0xFF006194),
                                      ),
                                      suffixIcon: const Icon(
                                        Icons.local_gas_station,
                                        color: Color(0xFF707881),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFFEFF4FF),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  // Input 2: Password
                                  Text(
                                    tr('كلمة المرور', 'Password'),
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0B1C30),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  TextField(
                                    controller: _passwordController,
                                    obscureText: _obscurePassword,
                                    textDirection: TextDirection.ltr,
                                    decoration: InputDecoration(
                                      hintText: '••••••••••••',
                                      hintStyle: const TextStyle(
                                        color: Color(0xFF707881),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Color(0xFF006194),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscurePassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: const Color(0xFF707881),
                                        ),
                                        onPressed: () => setState(
                                          () => _obscurePassword = !_obscurePassword,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFFEFF4FF),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),

                                  // Remember & Forgot Options
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: _rememberDevice,
                                            onChanged: (v) => setState(
                                              () => _rememberDevice = v ?? false,
                                            ),
                                            activeColor: const Color(0xFF006194),
                                          ),
                                          Text(
                                            tr('تذكر هذا الجهاز التشغيلي', 'Remember this device'),
                                            style: const TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 13,
                                              color: Color(0xFF0B1C30),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(AppRoutes.forgotPassword);
                                        },
                                        child: Text(
                                          tr('نسيت كلمة المرور؟', 'Forgot Password?'),
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
                                  const SizedBox(height: 16),

                                  // Submit Button
                                  ElevatedButton.icon(
                                    onPressed: _isLoading ? null : _handleLogin,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF006194),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    icon: _isLoading
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : const Icon(Icons.login, size: 20),
                                    label: Text(
                                      _isLoading
                                          ? tr('جارٍ التحقق من بيانات الوكالة...', 'Verifying agency credentials...')
                                          : tr('تسجيل الدخول إلى لوحة التحكم', 'Sign In to Dashboard'),
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
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Security Notice & Central GAS Assistance Box
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCE9FF).withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.admin_panel_settings,
                              color: Color(0xFF006194),
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tr('إشعار أمني وإداري', 'Security & Administrative Notice'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0B1C30),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                RichText(
                                  text: TextSpan(
                                    text: tr(
                                      'يتم إنشاء وتفعيل حسابات الموزعين حصرياً من قبل الإدارة المركزية لشركة غاز الأردن. في حال واجهت مشكلة في الدخول، يرجى التواصل مع الدعم الفني: ',
                                      'Distributor accounts are verified exclusively by the Central Petroleum Administration. For technical assistance contact support: ',
                                    ),
                                    style: const TextStyle(
                                      fontFamily: 'Tajawal',
                                      fontSize: 12,
                                      color: Color(0xFF3F4850),
                                      height: 1.4,
                                    ),
                                    children: const [
                                      TextSpan(
                                        text: '06-5000000',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF006194),
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
                    const SizedBox(height: 16),

                    // Live Depot Quick Metrics Strip
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF85F8C4).withValues(alpha: 0.3),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.verified_user,
                                    color: Color(0xFF006948),
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tr('حماية البوابة', 'Portal Security'),
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 10,
                                        color: Color(0xFF3F4850),
                                      ),
                                    ),
                                    Text(
                                      tr('تشفير معتمد TLS', 'TLS Certified'),
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0B1C30),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFCCE5FF),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.cell_tower,
                                    color: Color(0xFF006194),
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tr('اتصال السيرفر', 'Server Link'),
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 10,
                                        color: Color(0xFF3F4850),
                                      ),
                                    ),
                                    Text(
                                      tr('جاهز ومستقر', 'Ready & Stable'),
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Language Selector Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (!isAr) LocaleNotifier.instance.setLocale(const Locale('ar'));
                          },
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isAr ? const Color(0xFF006194) : const Color(0xFFE5EEFF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'العربية (RTL)',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isAr ? Colors.white : const Color(0xFF006194),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('•', style: TextStyle(color: Colors.grey)),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            if (isAr) LocaleNotifier.instance.setLocale(const Locale('en'));
                          },
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: !isAr ? const Color(0xFF006194) : const Color(0xFFE5EEFF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'English (LTR)',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: !isAr ? Colors.white : const Color(0xFF006194),
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
      );
    },
  );
  }
}
