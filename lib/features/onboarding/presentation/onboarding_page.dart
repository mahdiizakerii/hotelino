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
    final intTotoalPage = onBoradinData.length;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: intTotoalPage,
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
        ],
      ),
    );
  }
}
