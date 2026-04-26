import 'package:flutter/material.dart';

// --- Data Models ---

enum ActivityType { sold, restocked, manualAdjustment }

class ActivityItem {
  final String productName;
  final String sku;
  final ActivityType type;
  final int qtyChange; // negative for sold/deficit, positive for restocked
  final int remaining;
  final IconData icon;

  const ActivityItem({
    required this.productName,
    required this.sku,
    required this.type,
    required this.qtyChange,
    required this.remaining,
    this.icon = Icons.inventory_2_outlined,
  });

  String get typeLabel {
    switch (type) {
      case ActivityType.sold:
        return "SOLD";
      case ActivityType.restocked:
        return "RESTOCKED";
      case ActivityType.manualAdjustment:
        return "MANUAL ADJUSTMENT";
    }
  }

  Color get accentColor {
    switch (type) {
      case ActivityType.sold:
        return const Color(0xFFD32F2F);
      case ActivityType.restocked:
        return const Color(0xFF388E3C);
      case ActivityType.manualAdjustment:
        return const Color(0xFF7B1FA2);
    }
  }

  Color get badgeBgColor {
    switch (type) {
      case ActivityType.sold:
        return const Color(0xFFFFE5E5);
      case ActivityType.restocked:
        return const Color(0xFFE8F5E9);
      case ActivityType.manualAdjustment:
        return const Color(0xFFF3E5F5);
    }
  }

  String get qtyLabel {
    if (qtyChange < 0 && type == ActivityType.manualAdjustment) {
      return "DEFICIT / DAMAGES";
    }
    return qtyChange < 0 ? "UNITS OUT" : "UNITS IN";
  }
}

// --- Page ---

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedFilter = 0;

  // Dummy data matching mockup
  final List<ActivityItem> _todayActivities = const [
    ActivityItem(
      productName: "Onyx Chronograph XL",
      sku: "SKU-8821-A",
      type: ActivityType.sold,
      qtyChange: -2,
      remaining: 14,
      icon: Icons.watch_outlined,
    ),
    ActivityItem(
      productName: "Arctic Wool Blanket",
      sku: "SKU-3304-W",
      type: ActivityType.restocked,
      qtyChange: 50,
      remaining: 82,
      icon: Icons.bed_outlined,
    ),
  ];

  final List<ActivityItem> _yesterdayActivities = const [
    ActivityItem(
      productName: "Industrial Copper Vase",
      sku: "SKU-1199-V",
      type: ActivityType.manualAdjustment,
      qtyChange: -1,
      remaining: 3,
      icon: Icons.vape_free_outlined,
    ),
    ActivityItem(
      productName: "Velvet Lounge Chair",
      sku: "SKU-8821-C",
      type: ActivityType.restocked,
      qtyChange: 12,
      remaining: 24,
      icon: Icons.chair_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter bar
            _buildFilterBar(theme),
            const SizedBox(height: 24),

            // Today section
            _buildDateHeader("Today", theme),
            const SizedBox(height: 12),
            ..._todayActivities.map((a) => _buildActivityCard(a, theme)),

            const SizedBox(height: 24),

            // Yesterday section
            _buildDateHeader("Yesterday", theme),
            const SizedBox(height: 12),
            ..._yesterdayActivities.map((a) => _buildActivityCard(a, theme)),

            const SizedBox(height: 100), // Bottom padding for FAB
          ],
        ),
      ),
    );
  }

  // --- Filter Chips ---
  Widget _buildFilterBar(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "FILTER BY",
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _filterChip("All Activities", 0, theme),
                  const SizedBox(width: 8),
                  _filterChip("Manual Only", 1, theme),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.15),
            ),
          ),
          child: Icon(
            Icons.calendar_today_outlined,
            size: 20,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _filterChip(String label, int index, ThemeData theme) {
    final isSelected = _selectedFilter == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline.withValues(alpha: 0.15),
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: isSelected ? Colors.white : theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // --- Date Section Header ---
  Widget _buildDateHeader(String label, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // --- Activity Card ---
  Widget _buildActivityCard(ActivityItem item, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        children: [
          // Top row: icon + product info + badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Colored icon container
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: item.badgeBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, color: item.accentColor, size: 22),
              ),
              const SizedBox(width: 12),
              // Product name + SKU
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.productName,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          item.sku,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.grey[500],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text("•", style: TextStyle(color: Colors.grey[400])),
                        const SizedBox(width: 8),
                        // Status badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: item.badgeBgColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item.typeLabel,
                            style: TextStyle(
                              color: item.accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Bottom row: qty change + remaining
          Row(
            children: [
              // Qty change
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item.qtyChange > 0 ? '+' : ''}${item.qtyChange}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: item.accentColor,
                    ),
                  ),
                  Text(
                    item.qtyLabel,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                color: Colors.grey,
                width: 0.4,
                height: 40,
              ),

              // Remaining
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${item.remaining}",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    "REMAINING",
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
