import 'package:flutter/material.dart';
import '../../core/localization/app_locale.dart';

class PasswordRecoveryView extends StatefulWidget {
  const PasswordRecoveryView({super.key});

  @override
  State<PasswordRecoveryView> createState() => _PasswordRecoveryViewState();
}

class _PasswordRecoveryViewState extends State<PasswordRecoveryView> {
  String _recoveryMethod = 'sms'; // 'sms' or 'email'
  bool _isLoading = false;
  bool _isSuccess = false;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _licenseController.dispose();
    super.dispose();
  }

  void _triggerOtpProcess() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isSuccess = true;
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
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Top Navigation & Return Action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFE5EEFF),
                        foregroundColor: const Color(0xFF006194),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).maybePop();
                      },
                      icon: Icon(isAr ? Icons.arrow_forward : Icons.arrow_back, size: 20),
                      label: Text(
                        tr('العودة لتسجيل الدخول', 'Back to Sign In'),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFCCE5FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.security,
                            size: 14,
                            color: Color(0xFF006194),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            tr('بوابة الاسترداد الآمن', 'Secure Recovery Portal'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF006194),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 2. Visual Identity & Status Icon
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: const Color(0xFFCCE5FF),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.local_fire_department,
                                size: 36,
                                color: Color(0xFF006194),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: const Color(0xFF006948),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFF8F9FF),
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.lock_reset,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        tr('استعادة حساب موزع الغاز', 'Distributor Account Recovery'),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0B1C30),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tr('التحقق من هوية الوكالة لإعادة تعيين كلمة المرور المشفرة', 'Verify agency identity to securely reset encrypted password'),
                        style: const TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 12,
                          color: Color(0xFF565E74),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 3. Operational Step Indicator
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFD3E4FE)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStepItem(
                        '1',
                        tr('بيانات الوكالة', 'Agency Info'),
                        isActive: true,
                        isDone: _isSuccess,
                      ),
                      Container(
                        width: 24,
                        height: 1,
                        color: _isSuccess
                            ? const Color(0xFF006948)
                            : const Color(0xFFCCE5FF),
                      ),
                      _buildStepItem(
                        '2',
                        tr('رمز الأمان OTP', 'OTP Security'),
                        isActive: _isSuccess,
                        isDone: false,
                      ),
                      Container(
                        width: 24,
                        height: 1,
                        color: const Color(0xFFCCE5FF),
                      ),
                      _buildStepItem(
                        '3',
                        tr('كلمة المرور الجديدة', 'New Password'),
                        isActive: false,
                        isDone: false,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 4. Recovery Method Tabs
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF4FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _recoveryMethod = 'sms'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: _recoveryMethod == 'sms'
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: _recoveryMethod == 'sms'
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.04),
                                        blurRadius: 4,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.sms,
                                      size: 16,
                                      color: Color(0xFF006194),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      tr('عبر رسالة SMS', 'Via SMS Code'),
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: _recoveryMethod == 'sms'
                                            ? const Color(0xFF006194)
                                            : const Color(0xFF565E74),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  tr('موصى به للميدان', 'Field Recommended'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 10,
                                    color: Color(0xFF006948),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _recoveryMethod = 'email'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: _recoveryMethod == 'email'
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: _recoveryMethod == 'email'
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.04),
                                        blurRadius: 4,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.mail,
                                      size: 16,
                                      color: Color(0xFF565E74),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      tr('البريد الإلكتروني', 'Official Email'),
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: _recoveryMethod == 'email'
                                            ? const Color(0xFF006194)
                                            : const Color(0xFF565E74),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  tr('الحساب الرسمي', 'Registered Account'),
                                  style: const TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontSize: 10,
                                    color: Color(0xFF565E74),
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
                const SizedBox(height: 16),

                // 5. Recovery Form Area
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_recoveryMethod == 'sms') ...[
                      Text(
                        tr('رقم هاتف الموزع المسجل', 'Registered Mobile Number'),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        textDirection: TextDirection.ltr,
                        decoration: InputDecoration(
                          hintText: '79 123 4567',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.smartphone,
                            color: Color(0xFF006194),
                          ),
                          suffixText: '+962 ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tr('أدخل رقم الهاتف المرتبط بمركبة التوزيع أو بطاقة المعتمد', 'Enter mobile number linked with distributor vehicle or certified card'),
                        style: const TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 11,
                          color: Color(0xFF565E74),
                        ),
                      ),
                    ] else ...[
                      Text(
                        tr('البريد الإلكتروني للوكالة', 'Agency Email Address'),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textDirection: TextDirection.ltr,
                        decoration: InputDecoration(
                          hintText: 'agency@alnoor-gas.jo',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.alternate_email,
                            color: Color(0xFF006194),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tr('عنوان البريد المسجل في العقد التشغيلي لدى الهيئة', 'Email address registered in the operating regulatory contract'),
                        style: const TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 11,
                          color: Color(0xFF565E74),
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),

                    Text(
                      tr('الرقم الوطني للمنشأة / رقم رخصة التوزيع', 'National Enterprise ID / Distribution License No.'),
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _licenseController,
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                        hintText: tr('مثال: 200148923-G', 'e.g. 200148923-G'),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.badge,
                          color: Color(0xFF006194),
                        ),
                        suffixIcon: const Icon(
                          Icons.shield,
                          color: Color(0xFF565E74),
                          size: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tr('الرقم المطبوع على بطاقة فحص السلامة الميدانية للموزع', 'Printed on field safety inspection card'),
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 11,
                        color: Color(0xFF565E74),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // OTP Security Advisory Panel
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF4FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.lock_clock,
                            color: Color(0xFF006194),
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tr('صلاحية الرمز وتأمينه', 'OTP Validity & Security'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  tr(
                                    'سيتم إرسال رمز أمان مكوّن من 6 أرقام صالح لمدة 5 دقائق فقط. لا تشارك الرمز مع أي شخص لضمان أمان حصص الغاز المخصصة لوكالتك.',
                                    'A 6-digit security code valid for 5 minutes will be sent. Never share this code to ensure quota security for your agency.',
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Status Toast Simulation
                    if (_isSuccess)
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF85F8C4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.mark_email_read,
                              color: Color(0xFF006948),
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tr('تم إرسال رمز التحقق بنجاح', 'Verification code dispatched successfully'),
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF002114),
                                    ),
                                  ),
                                  Text(
                                    tr('تحقق من صندوق الوارد أو تطبيق الرسائل في هاتفك.', 'Check your SMS messages or email inbox.'),
                                    style: const TextStyle(
                                      fontFamily: 'Tajawal',
                                      fontSize: 11,
                                      color: Color(0xFF005137),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Submit Action Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isSuccess
                            ? const Color(0xFF006948)
                            : const Color(0xFF006194),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _isLoading || _isSuccess
                          ? null
                          : _triggerOtpProcess,
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _isSuccess
                                      ? Icons.check_circle
                                      : Icons.send_to_mobile,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _isSuccess
                                      ? tr('تم إرسال الرمز بنجاح', 'Code Dispatched')
                                      : tr('إرسال رمز التحقق (OTP)', 'Send Verification Code (OTP)'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 12),

                    // Support Channel Card
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5EEFF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.support_agent,
                                  size: 18,
                                  color: Color(0xFF006194),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tr('الدعم الفني الميداني للوكلاء', 'Field Agent Support Line'),
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    tr('متاح على مدار الساعة لحالات الطوارئ والتسليم', '24/7 Priority Emergency Support'),
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
                          const Text(
                            '06-5000999',
                            style: TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF006194),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Accreditation Footer
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.health_and_safety,
                              color: Color(0xFF006948),
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              tr('اعتماد رسمي ومشفّر', 'Officially Certified & Encrypted'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF006948),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tr(
                            'بوابة موثقة ومحمية وفق معايير نقابة أصحاب محطات المحروقات وتوزيع الغاز الأردنية.',
                            'Certified and secured under the standards of the Fuel & Gas Syndicate of Jordan.',
                          ),
                          style: const TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 11,
                            color: Color(0xFF565E74),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          tr('رقم النسخة التشغيلية 3.4.2 • عمان - الزرقاء', 'Release v3.4.2 • Amman - Zarqa Operations'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepItem(
    String number,
    String label, {
    required bool isActive,
    required bool isDone,
  }) {
    Color bg = const Color(0xFFEFF4FF);
    Color textCol = const Color(0xFF565E74);
    Widget iconChild = Text(
      number,
      style: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: textCol,
      ),
    );

    if (isDone) {
      bg = const Color(0xFF85F8C4);
      iconChild = const Icon(
        Icons.check,
        size: 14,
        color: Color(0xFF006948),
      );
    } else if (isActive) {
      bg = const Color(0xFF006194);
      iconChild = Text(
        number,
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }

    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: bg,
          child: iconChild,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 11,
            fontWeight: isActive || isDone ? FontWeight.bold : FontWeight.normal,
            color: isActive || isDone
                ? const Color(0xFF0B1C30)
                : const Color(0xFF565E74),
          ),
        ),
      ],
    );
  }
}
