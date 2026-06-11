import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:managex/src/feature/inventory/view/show_add_product_modal_widget.dart';
import 'package:flutter/services.dart';

PreferredSizeWidget appBar(BuildContext context, {bool isScrolled = false}) {
  final primaryColor = Theme.of(context).colorScheme.primary;

  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          isScrolled ? Brightness.light : Brightness.dark, // icons color
      statusBarBrightness:
          isScrolled ? Brightness.dark : Brightness.light,  // iOS
    ),
    automaticallyImplyLeading: false,
    elevation: isScrolled ? 4.0 : 0.0,
    titleSpacing: 20,
    flexibleSpace: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: isScrolled
          ? primaryColor
          : Theme.of(context).scaffoldBackgroundColor,
    ),
    title: AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 300),
      style: TextStyle(
        color: isScrolled ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      child: isScrolled ? Image.asset("assets/images/logo_text_white.png", height: 32) : Image.asset("assets/images/logo_text_black.png", height: 30),
    ),
    actions: [
      TweenAnimationBuilder<Color?>(
        tween: ColorTween(
          begin: isScrolled ? Colors.white : primaryColor,
          end: isScrolled ? Colors.white : primaryColor,
        ),
        duration: const Duration(milliseconds: 300),
        builder: (context, color, child) {
          return IconButton(
            onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              useSafeArea: true,
              context: context,
              builder: (context) => const ShowAddProductModalWidget(),
            ),
            icon: CircleAvatar(
              backgroundColor: Colors.grey.withValues(alpha: 0.2),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedAdd01,
                color: color,
              ),
            ),
          );
        },
      ),
      const SizedBox(width: 10),
    ],
  );
}
