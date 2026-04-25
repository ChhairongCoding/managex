import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:stockmanagement/src/feature/inventory/view/show_add_product_modal_widget.dart';

PreferredSizeWidget appBar(BuildContext context, {bool isScrolled = false}) {
  final primaryColor = Theme.of(context).colorScheme.primary;

  return AppBar(
    backgroundColor: Colors.transparent,
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
      child: const Text("Stockify"),
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
              context: context,
              builder: (context) => const ShowAddProductModalWidget(),
            ),
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedAddCircle,
              color: color ?? primaryColor,
            ),
          );
        },
      ),
      const SizedBox(width: 10),
    ],
  );
}
