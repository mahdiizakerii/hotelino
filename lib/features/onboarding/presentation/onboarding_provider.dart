import 'package:flutter/material.dart';
import 'package:hotelino/features/onboarding/data/repository/onboarding_repository.dart';

class OnboardingProvider extends ChangeNotifier {
  final OnboardingRepository repository;
  OnboardingProvider(this.repository) {
    _loadData();
  }

  List<Map<String, String>> onboardingData = [];
  void _loadData() {
    onboardingData = repository.onBoarding_Data;
    notifyListeners();
  }

  int courentPage = 0;
  void updateCourentPage(int index) {
    courentPage = index;
    notifyListeners();
  }
}
