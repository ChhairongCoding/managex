import 'package:flutter/material.dart';
import 'package:stockmanagement/src/core/routes/routers.dart';
import 'package:stockmanagement/src/core/theme/app_theme.dart';
import 'package:stockmanagement/src/feature/home/view/home_page.dart';
import 'package:stockmanagement/src/feature/splash/splash_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Stock Management",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: Routers.splashPage,
      routes: {
        Routers.splashPage: (context) => const SplashPage(),
        Routers.home: (context) => const HomePage(),
      },
    );
  }
}
