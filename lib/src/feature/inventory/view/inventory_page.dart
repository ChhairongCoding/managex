import 'package:flutter/material.dart';
import 'package:stockmanagement/src/feature/inventory/view/widgets/item_card_inventory_widget.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _inventoryValueCard(context),

            Row(
              children: [
                Expanded(child: searchBar()),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: theme.colorScheme.primary),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.filter_list,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 6),

            ItemCardInventoryWidget(theme: theme),
          ],
        ),
      ),
    );
  }

  SearchBar searchBar() {
    return SearchBar(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
      elevation: WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(Color(0xffE7E7F2)),
      hintText: "Search",
      hintStyle: WidgetStatePropertyAll(
        TextStyle(color: Colors.blueGrey.shade400),
      ),
      leading: Icon(Icons.search, color: Colors.blueGrey.shade400),
    );
  }

  Container _inventoryValueCard(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total valuation".toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.surface.withValues(alpha: 0.6),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$4,289,550",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: theme.colorScheme.surface,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.trending_up_rounded,
                      color: theme.colorScheme.tertiary,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "12.5%",
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
