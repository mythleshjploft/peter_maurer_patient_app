import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:peter_maurer_patients_app/app/modules/splash/splash_view.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_localization.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_main_builder.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: BaseLocalization(),
      locale: const Locale('de', 'DE'),
      fallbackLocale: const Locale('de', 'DE'),
      title: 'My App',
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: BaseMainBuilder(
              context: context,
              child: child,
            ));
      },
      theme: ThemeData(
          fontFamily: 'Parkinsans',
          primarySwatch:
              MaterialColor(0xFF2EB3D6, getSwatch(const Color(0xFF2EB3D6))),
          useMaterial3: false),
      home: const SplashView(),
    );
  }

  Map<int, Color> getSwatch(Color color) {
    final hslColor = HSLColor.fromColor(color);
    final lightness = hslColor.lightness;
    const lowDivisor = 6;
    const highDivisor = 5;
    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;

    return {
      50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
      100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
      200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
      300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
      400: (hslColor.withLightness(lightness + lowStep)).toColor(),
      500: (hslColor.withLightness(lightness)).toColor(),
      600: (hslColor.withLightness(lightness - highStep)).toColor(),
      700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
      800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
      900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
    };
  }
}
