import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

PreferredSizeWidget appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    titleSpacing: 20,
    title: const Text(
      "Stock Management",
      style: TextStyle(color: Colors.black),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: HugeIcon(
          icon: HugeIcons.strokeRoundedAddCircle,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      SizedBox(width: 10),
    ],
  );
}
