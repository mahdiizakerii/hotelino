import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotelino/features/onboarding/presentation/onboarding_provider.dart';
import 'package:hotelino/features/onboarding/presentation/widgets/onboarding_button.dart';
import 'package:hotelino/features/onboarding/presentation/widgets/onboarding_item.dart';
import 'package:hotelino/routes/app_routes.dart';
import 'package:hotelino/shared/services/onboarding_storage_service.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final onboardingProvider = Provider.of<OnboardingProvider>(context);
    final onBoradinData = onboardingProvider.onboardingListData;
    final totoalPage = onBoradinData.length;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: totoalPage,
              onPageChanged: (value) {
                onboardingProvider.updateCourentPage(value);
              },
              itemBuilder: (context, index) {
                final data = onBoradinData[index];
                return OnboardingItem(
                  title: data["title"]!,
                  description: data["description"]!,
                  image: data["image"]!,
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          buildPageInsicator(
            onboardingProvider.courentPage,
            totoalPage,
            context,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OnboardingButton(
                  visible: onboardingProvider.courentPage > 0,
                  icon: SvgPicture.asset('assets/icon/preview.svg'),
                  onPressed: _previewsPage,
                  backgroundColor: Colors.transparent,
                  iconColor: Theme.of(context).colorScheme.primary,
                ),
                OnboardingButton(
                  visible: onboardingProvider.courentPage < totoalPage - 1,
                  icon: SvgPicture.asset('assets/icon/next.svg'),
                  onPressed: _nextviewsPage,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  iconColor: Colors.white,
                ),
              ],
            ),
          ),

          SizedBox(height: 30),
          if (totoalPage > 1) ...[
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return SizeTransition(child: child, sizeFactor: animation);
              },
              child: onboardingProvider.courentPage == totoalPage - 1
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            await OnboardingStorageService.setCompleted();
                            if (!context.mounted) return;
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.home,
                            );
                          },
                          child: const Text('شروع رزرو هتل ها'),
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ],
      ),
    );
  }

  void _nextviewsPage() {
    final onboardingProvider = Provider.of<OnboardingProvider>(
      context,
      listen: false,
    );
    if (onboardingProvider.courentPage <
        onboardingProvider.onboardingListData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _previewsPage() {
    final onboardingProvider = Provider.of<OnboardingProvider>(
      context,
      listen: false,
    );
    if (onboardingProvider.courentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget buildPageInsicator(
    int courentIndex,
    int totalPages,
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: courentIndex == index ? 12 : 8,
          height: courentIndex == index ? 12 : 8,
          decoration: BoxDecoration(
            color: courentIndex == index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
