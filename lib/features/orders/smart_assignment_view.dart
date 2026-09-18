import 'package:flutter/material.dart';
import '../../core/localization/app_locale.dart';
import '../../core/widgets/portal_bottom_nav.dart';

class SmartAssignmentView extends StatefulWidget {
  const SmartAssignmentView({super.key});

  @override
  State<SmartAssignmentView> createState() => _SmartAssignmentViewState();
}

class _SmartAssignmentViewState extends State<SmartAssignmentView> {
  bool _showToast = false;
  String _toastMessage = 'تم إسناد الطلب بنجاح!';

  void _triggerToast(String message) {
    setState(() {
      _toastMessage = message;
      _showToast = true;
    });
    Future.delayed(const Duration(milliseconds: 3200), () {
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
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0B1C30)),
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
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.local_shipping,
                  color: Color(0xFF006194),
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        tr('الإسناد والتوجيه الذكي', 'Smart Dispatch & Routing'),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0B1C30),
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
                              tr('ذكاء اصطناعي', 'AI Dispatch'),
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 11,
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
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3F4850),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
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
                  onPressed: () {},
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
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 4),
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFF006194),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
      ),
      body: Directionality(
        textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Operational Alert Banner
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCE9FF),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFF007BB9),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.radar,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      '٣ طلبات حرجة بانتظار الإسناد',
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0B1C30),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFBA1A1A),
                                        borderRadius: BorderRadius.circular(
                                          9999,
                                        ),
                                      ),
                                      child: const Text(
                                        'عاجل',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 9,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'تفادياً لتأخير مواعيد التسليم المجدولة في قطاع غرب عمان',
                                  style: TextStyle(
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
                          onPressed: () {
                            _triggerToast(
                              'جاري التوزيع التلقائي الذكي لكافة الطلبات حسب الأقرب...',
                            );
                            Future.delayed(
                              const Duration(milliseconds: 1200),
                              () {
                                if (mounted) {
                                  _triggerToast(
                                    'تم إسناد جميع الطلبات بنجاح للسائقين!',
                                  );
                                }
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF006194),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                          ),
                          icon: const Icon(Icons.auto_mode, size: 16),
                          label: const Text(
                            'إسناد ذكي للكل',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 2. Spotlight High Priority Unassigned Order (#ORD-2412)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Card Header
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: Color(0xFFE5EEFF),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFDAD6),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.notification_important,
                                      color: Color(0xFF93000A),
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'طلب #ORD-2412',
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF0B1C30),
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFD3E4FE),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: const Text(
                                              'منذ ٧ دقائق',
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 10,
                                                color: Color(0xFF3F4850),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        'حي الجامعة • قرب مجمع وصفي التل التجاري',
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontSize: 11,
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
                                  const Text(
                                    '١٨.٥٠ د.أ',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF006194),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDAE2FD),
                                      borderRadius: BorderRadius.circular(9999),
                                    ),
                                    child: const Text(
                                      'دفع نقدي COD',
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF5C647A),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Spotlight Body
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF4FF),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 32,
                                          height: 32,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFD3E4FE),
                                            shape: BoxShape.circle,
                                          ),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'م.ق',
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF0B1C30),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'محمد عبد الله القضاة',
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF0B1C30),
                                              ),
                                            ),
                                            Text(
                                              '0785551234',
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
                                          onPressed: () {},
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
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.chat,
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
                              Row(
                                children: const [
                                  Icon(
                                    Icons.propane_tank,
                                    size: 18,
                                    color: Color(0xFF006194),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    '٢ أسطوانة منزلية (١٢.٥ كغ)',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0B1C30),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Icon(
                                    Icons.hardware,
                                    size: 18,
                                    color: Color(0xFF565E74),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'بربيش أمان ٢م',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12,
                                      color: Color(0xFF3F4850),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Map preview
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuDJ6PEosff41RM4NW6B9pJMjiNYezpYf53JQwhB-9RN-5wonjIbEdoTu-qVW6S9JHyLlfW5MTHDKjA9rrCJcql-dPmd6I1xbSKxvgw1ziJskRwg5sdwov19peO9SfjyJxPc_PX5uLSyjMDLwD7ZTrtNmjmAgLGo9af4zjAZYR1qv0j0UtQO8bjUkQ3OIbM_NgoKph2aquce64FDSmEq5wimBzfvtrxN1yU19Jm8qu3NRwm5d8QMjI8s',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'شارع وصفي التل، بناية ٤٢، الطابق الثاني',
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontSize: 11,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'عمان الغربية',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 10,
                                          color: Color(0xFF85F8C4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Smart Driver Matcher Header
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.route,
                                        color: Color(0xFF006194),
                                        size: 18,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'أقرب السائقين المؤهلين',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF0B1C30),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'تحديث ذكي مباشر',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 10,
                                      color: Color(0xFF006948),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Best Match Captain (Ahmad Al-Abadi)
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDCE9FF),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xFF006194)
                                        .withOpacity(0.3),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                'https://lh3.googleusercontent.com/aida-public/AB6AXuBEzElocyu67-ScHumI__aF96C_ILAQWcgWQ9WAyx5VjYw2hvfdRcFv--fJTq92JrTAU_hDHCWAmGRPiCj61WEtOTwhiPxqo7qwUjKe0JULy1oNwuKGuPSQSnKaHevmQyVQcAdUtp3fcNDwXkbyFXaGnVFDgKRW2t7BjXOdrYIs7wF7JRZcBi-ZVBDVkWhBDfgPUkfbPOv1sGFf0bIq5qtvQke9kgCY7bsmhk091tUs0qJh1uAnFILM',
                                                width: 40,
                                                height: 40,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: const [
                                                    Text(
                                                      'الكابتن أحمد العبادي',
                                                      style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color(
                                                          0xFF0B1C30,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 6),
                                                    Text(
                                                      'الخيار الأمثل',
                                                      style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize: 9,
                                                        backgroundColor: Color(
                                                          0xFF85F8C4,
                                                        ),
                                                        color: Color(
                                                          0xFF002114,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 2),
                                                const Text(
                                                  '١.١ كم (٤ دقائق) • ١٤ أسطوانة متوفرة',
                                                  style: TextStyle(
                                                    fontFamily: 'Tajawal',
                                                    fontSize: 11,
                                                    color: Color(0xFF3F4850),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.star,
                                              size: 14,
                                              color: Colors.amber,
                                            ),
                                            Text(
                                              '٤.٩',
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF0B1C30),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'جاهز للإسناد التلقائي الفوري',
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 11,
                                            color: Color(0xFF006948),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () => _triggerToast(
                                            'تم إسناد #ORD-2412 للكابتن أحمد العبادي بنجاح!',
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFF006194,
                                            ),
                                            foregroundColor: Colors.white,
                                            elevation: 0,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 8,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          icon: const Icon(
                                            Icons.bolt,
                                            size: 16,
                                          ),
                                          label: const Text(
                                            'إسناد فوري وتأكيد',
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Alternative 2: Hamza Al-Nsour
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF4FF),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          child: Image.network(
                                            'https://lh3.googleusercontent.com/aida-public/AB6AXuBkqk0k5kUhCbeQFSHIHNoAkTzS6TCFNpZFD2DJnaXQN35bBU0P-l6TjZjhOAyIaI8il4J4_AlvKAebYEFe_1xGFFr19iDiC_oL2idHBrTi7YX5l1MrmEcgtlF-Rkd0GrGUl8YD0JOiWffAUGJbwoQXJF555ZKplD_tN3gLYY2TA_YGcfezFfnZKAFFV4aORTe-Yt0ZNKnV5hbvCPjlyHFxJ4u0cbftuVJ99I4jQRNl6QGC40BKu6FV',
                                            width: 32,
                                            height: 32,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'الكابتن حمزة النسور',
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF0B1C30),
                                              ),
                                            ),
                                            Text(
                                              '٢.٤ كم (٨ دقائق) • ٩ أسطوانات حمولة',
                                              style: TextStyle(
                                                fontFamily: 'Tajawal',
                                                fontSize: 10,
                                                color: Color(0xFF3F4850),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    OutlinedButton(
                                      onPressed: () => _triggerToast(
                                        'تم إسناد #ORD-2412 للكابتن حمزة النسور بنجاح!',
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: BorderSide.none,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                      ),
                                      child: const Text(
                                        'إسناد بديل',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 11,
                                          color: Color(0xFF006194),
                                        ),
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

                  // 3. Other Pending Orders in Queue
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'قائمة الانتظار النشطة',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0B1C30),
                            ),
                          ),
                          Text(
                            'ترتيب حسب الأقدمية',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11,
                              color: Color(0xFF006194),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildQueueCard(
                        '#ORD-2415',
                        'منذ ٣ دقائق',
                        'خلدا • المدارس الإنجليزية',
                        '١٠.٠٠ د.أ',
                        '١ أسطوانة',
                        'ليث الرواشدة (١.٨ كم)',
                      ),
                      const SizedBox(height: 8),
                      _buildQueueCard(
                        '#ORD-2416',
                        'منذ دقيقة واحدة',
                        'دابوق • بجانب حديقة دابوق',
                        '٢٥.٥٠ د.أ',
                        '٢ أسطوانة + ساعة أمان',
                        'جاري فحص النطاق...',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 4. Dispatcher Operations Quick Footer Bar
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF4FF),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 4,
                        ),
                      ],
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
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.headset_mic,
                                color: Color(0xFF006194),
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'غرفة الطوارئ المركزية',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0B1C30),
                                  ),
                                ),
                                Text(
                                  'تواصل صوتي مباشر عبر اللاسلكي',
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontSize: 10,
                                    color: Color(0xFF3F4850),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        OutlinedButton.icon(
                          onPressed: () => _triggerToast(
                            'فتح قناة النداء العام لجميع السائقين',
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide.none,
                          ),
                          icon: const Icon(
                            Icons.cell_tower,
                            size: 16,
                            color: Color(0xFF006948),
                          ),
                          label: const Text(
                            'نداء عام',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0B1C30),
                            ),
                          ),
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
                bottom: 80,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF213145),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 8),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.verified,
                        color: Color(0xFF85F8C4),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _toastMessage,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const PortalBottomNav(currentIndex: 1),
    );
  }

  Widget _buildQueueCard(
    String orderId,
    String time,
    String location,
    String price,
    String items,
    String suggestedDriver,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4),
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
                  const Icon(
                    Icons.local_shipping,
                    size: 16,
                    color: Color(0xFF006194),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    orderId,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B1C30),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    time,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
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
                  color: Color(0xFF006194),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            location,
            style: const TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 11,
              color: Color(0xFF3F4850),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.propane_tank,
                    size: 14,
                    color: Color(0xFF565E74),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$items • ',
                    style: const TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 10,
                      color: Color(0xFF3F4850),
                    ),
                  ),
                  Text(
                    suggestedDriver,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF006948),
                    ),
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () => _triggerToast('جاري توجيه $orderId...'),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFEFF4FF),
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                ),
                child: const Text(
                  'توجيه',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006194),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
