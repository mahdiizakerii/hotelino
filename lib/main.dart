import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hotelino/bootstrap.dart';
import 'package:hotelino/core/theme/theme.dart';
import 'package:hotelino/core/theme/theme_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hotelino/features/home/data/repository/hotel_repository.dart';
import 'package:hotelino/features/favorite/data/provider/favorite_provider.dart';
import 'package:hotelino/features/home/presentation/provider/home_provider.dart';
import 'package:hotelino/features/onboarding/data/repository/onboarding_repository.dart';
import 'package:hotelino/features/onboarding/presentation/onboarding_provider.dart';
import 'package:hotelino/features/profile/provider/profile_provider.dart';
import 'package:hotelino/features/profile/repository/profile_repository.dart';
import 'package:hotelino/routes/app_routes.dart';
import 'package:hotelino/shared/services/json_data_service.dart';
import 'package:hotelino/shared/services/onboarding_storage_service.dart';
import 'package:provider/provider.dart';

void main() async {
  usePathUrlStrategy();
  //Bootstrapping
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await lazyBootStrap();

  final hotelRepository = HotelRepository(jsonDataService: JsonDataService());

  final onboardingCompleted = await OnboardingStorageService.isCompleted();

  FlutterNativeSplash.remove();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeModeProvider(
            WidgetsBinding.instance.platformDispatcher.platformBrightness,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => OnboardingProvider(OnboardingRepository()),
        ),
        ChangeNotifierProvider(create: (_) => HomeProvider(hotelRepository)),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(ProfileRepository(), hotelRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(hotelRepository)..fetchHotels(),
        ),
      ],
      child: MyApp(onboardingCompleted: onboardingCompleted),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool onboardingCompleted;

  const MyApp({super.key, required this.onboardingCompleted});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    Provider.of<ThemeModeProvider>(
      context,
      listen: false,
    ).updateTheme(brightness);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Hotelino',
          routes: AppRoutes.routes,
          initialRoute: widget.onboardingCompleted
              ? AppRoutes.home
              : AppRoutes.onboarding,
          debugShowCheckedModeBanner: false,
          theme: value.brightness == Brightness.light
              ? AppTheme.lightTheme
              : AppTheme.darkTheme,
        );
      },
    );
  }
}
