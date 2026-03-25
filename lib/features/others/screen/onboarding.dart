import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayyor/core/themes/app_sizes.dart';
import 'package:sayyor/core/themes/app_colors.dart';
import 'package:sayyor/features/others/screen/selection_user.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// --- ONBOARDING MODELI ---
class OnboardingContent {
  final String title;
  final String description;
  final String imageUrl;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // --- SAHIFALAR MA'LUMOTI ---
  final List<OnboardingContent> _contents = [
    OnboardingContent(
      title: "Izlagan ustangizni oson toping",
      description:
          "Yuzlab malakali ustalar, santexniklar va elektriklar endi bitta ilovada. O'zingizga qulay vaqtda xizmat buyurtma qiling.",
      imageUrl:
          "https://img.freepik.com/free-vector/home-repair-concept-illustration_114360-4235.jpg", // Test illyustratsiya
    ),
    OnboardingContent(
      title: "Sifatli va ishonchli xizmat",
      description:
          "Barcha ustalarimiz tekshiruvdan o'tgan va mijozlar tomonidan baholangan. Sifatga kafolat beramiz.",
      imageUrl:
          "https://img.freepik.com/free-vector/building-concept-illustration_114360-3243.jpg", // Test illyustratsiya
    ),
    OnboardingContent(
      title: "Vaqt va pulingizni tejang",
      description:
          "Oldindan kelishilgan narxlar va tezkor xizmat. Usta qidirishga vaqt sarflamang, biz sizga eng yaxshilarini topamiz.",
      imageUrl:
          "https://img.freepik.com/free-vector/time-management-concept-illustration_114360-1013.jpg", // Test illyustratsiya
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage == _contents.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
      );
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _onSkip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLastPage = _currentPage == _contents.length - 1;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // 1. O'TKAZIB YUBORISH (SKIP) TUGMASI
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _onSkip,
                child: Text(
                  "O'tkazib yuborish",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.outline,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // 2. PAGE VIEW (Rasmlar va Matnlar)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _contents.length,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      // Kichik miqyosli (Scale) animatsiya sahifa o'zgarayotganda
                      double value = 1.0;
                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                        value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                      }
                      return Transform.scale(scale: value, child: child);
                    },
                    child: _buildPageContent(theme, _contents[index]),
                  );
                },
              ),
            ),

            // 3. PASTKI QISM (Indicator va Button)
            Padding(
              padding: AppSizes.padding24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Smooth Page Indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _contents.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: theme.colorScheme.primary,
                      dotColor: theme.colorScheme.primaryContainer,
                      dotHeight: 8.h,
                      dotWidth: 8.w,
                      expansionFactor: 4, // Aktiv bo'lganda cho'zilishi
                      spacing: 6.w,
                    ),
                  ),

                  // Keyingisi / Boshlash Tugmasi
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 50.h,
                    width: isLastPage
                        ? 140.w
                        : 60.w, // Oxirgi sahifada tugma cho'ziladi
                    child: ElevatedButton(
                      onPressed: _onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppSizes.borderRadius24,
                        ),
                      ),
                      child: isLastPage
                          ? Text(
                              "Boshlash",
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Icon(
                              Icons.arrow_forward_rounded,
                              color: theme.colorScheme.onPrimary,
                              size: 24.sp,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            AppSizes.gH16, // Pastki qism xavfsizligi
          ],
        ),
      ),
    );
  }

  // --- HAR BIR SAHIFA UCHUN KONTENT ---
  Widget _buildPageContent(ThemeData theme, OnboardingContent content) {
    return Padding(
      padding: AppSizes.padding32,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Rasm
          Expanded(
            flex: 6,
            child: Image.network(
              content.imageUrl,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    color: theme.colorScheme.primaryContainer,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.broken_image_outlined,
                  size: 100.sp,
                  color: theme.colorScheme.outline,
                );
              },
            ),
          ),
          AppSizes.gH32,

          // Sarlavha
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Text(
                  content.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                AppSizes.gH16,

                // Tavsif
                Text(
                  content.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
