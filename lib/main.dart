import 'package:flutter/material.dart';
import 'package:hotelino/bootstrap.dart';
import 'package:hotelino/core/theme/theme.dart';
import 'package:hotelino/core/theme/theme_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hotelino/features/onboarding/data/repository/onboarding_repository.dart';
import 'package:hotelino/features/onboarding/presentation/onboarding_provider.dart';
import 'package:hotelino/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  //Bootstrapping
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await lazyBootStrap();
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
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
          initialRoute: AppRoutes.onboarding,
          debugShowCheckedModeBanner: false,
          theme: value.brightness == Brightness.light
              ? AppTheme.lightTheme
              : AppTheme.darkTheme,
        );
      },
    );
  }
}
