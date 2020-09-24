import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:crytocurrency/splash_screen.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final darkTheme = ThemeData.dark();
    final lightTheme = ThemeData.light();
    final isPlatformDark =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    final initTheme = isPlatformDark ? darkTheme : lightTheme;

    return ThemeProvider(
        initTheme: initTheme,
        child: Builder(builder: (context) {
          return MaterialApp(
            title: "Cryptocurrency app",
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.of(context),
            home: SplashScreen(),
          );
        }));
  }
}
