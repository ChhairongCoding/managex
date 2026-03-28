import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Container itemCardWidget(
  BuildContext context,
  String title,
  String value,
  dynamic icon,
  Color color,
  Color iconColor,
) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: color),
            ),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontSize: 38, color: color),
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: icon is List<List<dynamic>>
              ? HugeIcon(icon: icon, color: iconColor, size: 24)
              : Icon(icon, color: iconColor, size: 24),
        ),
      ],
    ),
  );
}
