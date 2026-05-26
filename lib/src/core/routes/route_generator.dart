import 'package:flutter/material.dart';
import 'package:managex/src/feature/app/app_page.dart';
import 'package:managex/src/feature/auth/view/login_page.dart';
import 'package:managex/src/feature/auth/view/register_page.dart';
import 'package:managex/src/feature/auth/view/verify_otp_page.dart';
import 'package:managex/src/feature/history/view/history_page.dart';
import 'package:managex/src/feature/home/view/home_page.dart';
import 'package:managex/src/feature/inventory/view/inventory_page.dart';
import 'package:managex/src/feature/scan/view/scan_page.dart';
import 'package:managex/src/feature/setting/view/setting_page.dart';
import 'package:managex/src/feature/splash/splash_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/appPage':
        return MaterialPageRoute(builder: (_) => const AppPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/inventory':
        return MaterialPageRoute(builder: (_) => const InventoryPage());
      case '/scan':
        return MaterialPageRoute(builder: (_) => const ScanPage());
      case '/history':
        return MaterialPageRoute(builder: (_) => const HistoryPage());
      case '/setting':
        return MaterialPageRoute(builder: (_) => const SettingPage());
      case '/verifyOtp':
        return MaterialPageRoute(builder: (_) => const VerifyOtpPage());
      default:
        return MaterialPageRoute(builder: (_) => const SplashPage());
    }
  }
}
