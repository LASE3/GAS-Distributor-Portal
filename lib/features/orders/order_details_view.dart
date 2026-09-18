import 'package:flutter/material.dart';
import '../../core/localization/app_locale.dart';
import '../../core/routes/app_routes.dart';
import '../../core/widgets/portal_bottom_nav.dart';

class OrderDetailsView extends StatefulWidget {
  const OrderDetailsView({super.key});

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
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

  void _showReassignModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
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
                  tr('إعادة إسناد الطلب لسائق بديل', 'Reassign Order to Alternate Driver'),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B1C30),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              tr(
                'اختر سائقاً متاحاً وقريباً من منطقة دابوق / مجمع الأعمال:',
                'Choose an available driver near Dabouq / Business Park:',
              ),
              style: const TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 12,
                color: Color(0xFF3F4850),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: true,
                        onChanged: (v) {},
                        activeColor: const Color(0xFF006194),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr('خالد عبد الرحيم (شاحنة #05)', 'Khaled Abdel-Rahim (Truck #05)'),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0B1C30),
                            ),
                          ),
                          Text(
                            tr('يبعد 1.8 كم • متاح 14 أسطوانة', '1.8 km away • 14 cylinders available'),
                            style: const TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 11,
                              color: Color(0xFF3F4850),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF85F8C4),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      tr('متاح فوراً', 'Available Now'),
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
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _triggerToast(
                  tr(
                    'تمت إعادة إسناد الطلب بنجاح وتوجيه الإشعار للسائق الجديد',
                    'Order reassigned successfully & driver notified',
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
                tr('تأكيد تحويل الطلب', 'Confirm Order Transfer'),
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
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
                Row(
                  children: [
                    const Icon(Icons.warning, color: Color(0xFFBA1A1A)),
                    const SizedBox(width: 8),
                    Text(
                      tr('تأكيد إلغاء الطلب #ORD-2410', 'Confirm Cancellation #ORD-2410'),
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B1C30),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              tr(
                'يرجى تحديد سبب الإلغاء لتوثيقه في السجل التشغيلي للمركز:',
                'Please specify cancellation reason for the operational log:',
              ),
              style: const TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 12,
                color: Color(0xFF3F4850),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: true,
                    onChanged: (v) {},
                    activeColor: const Color(0xFFBA1A1A),
                  ),
                  Text(
                    tr('طلب العميل الإلغاء هاتفياً', 'Customer requested phone cancellation'),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      color: Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _triggerToast(
                  tr(
                    'تم إلغاء الطلب وتحديث الحالة التشغيلية للمركز',
                    'Order cancelled & operational status updated',
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBA1A1A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                tr('تأكيد الإلغاء نهائياً', 'Confirm Final Cancellation'),
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
            backgroundColor: const Color(0xFFF8F9FF).withValues(alpha: 0.9),
            elevation: 0,
            flexibleSpace: ClipRect(
              child: Container(color: const Color(0xFFF8F9FF).withValues(alpha: 0.9)),
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
                    Icons.receipt_long,
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
                              tr('تفاصيل الطلب والفاتورة', 'Order & Invoice Details'),
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
                                  tr('مباشر من المصفاة', 'Direct from Refinery'),
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
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Alert Banner / Dispatch Live Bar
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDAE2FD),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.wifi_tethering,
                              color: Color(0xFF006194),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              tr(
                                'متابعة إشارة الـ GPS اللحظية للشاحنة #02',
                                'Real-time GPS Tracking for Truck #02',
                              ),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF131B2E),
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
                            color: Colors.white,
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
                                tr('تحديث حي', 'Live'),
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF006948),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 2. Operational Header Card
                  Container(
                    padding: const EdgeInsets.all(16),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  '#ORD-2410',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF006194),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE5EEFF),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    tr('عاجل - منزلي', 'Urgent - Residential'),
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF006194),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE5EEFF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    width: 6,
                                    height: 6,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF006194),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    tr('في الطريق للعميل', 'En Route to Customer'),
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF006194),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tr(
                            'تم تقديم الطلب: منذ 14 دقيقة (11:28 ص)',
                            'Order placed: 14 mins ago (11:28 AM)',
                          ),
                          style: const TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 12,
                            color: Color(0xFF3F4850),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF4FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF006194),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.timer,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tr('موعد الوصول المقدر', 'Estimated Arrival'),
                                        style: const TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 11,
                                          color: Color(0xFF3F4850),
                                        ),
                                      ),
                                      Text(
                                        tr('خلال 6 دقائق (11:46 ص)', 'In 6 mins (11:46 AM)'),
                                        style: const TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF0B1C30),
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
                                    tr('المسافة المتبقية', 'Remaining Distance'),
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 11,
                                      color: Color(0xFF3F4850),
                                    ),
                                  ),
                                  Text(
                                    tr('1.4 كم', '1.4 km'),
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF006948),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 3. Visual Live Delivery Timeline Stepper
                  Container(
                    padding: const EdgeInsets.all(16),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr('المسار الزمني المباشر', 'Live Delivery Timeline'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B1C30),
                              ),
                            ),
                            Text(
                              tr('المرحلة 4 من 6', 'Stage 4 of 6'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 11,
                                color: Color(0xFF3F4850),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildTimelineStep(
                          tr('تم استلام الطلب وتأكيده', 'Order Received & Confirmed'),
                          tr('عبر تطبيق المستهلك الموحد', 'Via unified consumer mobile app'),
                          tr('11:28 ص', '11:28 AM'),
                          true,
                        ),
                        _buildTimelineStep(
                          tr('قبول الوكالة وتجهيز الحمولة', 'Agency Acceptance & Load Prep'),
                          tr('فحص سلامة الأسطوانة والملحقات', 'Cylinder & accessories safety check'),
                          tr('11:30 ص', '11:30 AM'),
                          true,
                        ),
                        _buildTimelineStep(
                          tr('إسناد للكابتن عمر الزعبي', 'Assigned to Capt. Omar Al-Zoubi'),
                          tr('شاحنة هيونداي #02 (حمولة 85%)', 'Hyundai Truck #02 (85% load capacity)'),
                          tr('11:32 ص', '11:32 AM'),
                          true,
                        ),
                        _buildTimelineStep(
                          tr('انطلاق الشاحنة بالطريق', 'Truck En Route'),
                          tr('شارع المدينة المنورة باتجاه دابوق (42 كم/س)', 'Madinah St towards Dabouq (42 km/h)'),
                          tr('11:35 ص', '11:35 AM'),
                          true,
                          isActive: true,
                        ),
                        _buildTimelineStep(
                          tr('وصول السائق للعنوان', 'Driver Arriving at Address'),
                          tr('دابوق - عمارة الياقوت', 'Dabouq - Al-Yaqout Bldg'),
                          tr('11:46 ص (متوقع)', '11:46 AM (Est.)'),
                          false,
                        ),
                        _buildTimelineStep(
                          tr('فحص التسريب والتركيب واستلام النقد', 'Leak Test, Installation & Payment'),
                          tr('اختبار رغوة الصمام والسلامة المنزلية', 'Valve foam test & household safety check'),
                          '--:--',
                          false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 4. Customer Details & Compact Route View
                  Container(
                    padding: const EdgeInsets.all(16),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr('بيانات العميل والتوصيل', 'Customer & Delivery Info'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B1C30),
                              ),
                            ),
                            Text(
                              tr('عميل مسجل دائم', 'Permanent Customer'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF006194),
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
                              Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFCCE5FF),
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      tr('س', 'S'),
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF001D31),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tr('د. سمير حداد', 'Dr. Samir Haddad'),
                                        style: const TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF0B1C30),
                                        ),
                                      ),
                                      const Text(
                                        '0798765432',
                                        style: TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 11,
                                          color: Color(0xFF3F4850),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => _triggerToast(
                                      tr('جاري الاتصال بالعميل د. سمير...', 'Calling customer Dr. Samir...'),
                                    ),
                                    icon: const Icon(
                                      Icons.call,
                                      size: 18,
                                      color: Color(0xFF006194),
                                    ),
                                    style: IconButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  IconButton(
                                    onPressed: () => _triggerToast(
                                      tr('تم إرسال رسالة SMS للعميل بنجاح', 'SMS sent to customer successfully'),
                                    ),
                                    icon: const Icon(
                                      Icons.sms,
                                      size: 18,
                                      color: Color(0xFF006948),
                                    ),
                                    style: IconButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          tr('عنوان التسليم التفصيلي:', 'Detailed Delivery Address:'),
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3F4850),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tr(
                            'دابوق - قرب مجمع الملك حسين للأعمال - عمارة الياقوت رقم 18 - الطابق الثاني، شقة 4.',
                            'Dabouq - Near King Hussein Business Park - Al-Yaqout Bldg 18 - 2nd Fl, Apt 4.',
                          ),
                          style: const TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 12,
                            color: Color(0xFF0B1C30),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFFE5EEFF),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.location_on, color: Color(0xFF006194), size: 24),
                              const SizedBox(width: 8),
                              Text(
                                tr('خريطة موقع التسليم المباشر', 'Direct Delivery Location Map'),
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12,
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
                  const SizedBox(height: 16),

                  // 5. Order Items Breakdown & Financials
                  Container(
                    padding: const EdgeInsets.all(16),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr('تفاصيل الفاتورة والمواد', 'Invoice & Item Details'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B1C30),
                              ),
                            ),
                            Text(
                              tr('3 مواد', '3 Items'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 11,
                                color: Color(0xFF006948),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildInvoiceItem(
                          tr('أسطوانة غاز منزلي (12.5 كغ)', 'Domestic Gas Cylinder (12.5 kg)'),
                          tr('استبدال أسطوانة فارغة بمليئة', 'Exchange empty cylinder for filled'),
                          tr('7.00 د.أ', '7.00 JOD'),
                        ),
                        const SizedBox(height: 8),
                        _buildInvoiceItem(
                          tr('منظم غاز إيطالي أصلي', 'Original Italian Gas Regulator'),
                          tr('مزود بصمام أمان وحماية ضغط', 'Equipped with safety valve & pressure guard'),
                          tr('5.00 د.أ', '5.00 JOD'),
                        ),
                        const SizedBox(height: 8),
                        _buildInvoiceItem(
                          tr('خرطوم غاز حراري أصلي (2 متر)', 'Thermal Gas Hose (2m)'),
                          tr('مقاوم للتآكل ومطابق للمواصفات', 'Corrosion-resistant certified specs'),
                          tr('1.50 د.أ', '1.50 JOD'),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF4FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tr('المجموع الإجمالي المستحق (COD)', 'Total Amount Due (COD)'),
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0B1C30),
                                ),
                              ),
                              Text(
                                tr('13.50 د.أ', '13.50 JOD'),
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16,
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
                  const SizedBox(height: 16),

                  // 6. Assigned Driver & Dispatch Fleet Controls
                  Container(
                    padding: const EdgeInsets.all(16),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr('السائق المكلف والتحكم', 'Assigned Driver & Dispatch'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B1C30),
                              ),
                            ),
                            Text(
                              tr('شاحنة معتمدة', 'Certified Truck'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 11,
                                color: Color(0xFF006948),
                                fontWeight: FontWeight.bold,
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
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF006194).withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.person, color: Color(0xFF006194), size: 24),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tr('عمر الزعبي', 'Omar Al-Zoubi'),
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0B1C30),
                                      ),
                                    ),
                                    Text(
                                      tr('شاحنة هيونداي #02 • تقييم 4.9 ★', 'Hyundai Truck #02 • Rating 4.9 ★'),
                                      style: const TextStyle(
                                        fontFamily: 'Tajawal',
                                        fontSize: 11,
                                        color: Color(0xFF3F4850),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ElevatedButton.icon(
                              onPressed: () => _triggerToast(
                                tr('جاري الاتصال بالكابتن عمر...', 'Calling Capt. Omar...'),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF006194),
                                foregroundColor: Colors.white,
                                elevation: 0,
                              ),
                              icon: const Icon(Icons.call, size: 14),
                              label: Text(
                                tr('اتصال', 'Call'),
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _showReassignModal,
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: const Color(0xFFEFF4FF),
                                  side: BorderSide.none,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.swap_horiz,
                                  size: 16,
                                  color: Color(0xFF006194),
                                ),
                                label: Text(
                                  tr('إعادة إسناد السائق', 'Reassign Driver'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF006194),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _showCancelModal,
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFDAD6),
                                  side: BorderSide.none,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.cancel,
                                  size: 16,
                                  color: Color(0xFFBA1A1A),
                                ),
                                label: Text(
                                  tr('إلغاء الطلب', 'Cancel Order'),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFBA1A1A),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                    color: const Color(0xFF006948),
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
          ],
        ),
        bottomNavigationBar: const PortalBottomNav(currentIndex: 1),
      ),
    );
  }

  Widget _buildTimelineStep(
    String title,
    String subtitle,
    String time,
    bool isCompleted, {
    bool isActive = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isCompleted ? const Color(0xFF006948) : Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Icon(
              isActive
                  ? Icons.local_shipping
                  : (isCompleted ? Icons.check : Icons.circle),
              size: 14,
              color: Colors.white,
            ),
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
                      title,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isCompleted
                            ? const Color(0xFF0B1C30)
                            : Colors.grey,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 11,
                        color: Color(0xFF3F4850),
                      ),
                    ),
                  ],
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 11,
                    color: isCompleted ? const Color(0xFF3F4850) : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceItem(String title, String desc, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0B1C30),
              ),
            ),
            Text(
              desc,
              style: const TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 10,
                color: Color(0xFF3F4850),
              ),
            ),
          ],
        ),
        Text(
          price,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B1C30),
          ),
        ),
      ],
    );
  }
}
