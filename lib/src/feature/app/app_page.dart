import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:stockmanagement/src/feature/app/app_bar.dart';
import 'package:stockmanagement/src/feature/history/view/history_page.dart';
import 'package:stockmanagement/src/feature/home/view/home_page.dart';
import 'package:stockmanagement/src/feature/inventory/view/inventory_page.dart';
import 'package:stockmanagement/src/feature/scan/view/scan_page.dart';
import 'package:stockmanagement/src/feature/setting/view/setting_page.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _selectedIndex = 0;
  bool _isScrolled = false;

  final List<Widget> _pages = [
    const HomePage(),
    const InventoryPage(),
    const ScanPage(),
    const HistoryPage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 || _selectedIndex == 1
          ? appBar(context, isScrolled: _isScrolled)
          : null,
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo.metrics.axis == Axis.vertical) {
            bool isScrolled = scrollInfo.metrics.pixels > 0;
            if (isScrolled != _isScrolled) {
              setState(() {
                _isScrolled = isScrolled;
              });
            }
          }
          return false;
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: _pages[_selectedIndex],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Left Side Items
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _navItem(
                    icon: HugeIcons.strokeRoundedHome03,
                    label: "Home",
                    index: 0,
                  ),
                  _navItem(
                    icon: HugeIcons.strokeRoundedPackage01,
                    label: "INVENTORY",
                    index: 1,
                  ),
                ],
              ),

              // Space for FAB
              const SizedBox(width: 40),

              // Right Side Items
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _navItem(
                    icon: HugeIcons.strokeRoundedTransactionHistory,
                    label: "HISTORY",
                    index: 2,
                  ),
                  _navItem(
                    icon: HugeIcons.strokeRoundedSettings01,
                    label: "Settings",
                    index: 3,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Icons.qr_code_scanner_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _navItem({
    required dynamic icon,
    required String label,
    required int index,
    bool isMaterialIcon = false,
  }) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? Theme.of(context).primaryColor : Colors.black;

    return MaterialButton(
      minWidth: 40,
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isMaterialIcon
              ? Icon(icon as IconData, color: color, size: 24)
              : HugeIcon(icon: icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
