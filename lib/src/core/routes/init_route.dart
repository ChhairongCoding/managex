import 'package:flutter/material.dart';
import 'package:stockmanagement/src/feature/auth/login_register/view/login_page.dart';
import 'package:stockmanagement/src/feature/auth/login_register/view/register_page.dart';
import 'package:stockmanagement/src/feature/auth/login_register/view/verify_otp_page.dart';
import 'package:stockmanagement/src/feature/history/view/history_page.dart';
import 'package:stockmanagement/src/feature/home/view/home_page.dart';
import 'package:stockmanagement/src/feature/inventory/view/inventory_page.dart';
import 'package:stockmanagement/src/feature/scan/view/scan_page.dart';
import 'package:stockmanagement/src/feature/setting/view/setting_page.dart';
import '../../feature/app/app_page.dart';
import '../../feature/splash/splash_page.dart';
import 'routers.dart';

Map<String, WidgetBuilder> get initRoute => {
  Routers.splashPage: (context) => const SplashPage(),
  Routers.login: (context) => const LoginPage(),
  Routers.register: (context) => const RegisterPage(),
  Routers.appPage: (context) => const AppPage(),
  Routers.home: (context) => const HomePage(),
  Routers.inventory: (context) => const InventoryPage(),
  Routers.scan: (context) => const ScanPage(),
  Routers.history: (context) => const HistoryPage(),
  Routers.setting: (context) => const SettingPage(),
  Routers.verifyOtp: (context) => const VerifyOtpPage(),
};
