import 'package:flutter/material.dart';
import 'package:hotelino/features/onboarding/presentation/onboarding_provider.dart';
import 'package:hotelino/features/onboarding/presentation/widgets/onboarding_item.dart';
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
                onboardingProvider.updateCourentPage;
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
          SizedBox(height: 20),
          buildPageInsicator(
            onboardingProvider.courentPage,
            totoalPage,
            context,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
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
          ),
        ),
      ),
    );
  }
}
