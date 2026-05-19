import 'package:flutter/material.dart';
import 'customize_general_screen.dart';

class TemplateSelectionScreen extends StatefulWidget {
  final Map<String, dynamic>? storeData;

  const TemplateSelectionScreen({
    super.key,
    this.storeData,
  });

  @override
  State<TemplateSelectionScreen> createState() =>
      _TemplateSelectionScreenState();
}

class _TemplateSelectionScreenState extends State<TemplateSelectionScreen> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> templates = const [
    {
      "name": "قالب عادي",
      "layout_type": "grid",
      "desc": "عرض شبكي منظم للمنتجات",
      "icon": Icons.grid_view_rounded,
    },
    {
      "name": "قالب سلايدر",
      "layout_type": "carousel",
      "desc": "منتجات بتمرير أنيق",
      "icon": Icons.view_carousel_rounded,
    },
    {
      "name": "قالب مميز",
      "layout_type": "featured",
      "desc": "منتج بارز مع باقي المنتجات",
      "icon": Icons.star_rounded,
    },
    {
      "name": "قالب فيديو",
      "layout_type": "video",
      "desc": "فيديو تعريفي مع المنتجات",
      "icon": Icons.play_circle_fill_rounded,
    },
  ];

  void openCustomize() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CustomizeGeneralScreen(
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedTemplate = templates[selectedIndex];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F5EE),
        body: SafeArea(
          child: Column(
            children: [
              _topBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
                  child: Column(
                    children: [
                      _heroTitle(),
                      const SizedBox(height: 18),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: templates.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.58,
                        ),
                        itemBuilder: (context, index) {
                          final template = templates[index];
                          final selected = selectedIndex == index;

                          return _templateCard(
                            template: template,
                            selected: selected,
                            onTap: () {
                              setState(() => selectedIndex = index);
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      _selectedSummary(selectedTemplate),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: openCustomize,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E6B4E),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                          child: Text(
                            'اختيار ${selectedTemplate['name']}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
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
      ),
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF17324A),
              size: 30,
            ),
          ),
          const Expanded(
            child: Column(
              children: [
                Text(
                  'اختيار القالب',
                  style: TextStyle(
                    color: Color(0xFF17324A),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'اختاري الشكل الأقرب لهوية متجرك',
                  style: TextStyle(
                    color: Color(0xFF7A8790),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _heroTitle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF17324A),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF17324A).withOpacity(0.18),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.dashboard_customize_rounded,
              color: Color(0xFF17324A),
              size: 27,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'قوالب جاهزة قابلة للتخصيص',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'اختاري قالب، وبعدها عدّلي الألوان والخطوط والأقسام والصور',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _templateCard({
    required Map<String, dynamic> template,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final type = template['layout_type'];

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 230),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: selected ? const Color(0xFF2E6B4E) : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: selected
                  ? const Color(0xFF2E6B4E).withOpacity(0.22)
                  : Colors.black.withOpacity(0.06),
              blurRadius: selected ? 22 : 14,
              offset: Offset(0, selected ? 10 : 7),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: _mockBackground(type),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: _templateMockup(type),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: selected
                            ? const Color(0xFF2E6B4E)
                            : Colors.white.withOpacity(0.95),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: selected
                          ? const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 17,
                      )
                          : null,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.92),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        template['icon'],
                        color: const Color(0xFF17324A),
                        size: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              template['name'],
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF17324A),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              template['desc'],
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF17324A).withOpacity(0.55),
                fontSize: 10.5,
                height: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 7),
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: double.infinity,
              height: 32,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF2E6B4E)
                    : const Color(0xFFF1F3EE),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  selected ? 'محدد' : 'اختيار',
                  style: TextStyle(
                    color: selected ? Colors.white : const Color(0xFF17324A),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _mockBackground(String type) {
    if (type == 'grid') return const Color(0xFFDCEED6);
    if (type == 'carousel') return const Color(0xFFE7F2DE);
    if (type == 'featured') return const Color(0xFFD5E9D0);
    return const Color(0xFFE1E1DC);
  }

  Widget _selectedSummary(Map<String, dynamic> template) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF5EA),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF2E6B4E).withOpacity(0.18),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFF2E6B4E),
            child: Icon(
              template['icon'],
              color: Colors.white,
              size: 25,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  template['name'],
                  style: const TextStyle(
                    color: Color(0xFF17324A),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  template['desc'],
                  style: TextStyle(
                    color: const Color(0xFF17324A).withOpacity(0.58),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF2E6B4E),
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget _templateMockup(String type) {
    if (type == 'grid') return _gridMockup();
    if (type == 'carousel') return _carouselMockup();
    if (type == 'featured') return _featuredMockup();
    return _videoMockup();
  }

  Widget _mockHeader({bool compact = false}) {
    return Container(
      height: compact ? 20 : 28,
      decoration: const BoxDecoration(
        color: Color(0xFFB9C39B),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
    );
  }

  Widget _gridMockup() {
    return Column(
      children: [
        _mockHeader(),
        const SizedBox(height: 6),
        Expanded(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 0.82,
            ),
            itemBuilder: (_, __) => _smallProduct(),
          ),
        ),
      ],
    );
  }

  Widget _carouselMockup() {
    return Column(
      children: [
        _mockHeader(),
        const SizedBox(height: 8),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.translate(
                offset: const Offset(-28, 14),
                child: Opacity(
                  opacity: 0.45,
                  child: Transform.scale(
                    scale: 0.78,
                    child: _wideProduct(),
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(28, -12),
                child: Opacity(
                  opacity: 0.45,
                  child: Transform.scale(
                    scale: 0.78,
                    child: _wideProduct(),
                  ),
                ),
              ),
              Transform.scale(
                scale: 0.9,
                child: _wideProduct(),
              ),
            ],
          ),
        ),
        Container(
          height: 9,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
        ),
      ],
    );
  }

  Widget _featuredMockup() {
    return Column(
      children: [
        _mockHeader(),
        const SizedBox(height: 8),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _line(42),
                    const SizedBox(height: 5),
                    _line(34),
                    const SizedBox(height: 5),
                    _line(28),
                  ],
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.image_outlined,
                    color: Color(0xFF17324A),
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(child: _smallProduct(simple: true)),
              const SizedBox(width: 6),
              Expanded(child: _smallProduct(simple: true)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _videoMockup() {
    return Column(
      children: [
        _mockHeader(),
        const SizedBox(height: 8),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(child: _miniProduct()),
              const SizedBox(width: 5),
              Expanded(child: _miniProduct()),
              const SizedBox(width: 5),
              Expanded(child: _miniProduct()),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFB9C39B)),
            ),
            child: const Center(
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xFFD1D1D1),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 23,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _smallProduct({bool simple = false}) {
    return Container(
      padding: EdgeInsets.all(simple ? 4 : 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Icon(
                Icons.image_outlined,
                color: Color(0xFF17324A),
                size: 16,
              ),
            ),
          ),
          if (!simple) const SizedBox(height: 4),
          if (!simple)
            Row(
              children: [
                Container(
                  width: 20,
                  height: 9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.add, size: 8),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _line(20),
                    const SizedBox(height: 2),
                    _line(14),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _wideProduct() {
    return Container(
      width: 100,
      height: 52,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F5),
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 31,
            height: 31,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.image_outlined,
              color: Color(0xFF17324A),
              size: 16,
            ),
          ),
          const SizedBox(width: 7),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _line(28),
              const SizedBox(height: 4),
              _line(20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniProduct() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.image_outlined,
        color: Color(0xFF17324A),
        size: 17,
      ),
    );
  }

  Widget _line(double width) {
    return Container(
      width: width,
      height: 3,
      decoration: BoxDecoration(
        color: const Color(0xFF17324A).withOpacity(0.75),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}