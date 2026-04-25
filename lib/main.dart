import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:stockmanagement/src/core/routes/init_route.dart';
import 'package:stockmanagement/src/core/routes/routers.dart';
import 'package:stockmanagement/src/core/theme/app_theme.dart';

import 'package:stockmanagement/src/feature/inventory/inventory_repo.dart';
import 'package:stockmanagement/src/feature/inventory/bloc/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('inventory');

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<InventoryBloc>(
          create: (context) => InventoryBloc(InventoryRepo()),
        ),
      ],
      child: MaterialApp(
        title: "ManageX",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: Routers.splashPage,
        routes: initRoute,
      ),
    );
  }
}
