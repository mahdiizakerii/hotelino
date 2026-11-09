import 'package:flutter/cupertino.dart';
import 'package:hotelino/features/onboarding/presentation/onboarding_page.dart';
import 'package:hotelino/routes/main_bottom_nav.dart';

class AppRoutes {
  static const String home = '/';
  static const String hotelDetails = '/hotel-detail';
  static const String bookingForm = '/bookin-form';
  static const String favorite = '/favorite';
  static const String profile = '/profile';
  static const String onboarding = '/onboarding';

  static final Map<String, WidgetBuilder> routes = {
    onboarding: (ctx) => const OnboardingPage(),
    home: (ctx) => const MainBottomNav(),
  };
}
