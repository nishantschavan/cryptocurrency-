import 'package:flutter/material.dart';

import 'homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final darkTheme =Theme.of(context).primaryColorDark;
    // final isPlatformDark =WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    // final initTheme = isPlatformDark ? darkTheme : lightTheme;
      return MaterialApp(
        title: "Cryptocurrency app",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: HomePage(),
    );
  }
}
