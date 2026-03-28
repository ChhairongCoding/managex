import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:stockmanagement/src/core/routes/init_route.dart';
import 'package:stockmanagement/src/core/routes/routers.dart';
import 'package:stockmanagement/src/core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
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
      routes: initRoute,
    );
  }
}
