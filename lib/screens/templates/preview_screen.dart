import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviewScreen extends StatefulWidget {
  final Map template;
  final Map<String, dynamic>? storeData;
  final Map<String, dynamic> customization;

  const PreviewScreen({
    super.key,
    required this.template,
    required this.storeData,
    required this.customization,
  });

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  int currentPage = 0;
  final Map<int, int> carouselIndexes = {};

  Color _color(String key, Color fallback) {
    final value = widget.customization[key];
    if (value is int) return Color(value);
    return fallback;
  }

  double _double(String key, double fallback) {
    final value = widget.customization[key];
    if (value is num) return value.toDouble();
    return fallback;
  }

  int _int(String key, int fallback) {
    final value = widget.customization[key];
    if (value is int) return value;
    return fallback;
  }

  bool _bool(String key, bool fallback) {
    final value = widget.customization[key];
    if (value is bool) return value;
    return fallback;
  }

  String _string(String key, String fallback) {
    final value = widget.customization[key];
    if (value is String) return value;
    return fallback;
  }

  TextStyle appFont({
    required String fontFamily,
    double size = 14,
    FontWeight weight = FontWeight.normal,
    Color? color,
    double? height,
  }) {
    return GoogleFonts.getFont(
      fontFamily,
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
    );
  }

  List<Map<String, dynamic>> _categories() {
    final value = widget.customization['categories'];
    if (value is List) {
      return value.map((e) => Map<String, dynamic>.from(e)).toList();
    }

    return [
      {'title': 'المطبخ', 'icon': Icons.soup_kitchen_rounded.codePoint},
      {'title': 'غرفة النوم', 'icon': Icons.bed_rounded.codePoint},
      {'title': 'الديكور', 'icon': Icons.light_rounded.codePoint},
      {'title': 'التنظيف', 'icon': Icons.cleaning_services_rounded.codePoint},
      {'title': 'عروض', 'icon': Icons.local_offer_rounded.codePoint},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = _color('primaryColor', const Color(0xFF2E6B4E));
    final secondaryColor = _color('secondaryColor', const Color(0xFFA8C5A2));
    final backgroundColor = _color('backgroundColor', const Color(0xFFF7F5F0));
    final textColor = _color('textColor', const Color(0xFF1F2937));
    final buttonColor = _color('buttonColor', primaryColor);
    final buttonTextColor = _color('buttonTextColor', Colors.white);

    final fontFamily = _string('fontFamily', 'Cairo');

    final borderRadius = _double('borderRadius', 22);
    final buttonRadius = _double('buttonRadius', 12);
    final titleSize = _double('titleSize', 22);
    final productNameSize = _double('productNameSize', 14);
    final priceSize = _double('priceSize', 13);

    final hasShadow = _bool('hasShadow', true);
    final imageOnTop = _bool('imageOnTop', true);
    final showProductName = _bool('showProductName', true);
    final showPrice = _bool('showPrice', true);

    final headerStyle = _string('headerStyle', 'full');
    final bottomNavStyle = _string('bottomNavStyle', 'iconsText');

    final featuredBadgeText = _string('featuredBadgeText', 'الأكثر طلبًا');
    final featuredBadgeColor = _color('featuredBadgeColor', primaryColor);
    final featuredPosition = _string('featuredPosition', 'top');

    final carouselCenterScale = _double('carouselCenterScale', 1.0);
    final carouselSideOpacity = _double('carouselSideOpacity', 0.45);
    final carouselHeight = _double('carouselHeight', 305);

    final videoPosition = _string('videoPosition', 'top');
    final videoTitle = _string('videoTitle', 'فيديو تعريفي عن المتجر');
    final videoPlayColor = _color('videoPlayColor', primaryColor);

    final gridColumns = _int('gridColumns', 2);
    final gridSpacing = _double('gridSpacing', 14);
    final gridCardHeight = _double('gridCardHeight', 0.62);

    final storeImagePath = widget.customization['storeImagePath'];
    final logoImagePath = widget.customization['logoImagePath'];
    final categories = _categories();

    final layoutType = widget.template['layout_type'] ?? 'grid';

    final storeName = widget.storeData?['name'] ?? 'اسم المتجر';
    final storeDescription =
        widget.storeData?['description'] ?? 'وصف المتجر يظهر هنا بشكل مختصر';
    final storeCategory = widget.storeData?['category'] ?? 'تصنيف المتجر';
    final phone = widget.storeData?['phone'] ?? '777000000';

    final products = [
      {
        'name': 'منتج مميز',
        'price': '120 ريال',
        'icon': Icons.shopping_bag_rounded,
      },
      {
        'name': 'هدية فاخرة',
        'price': '85 ريال',
        'icon': Icons.card_giftcard_rounded,
      },
      {
        'name': 'منتج منزلي',
        'price': '60 ريال',
        'icon': Icons.chair_rounded,
      },
      {
        'name': 'عرض خاص',
        'price': '45 ريال',
        'icon': Icons.local_offer_rounded,
      },
      {
        'name': 'منتج جديد',
        'price': '99 ريال',
        'icon': Icons.spa_rounded,
      },
      {
        'name': 'اختيار مميز',
        'price': '150 ريال',
        'icon': Icons.favorite_rounded,
      },
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        bottomNavigationBar: _bottomNav(
          style: bottomNavStyle,
          primaryColor: primaryColor,
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              if (currentPage == 0)
                _homePage(
                  context: context,
                  storeName: storeName,
                  storeDescription: storeDescription,
                  storeCategory: storeCategory,
                  primaryColor: primaryColor,
                  secondaryColor: secondaryColor,
                  textColor: textColor,
                  buttonColor: buttonColor,
                  buttonTextColor: buttonTextColor,
                  fontFamily: fontFamily,
                  titleSize: titleSize,
                  borderRadius: borderRadius,
                  buttonRadius: buttonRadius,
                  hasShadow: hasShadow,
                  headerStyle: headerStyle,
                  storeImagePath: storeImagePath,
                  logoImagePath: logoImagePath,
                  categories: categories,
                  layoutType: layoutType,
                  products: products,
                  productNameSize: productNameSize,
                  priceSize: priceSize,
                  imageOnTop: imageOnTop,
                  showProductName: showProductName,
                  showPrice: showPrice,
                  featuredBadgeText: featuredBadgeText,
                  featuredBadgeColor: featuredBadgeColor,
                  featuredPosition: featuredPosition,
                  carouselCenterScale: carouselCenterScale,
                  carouselSideOpacity: carouselSideOpacity,
                  carouselHeight: carouselHeight,
                  videoPosition: videoPosition,
                  videoTitle: videoTitle,
                  videoPlayColor: videoPlayColor,
                  gridColumns: gridColumns,
                  gridSpacing: gridSpacing,
                  gridCardHeight: gridCardHeight,
                )
              else if (currentPage == 1)
                _productsPage(
                  products: products,
                  primaryColor: primaryColor,
                  secondaryColor: secondaryColor,
                  buttonColor: buttonColor,
                  buttonTextColor: buttonTextColor,
                  textColor: textColor,
                  fontFamily: fontFamily,
                  borderRadius: borderRadius,
                  buttonRadius: buttonRadius,
                  productNameSize: productNameSize,
                  priceSize: priceSize,
                  hasShadow: hasShadow,
                  imageOnTop: imageOnTop,
                  showProductName: showProductName,
                  showPrice: showPrice,
                  gridColumns: gridColumns,
                  gridSpacing: gridSpacing,
                  gridCardHeight: gridCardHeight,
                )
              else if (currentPage == 2)
                  _aboutPage(
                    storeName: storeName,
                    storeDescription: storeDescription,
                    primaryColor: primaryColor,
                    secondaryColor: secondaryColor,
                    textColor: textColor,
                    fontFamily: fontFamily,
                    borderRadius: borderRadius,
                    hasShadow: hasShadow,
                  )
                else
                  _contactPage(
                    phone: phone,
                    primaryColor: primaryColor,
                    textColor: textColor,
                    fontFamily: fontFamily,
                    borderRadius: borderRadius,
                    hasShadow: hasShadow,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  SliverList _homePage({
    required BuildContext context,
    required String storeName,
    required String storeDescription,
    required String storeCategory,
    required Color primaryColor,
    required Color secondaryColor,
    required Color textColor,
    required Color buttonColor,
    required Color buttonTextColor,
    required String fontFamily,
    required double titleSize,
    required double borderRadius,
    required double buttonRadius,
    required bool hasShadow,
    required String headerStyle,
    required dynamic storeImagePath,
    required dynamic logoImagePath,
    required List<Map<String, dynamic>> categories,
    required String layoutType,
    required List<Map<String, dynamic>> products,
    required double productNameSize,
    required double priceSize,
    required bool imageOnTop,
    required bool showProductName,
    required bool showPrice,
    required String featuredBadgeText,
    required Color featuredBadgeColor,
    required String featuredPosition,
    required double carouselCenterScale,
    required double carouselSideOpacity,
    required double carouselHeight,
    required String videoPosition,
    required String videoTitle,
    required Color videoPlayColor,
    required int gridColumns,
    required double gridSpacing,
    required double gridCardHeight,
  }) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          _storeHeader(
            context: context,
            storeName: storeName,
            storeDescription: storeDescription,
            storeCategory: storeCategory,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
            textColor: textColor,
            buttonColor: buttonColor,
            buttonTextColor: buttonTextColor,
            fontFamily: fontFamily,
            titleSize: titleSize,
            borderRadius: borderRadius,
            buttonRadius: buttonRadius,
            hasShadow: hasShadow,
            headerStyle: headerStyle,
            storeImagePath: storeImagePath,
            logoImagePath: logoImagePath,
            categories: categories,
          ),

          if (layoutType == 'video' && videoPosition == 'top')
            _videoSection(
              primaryColor: primaryColor,
              secondaryColor: secondaryColor,
              textColor: textColor,
              fontFamily: fontFamily,
              borderRadius: borderRadius,
              hasShadow: hasShadow,
              videoTitle: videoTitle,
              videoPlayColor: videoPlayColor,
            ),

          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 12),
            child: _sectionTitle(
              layoutType == 'featured'
                  ? 'المنتج المميز'
                  : layoutType == 'carousel'
                  ? 'تصفح المنتجات'
                  : 'منتجات مميزة',
              textColor,
              fontFamily,
            ),
          ),

          _productsBody(
            layoutType: layoutType,
            products: products,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
            buttonColor: buttonColor,
            buttonTextColor: buttonTextColor,
            textColor: textColor,
            fontFamily: fontFamily,
            borderRadius: borderRadius,
            buttonRadius: buttonRadius,
            productNameSize: productNameSize,
            priceSize: priceSize,
            hasShadow: hasShadow,
            imageOnTop: imageOnTop,
            showProductName: showProductName,
            showPrice: showPrice,
            featuredBadgeText: featuredBadgeText,
            featuredBadgeColor: featuredBadgeColor,
            featuredPosition: featuredPosition,
            carouselCenterScale: carouselCenterScale,
            carouselSideOpacity: carouselSideOpacity,
            carouselHeight: carouselHeight,
            gridColumns: gridColumns,
            gridSpacing: gridSpacing,
            gridCardHeight: gridCardHeight,
          ),

          if (layoutType == 'video' && videoPosition == 'bottom')
            _videoSection(
              primaryColor: primaryColor,
              secondaryColor: secondaryColor,
              textColor: textColor,
              fontFamily: fontFamily,
              borderRadius: borderRadius,
              hasShadow: hasShadow,
              videoTitle: videoTitle,
              videoPlayColor: videoPlayColor,
            ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  SliverList _productsPage({
    required List<Map<String, dynamic>> products,
    required Color primaryColor,
    required Color secondaryColor,
    required Color buttonColor,
    required Color buttonTextColor,
    required Color textColor,
    required String fontFamily,
    required double borderRadius,
    required double buttonRadius,
    required double productNameSize,
    required double priceSize,
    required bool hasShadow,
    required bool imageOnTop,
    required bool showProductName,
    required bool showPrice,
    required int gridColumns,
    required double gridSpacing,
    required double gridCardHeight,
  }) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          _pageHeader(
            'المنتجات',
            Icons.shopping_bag_rounded,
            primaryColor,
            textColor,
            fontFamily,
          ),
          GridView.builder(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridColumns,
              mainAxisSpacing: gridSpacing,
              crossAxisSpacing: gridSpacing,
              childAspectRatio: gridCardHeight,
            ),
            itemBuilder: (context, index) {
              final product = products[index];

              return _productCard(
                name: product['name'] as String,
                price: product['price'] as String,
                icon: product['icon'] as IconData,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
                buttonColor: buttonColor,
                buttonTextColor: buttonTextColor,
                textColor: textColor,
                fontFamily: fontFamily,
                borderRadius: borderRadius,
                buttonRadius: buttonRadius,
                productNameSize: productNameSize,
                priceSize: priceSize,
                hasShadow: hasShadow,
                imageOnTop: imageOnTop,
                showProductName: showProductName,
                showPrice: showPrice,
              );
            },
          ),
        ],
      ),
    );
  }

  SliverList _aboutPage({
    required String storeName,
    required String storeDescription,
    required Color primaryColor,
    required Color secondaryColor,
    required Color textColor,
    required String fontFamily,
    required double borderRadius,
    required bool hasShadow,
  }) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          _pageHeader('من نحن', Icons.info_rounded, primaryColor, textColor, fontFamily),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: hasShadow ? _shadow() : [],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 42,
                    backgroundColor: secondaryColor.withOpacity(0.35),
                    child: Icon(
                      Icons.storefront_rounded,
                      color: primaryColor,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    storeName,
                    style: appFont(
                      fontFamily: fontFamily,
                      color: textColor,
                      size: 22,
                      weight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    storeDescription,
                    textAlign: TextAlign.center,
                    style: appFont(
                      fontFamily: fontFamily,
                      color: textColor.withOpacity(0.72),
                      size: 14,
                      height: 1.7,
                      weight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverList _contactPage({
    required String phone,
    required Color primaryColor,
    required Color textColor,
    required String fontFamily,
    required double borderRadius,
    required bool hasShadow,
  }) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          _pageHeader('تواصل', Icons.call_rounded, primaryColor, textColor, fontFamily),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                _contactCard(Icons.phone_rounded, 'رقم الجوال', phone,
                    primaryColor, textColor, fontFamily, borderRadius, hasShadow),
                const SizedBox(height: 12),
                _contactCard(Icons.chat_rounded, 'واتساب', phone,
                    primaryColor, textColor, fontFamily, borderRadius, hasShadow),
                const SizedBox(height: 12),
                _contactCard(Icons.location_on_rounded, 'الموقع', 'يتم تحديده لاحقًا',
                    primaryColor, textColor, fontFamily, borderRadius, hasShadow),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _productsBody({
    required String layoutType,
    required List<Map<String, dynamic>> products,
    required Color primaryColor,
    required Color secondaryColor,
    required Color buttonColor,
    required Color buttonTextColor,
    required Color textColor,
    required String fontFamily,
    required double borderRadius,
    required double buttonRadius,
    required double productNameSize,
    required double priceSize,
    required bool hasShadow,
    required bool imageOnTop,
    required bool showProductName,
    required bool showPrice,
    required String featuredBadgeText,
    required Color featuredBadgeColor,
    required String featuredPosition,
    required double carouselCenterScale,
    required double carouselSideOpacity,
    required double carouselHeight,
    required int gridColumns,
    required double gridSpacing,
    required double gridCardHeight,
  }) {
    if (layoutType == 'carousel') {
      return Column(
        children: [
          _carouselRow(
            rowIndex: 0,
            products: products.take(3).toList(),
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
            buttonColor: buttonColor,
            buttonTextColor: buttonTextColor,
            textColor: textColor,
            fontFamily: fontFamily,
            borderRadius: borderRadius,
            buttonRadius: buttonRadius,
            productNameSize: productNameSize,
            priceSize: priceSize,
            hasShadow: hasShadow,
            imageOnTop: imageOnTop,
            showProductName: showProductName,
            showPrice: showPrice,
            carouselCenterScale: carouselCenterScale,
            carouselSideOpacity: carouselSideOpacity,
            carouselHeight: carouselHeight,
          ),
          const SizedBox(height: 16),
          _carouselRow(
            rowIndex: 1,
            products: products.skip(3).take(3).toList(),
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
            buttonColor: buttonColor,
            buttonTextColor: buttonTextColor,
            textColor: textColor,
            fontFamily: fontFamily,
            borderRadius: borderRadius,
            buttonRadius: buttonRadius,
            productNameSize: productNameSize,
            priceSize: priceSize,
            hasShadow: hasShadow,
            imageOnTop: imageOnTop,
            showProductName: showProductName,
            showPrice: showPrice,
            carouselCenterScale: carouselCenterScale,
            carouselSideOpacity: carouselSideOpacity,
            carouselHeight: carouselHeight,
          ),
        ],
      );
    }

    if (layoutType == 'featured') {
      final featured = products.first;
      final rest = products.skip(1).toList();

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
            child: _featuredProductCard(
              name: featured['name'] as String,
              price: featured['price'] as String,
              icon: featured['icon'] as IconData,
              primaryColor: primaryColor,
              secondaryColor: secondaryColor,
              buttonColor: buttonColor,
              buttonTextColor: buttonTextColor,
              textColor: textColor,
              fontFamily: fontFamily,
              borderRadius: borderRadius,
              buttonRadius: buttonRadius,
              hasShadow: hasShadow,
              badgeText: featuredBadgeText,
              badgeColor: featuredBadgeColor,
              position: featuredPosition,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
            child: _sectionTitle('باقي المنتجات', textColor, fontFamily),
          ),
          GridView.builder(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rest.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridColumns,
              mainAxisSpacing: gridSpacing,
              crossAxisSpacing: gridSpacing,
              childAspectRatio: gridCardHeight,
            ),
            itemBuilder: (context, index) {
              final product = rest[index];

              return _productCard(
                name: product['name'] as String,
                price: product['price'] as String,
                icon: product['icon'] as IconData,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
                buttonColor: buttonColor,
                buttonTextColor: buttonTextColor,
                textColor: textColor,
                fontFamily: fontFamily,
                borderRadius: borderRadius,
                buttonRadius: buttonRadius,
                productNameSize: productNameSize,
                priceSize: priceSize,
                hasShadow: hasShadow,
                imageOnTop: imageOnTop,
                showProductName: showProductName,
                showPrice: showPrice,
              );
            },
          ),
        ],
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridColumns,
        mainAxisSpacing: gridSpacing,
        crossAxisSpacing: gridSpacing,
        childAspectRatio: gridCardHeight,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return _productCard(
          name: product['name'] as String,
          price: product['price'] as String,
          icon: product['icon'] as IconData,
          primaryColor: primaryColor,
          secondaryColor: secondaryColor,
          buttonColor: buttonColor,
          buttonTextColor: buttonTextColor,
          textColor: textColor,
          fontFamily: fontFamily,
          borderRadius: borderRadius,
          buttonRadius: buttonRadius,
          productNameSize: productNameSize,
          priceSize: priceSize,
          hasShadow: hasShadow,
          imageOnTop: imageOnTop,
          showProductName: showProductName,
          showPrice: showPrice,
        );
      },
    );
  }

  Widget _carouselRow({
    required int rowIndex,
    required List<Map<String, dynamic>> products,
    required Color primaryColor,
    required Color secondaryColor,
    required Color buttonColor,
    required Color buttonTextColor,
    required Color textColor,
    required String fontFamily,
    required double borderRadius,
    required double buttonRadius,
    required double productNameSize,
    required double priceSize,
    required bool hasShadow,
    required bool imageOnTop,
    required bool showProductName,
    required bool showPrice,
    required double carouselCenterScale,
    required double carouselSideOpacity,
    required double carouselHeight,
  }) {
    carouselIndexes[rowIndex] ??= 1;

    return SizedBox(
      height: carouselHeight,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.58,
          initialPage: carouselIndexes[rowIndex]!,
        ),
        itemCount: products.length,
        padEnds: true,
        onPageChanged: (index) {
          setState(() {
            carouselIndexes[rowIndex] = index;
          });
        },
        itemBuilder: (context, index) {
          final product = products[index];
          final selected = carouselIndexes[rowIndex] == index;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            margin: EdgeInsets.symmetric(
              horizontal: 7,
              vertical: selected ? 0 : 22,
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: selected ? 1 : carouselSideOpacity,
              child: Transform.scale(
                scale: selected ? carouselCenterScale : 0.88,
                child: _productCard(
                  name: product['name'] as String,
                  price: product['price'] as String,
                  icon: product['icon'] as IconData,
                  primaryColor: primaryColor,
                  secondaryColor: secondaryColor,
                  buttonColor: buttonColor,
                  buttonTextColor: buttonTextColor,
                  textColor: textColor,
                  fontFamily: fontFamily,
                  borderRadius: borderRadius,
                  buttonRadius: buttonRadius,
                  productNameSize: productNameSize,
                  priceSize: priceSize,
                  hasShadow: hasShadow,
                  imageOnTop: imageOnTop,
                  showProductName: showProductName,
                  showPrice: showPrice,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _storeHeader({
    required BuildContext context,
    required String storeName,
    required String storeDescription,
    required String storeCategory,
    required Color primaryColor,
    required Color secondaryColor,
    required Color textColor,
    required Color buttonColor,
    required Color buttonTextColor,
    required String fontFamily,
    required double titleSize,
    required double borderRadius,
    required double buttonRadius,
    required bool hasShadow,
    required String headerStyle,
    required dynamic storeImagePath,
    required dynamic logoImagePath,
    required List<Map<String, dynamic>> categories,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: hasShadow ? _shadow() : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Column(
            children: [
              _storeNavBar(
                context: context,
                storeName: storeName,
                storeCategory: storeCategory,
                primaryColor: primaryColor,
                textColor: textColor,
                fontFamily: fontFamily,
                headerStyle: headerStyle,
              ),
              _heroBanner(
                storeName: storeName,
                storeDescription: storeDescription,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
                textColor: textColor,
                buttonColor: buttonColor,
                buttonTextColor: buttonTextColor,
                fontFamily: fontFamily,
                titleSize: titleSize,
                buttonRadius: buttonRadius,
                headerStyle: headerStyle,
                storeImagePath: storeImagePath,
                logoImagePath: logoImagePath,
              ),
              _categoriesPreview(
                categories: categories,
                primaryColor: primaryColor,
                textColor: textColor,
                fontFamily: fontFamily,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _storeNavBar({
    required BuildContext context,
    required String storeName,
    required String storeCategory,
    required Color primaryColor,
    required Color textColor,
    required String fontFamily,
    required String headerStyle,
  }) {
    final isTransparent = headerStyle == 'transparent';
    final isCompact = headerStyle == 'compact';

    return Container(
      height: isCompact ? 60 : 76,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: isTransparent ? Colors.white : primaryColor,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_rounded,
              color: isTransparent ? textColor : Colors.white,
            ),
          ),
          Icon(
            Icons.menu_rounded,
            color: isTransparent ? textColor : Colors.white,
            size: 28,
          ),
          const Spacer(),
          SizedBox(
            width: 115,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  storeName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: appFont(
                    fontFamily: fontFamily,
                    color: isTransparent ? textColor : Colors.white,
                    size: isCompact ? 15 : 18,
                    weight: FontWeight.bold,
                  ),
                ),
                Text(
                  storeCategory,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: appFont(
                    fontFamily: fontFamily,
                    color: isTransparent
                        ? textColor.withOpacity(0.55)
                        : Colors.white.withOpacity(0.85),
                    size: isCompact ? 10 : 12,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Icon(
            Icons.search_rounded,
            color: isTransparent ? textColor : Colors.white,
            size: 28,
          ),
          const SizedBox(width: 14),
          Stack(
            children: [
              Icon(
                Icons.shopping_cart_rounded,
                color: isTransparent ? textColor : Colors.white,
                size: 28,
              ),
              Positioned(
                top: 0,
                left: 0,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: isTransparent ? primaryColor : Colors.white,
                  child: Text(
                    '2',
                    style: appFont(
                      fontFamily: fontFamily,
                      color: isTransparent ? Colors.white : primaryColor,
                      size: 9,
                      weight: FontWeight.bold,
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

  Widget _heroBanner({
    required String storeName,
    required String storeDescription,
    required Color primaryColor,
    required Color secondaryColor,
    required Color textColor,
    required Color buttonColor,
    required Color buttonTextColor,
    required String fontFamily,
    required double titleSize,
    required double buttonRadius,
    required String headerStyle,
    required dynamic storeImagePath,
    required dynamic logoImagePath,
  }) {
    final isCenter = headerStyle == 'center';
    final isCompact = headerStyle == 'compact';

    return Container(
      height: isCompact ? 170 : 205,
      width: double.infinity,
      color: secondaryColor.withOpacity(0.45),
      child: Stack(
        children: [
          Positioned.fill(
            child: storeImagePath != null && storeImagePath.toString().isNotEmpty
                ? Image.file(File(storeImagePath), fit: BoxFit.cover)
                : Container(
              color: secondaryColor.withOpacity(0.45),
              child: Icon(
                Icons.image_rounded,
                color: primaryColor.withOpacity(0.35),
                size: 110,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.white.withOpacity(0.22)),
          ),
          Positioned(
            top: 18,
            right: 20,
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: logoImagePath != null && logoImagePath.toString().isNotEmpty
                  ? ClipOval(
                child: Image.file(
                  File(logoImagePath),
                  width: 58,
                  height: 58,
                  fit: BoxFit.cover,
                ),
              )
                  : Icon(
                Icons.storefront_rounded,
                color: primaryColor,
                size: 30,
              ),
            ),
          ),
          Positioned(
            right: isCenter ? 20 : 26,
            left: isCenter ? 20 : 120,
            bottom: 28,
            child: Column(
              crossAxisAlignment:
              isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                Text(
                  storeName,
                  textAlign: isCenter ? TextAlign.center : TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: appFont(
                    fontFamily: fontFamily,
                    color: textColor,
                    size: isCompact ? titleSize - 3 : titleSize,
                    height: 1.3,
                    weight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  storeDescription,
                  textAlign: isCenter ? TextAlign.center : TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: appFont(
                    fontFamily: fontFamily,
                    color: textColor.withOpacity(0.70),
                    size: 12,
                    height: 1.4,
                    weight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(buttonRadius),
                  ),
                  child: Text(
                    'تسوق الآن',
                    style: appFont(
                      fontFamily: fontFamily,
                      color: buttonTextColor,
                      size: 13,
                      weight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoriesPreview({
    required List<Map<String, dynamic>> categories,
    required Color primaryColor,
    required Color textColor,
    required String fontFamily,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((item) {
            final iconCode = item['icon'];
            final title = item['title']?.toString() ?? 'قسم';

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Icon(
                    IconData(iconCode, fontFamily: 'MaterialIcons'),
                    color: primaryColor,
                    size: 28,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: appFont(
                      fontFamily: fontFamily,
                      color: textColor,
                      size: 11.5,
                      weight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _videoSection({
    required Color primaryColor,
    required Color secondaryColor,
    required Color textColor,
    required String fontFamily,
    required double borderRadius,
    required bool hasShadow,
    required String videoTitle,
    required Color videoPlayColor,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 4),
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          color: secondaryColor.withOpacity(0.35),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: hasShadow ? _shadow() : [],
        ),
        child: Stack(
          children: [
            Center(
              child: CircleAvatar(
                radius: 34,
                backgroundColor: videoPlayColor,
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 44,
                ),
              ),
            ),
            Positioned(
              right: 18,
              bottom: 16,
              child: Text(
                videoTitle,
                style: appFont(
                  fontFamily: fontFamily,
                  color: textColor,
                  size: 15,
                  weight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featuredProductCard({
    required String name,
    required String price,
    required IconData icon,
    required Color primaryColor,
    required Color secondaryColor,
    required Color buttonColor,
    required Color buttonTextColor,
    required Color textColor,
    required String fontFamily,
    required double borderRadius,
    required double buttonRadius,
    required bool hasShadow,
    required String badgeText,
    required Color badgeColor,
    required String position,
  }) {
    final imageBox = Container(
      width: position == 'side' ? 125 : double.infinity,
      height: position == 'side' ? 125 : 150,
      decoration: BoxDecoration(
        color: secondaryColor.withOpacity(0.35),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(icon, color: primaryColor, size: 58),
    );

    final details = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              badgeText,
              style: appFont(
                fontFamily: fontFamily,
                color: Colors.white,
                size: 11,
                weight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: appFont(
              fontFamily: fontFamily,
              color: textColor,
              size: 18,
              weight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            price,
            style: appFont(
              fontFamily: fontFamily,
              color: primaryColor,
              size: 14,
              weight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(buttonRadius),
            ),
            child: Text(
              'اطلبي الآن',
              style: appFont(
                fontFamily: fontFamily,
                color: buttonTextColor,
                size: 12,
                weight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: hasShadow ? _shadow() : [],
      ),
      child: position == 'side'
          ? Row(
        children: [
          imageBox,
          const SizedBox(width: 14),
          details,
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageBox,
          const SizedBox(height: 14),
          Row(children: [details]),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, Color textColor, String fontFamily) {
    return Row(
      children: [
        Text(
          title,
          style: appFont(
            fontFamily: fontFamily,
            color: textColor,
            size: 19,
            weight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          'عرض الكل',
          style: appFont(
            fontFamily: fontFamily,
            color: textColor.withOpacity(0.45),
            size: 12,
            weight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _productCard({
    required String name,
    required String price,
    required IconData icon,
    required Color primaryColor,
    required Color secondaryColor,
    required Color buttonColor,
    required Color buttonTextColor,
    required Color textColor,
    required String fontFamily,
    required double borderRadius,
    required double buttonRadius,
    required double productNameSize,
    required double priceSize,
    required bool hasShadow,
    required bool imageOnTop,
    required bool showProductName,
    required bool showPrice,
  }) {
    final image = Container(
      height: 95,
      decoration: BoxDecoration(
        color: secondaryColor.withOpacity(0.35),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(child: Icon(icon, color: primaryColor, size: 40)),
    );

    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showProductName)
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: appFont(
              fontFamily: fontFamily,
              color: textColor,
              size: productNameSize,
              weight: FontWeight.bold,
            ),
          ),
        if (showProductName && showPrice) const SizedBox(height: 4),
        if (showPrice)
          Text(
            price,
            style: appFont(
              fontFamily: fontFamily,
              color: primaryColor,
              size: priceSize,
              weight: FontWeight.w800,
            ),
          ),
      ],
    );

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: hasShadow ? _shadow() : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageOnTop) image,
          if (imageOnTop) const SizedBox(height: 10),
          details,
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 34,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart_outlined, size: 14),
              label: Text(
                'إضافة',
                style: appFont(
                  fontFamily: fontFamily,
                  color: buttonTextColor,
                  size: 11,
                  weight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: buttonTextColor,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonRadius),
                ),
              ),
            ),
          ),
          if (!imageOnTop) const SizedBox(height: 10),
          if (!imageOnTop) image,
        ],
      ),
    );
  }

  Widget _pageHeader(
      String title,
      IconData icon,
      Color primaryColor,
      Color textColor,
      String fontFamily,
      ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 28),
          const SizedBox(width: 8),
          Text(
            title,
            style: appFont(
              fontFamily: fontFamily,
              color: textColor,
              size: 24,
              weight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactCard(
      IconData icon,
      String title,
      String value,
      Color primaryColor,
      Color textColor,
      String fontFamily,
      double borderRadius,
      bool hasShadow,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: hasShadow ? _shadow() : [],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: primaryColor.withOpacity(0.12),
            child: Icon(icon, color: primaryColor),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: appFont(
                  fontFamily: fontFamily,
                  color: textColor,
                  size: 13,
                  weight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: appFont(
                  fontFamily: fontFamily,
                  color: textColor.withOpacity(0.6),
                  size: 12,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget? _bottomNav({
    required String style,
    required Color primaryColor,
    required Color textColor,
    required String fontFamily,
  }) {
    if (style == 'none') return null;

    if (style == 'dots') {
      return Container(
        height: 66,
        margin: const EdgeInsets.fromLTRB(18, 0, 18, 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: _shadow(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _navDot(currentPage == 0, primaryColor),
            _navDot(currentPage == 1, primaryColor),
            _navDot(currentPage == 2, primaryColor),
            _navDot(currentPage == 3, primaryColor),
          ],
        ),
      );
    }

    final showText = style == 'iconsText';

    return Container(
      height: showText ? 76 : 66,
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 14),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: _shadow(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_rounded, 'الرئيسية', 0, showText,
              primaryColor, textColor, fontFamily),
          _navItem(Icons.shopping_bag_rounded, 'المنتجات', 1, showText,
              primaryColor, textColor, fontFamily),
          _navItem(Icons.info_rounded, 'من نحن', 2, showText,
              primaryColor, textColor, fontFamily),
          _navItem(Icons.call_rounded, 'تواصل', 3, showText,
              primaryColor, textColor, fontFamily),
        ],
      ),
    );
  }

  Widget _navItem(
      IconData icon,
      String title,
      int index,
      bool showText,
      Color primaryColor,
      Color textColor,
      String fontFamily,
      ) {
    final selected = currentPage == index;

    return GestureDetector(
      onTap: () {
        setState(() => currentPage = index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: selected ? primaryColor : textColor.withOpacity(0.35),
            size: 24,
          ),
          if (showText) const SizedBox(height: 4),
          if (showText)
            Text(
              title,
              style: appFont(
                fontFamily: fontFamily,
                color: selected ? primaryColor : textColor.withOpacity(0.45),
                size: 11,
                weight: selected ? FontWeight.bold : FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }

  Widget _navDot(bool active, Color primaryColor) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: active ? 18 : 8,
        height: 8,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: active ? primaryColor : primaryColor.withOpacity(0.25),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  List<BoxShadow> _shadow() {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.055),
        blurRadius: 18,
        offset: const Offset(0, 8),
      ),
    ];
  }
}