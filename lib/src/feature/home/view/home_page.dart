import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:stockmanagement/src/feature/home/model/product_model.dart';
import 'package:stockmanagement/src/feature/home/view/widgets/item_cart_widget.dart';
import 'package:stockmanagement/src/widgets/skeleton_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? _buildSkeleton(context) : _buildBody(context),
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          spacing: 16,
          children: [
            const InventoryValueSkeleton(),
            Row(
              spacing: 16,
              children: const [
                Expanded(child: SkeletonWidget(height: 100)),
                Expanded(child: SkeletonWidget(height: 100)),
              ],
            ),
            const SizedBox(height: 16),
            const CardSkeleton(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [SkeletonWidget(height: 24, width: 140)],
            ),
            const SizedBox(height: 12),
            const ListItemSkeleton(),
            const ListItemSkeleton(),
            const ListItemSkeleton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);

    // Dummy Products
    final List<ProductModel> products = [
      ProductModel(
        title: "Chrono-X Titanium",
        sku: "CTX-2024-SILVER",
        qty: 2,
        inStock: 42,
        imageUrl:
            "https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=2000&auto=format&fit=crop",
      ),
      ProductModel(
        title: "Sonic-Bose Pro",
        sku: "SB-700-BLACK",
        qty: 5,
        inStock: 08,
        imageUrl:
            "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=2000&auto=format&fit=crop",
      ),
      ProductModel(
        title: "MacBook Pro M3 Max",
        sku: "MBP-14-M3-64GB",
        qty: 12,
        inStock: 42,
        imageUrl:
            "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?q=80&w=2000&auto=format&fit=crop",
      ),
      ProductModel(
        title: "OLED Bravia 65\"",
        sku: "SONY-A95L-65",
        qty: 8,
        inStock: 08,
        imageUrl:
            "https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?q=80&w=2000&auto=format&fit=crop",
      ),
      ProductModel(
        title: "ErgoChair Pro",
        sku: "EC-2024-GREY",
        qty: 15,
        inStock: 25,
        imageUrl:
            "https://images.unsplash.com/photo-1505843490538-5133c6c7d0e1?q=80&w=2000&auto=format&fit=crop",
      ),
    ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          spacing: 16,
          children: [
            _inventoryValueCard(context),
            Row(
              spacing: 16,
              children: [
                itemCardWidget(
                  context,
                  "Total Items",
                  "12,482",
                  HugeIcons.strokeRoundedPackage01,
                  Colors.black,
                  Theme.of(context).colorScheme.primary,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                ),
                itemCardWidget(
                  context,
                  "Low Stock",
                  "08 SKUs",
                  Icons.error_outline,
                  Colors.black,
                  Theme.of(context).colorScheme.error,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.errorContainer.withValues(alpha: 0.04),
                ),
              ],
            ),

            const SizedBox(height: 8),
            _sectionHeader(context, "Critical Alerts", onViewAll: () {}),
            _criticalAlertsSection(context, products, theme),

            const SizedBox(height: 8),
            _sectionHeader(context, "Recent Activity"),
            _recentActivitySection(context, products, theme),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(
    BuildContext context,
    String title, {
    VoidCallback? onViewAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (onViewAll != null)
          TextButton(
            onPressed: onViewAll,
            child: Text(
              "View All",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _criticalAlertsSection(
    BuildContext context,
    List<ProductModel> products,
    ThemeData theme,
  ) {
    // Filter for low stock for demo
    final lowStockProducts = products.where((p) => p.qty <= 5).toList();

    return Column(
      spacing: 12,
      children: lowStockProducts.map((product) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.1),
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  product.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: theme.textTheme.bodyMedium,
                        children: [
                          const TextSpan(text: "Stock: "),
                          TextSpan(
                            text:
                                "${product.qty.toString().padLeft(2, '0')} left",
                            style: TextStyle(
                              color: theme.colorScheme.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            size: 16,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "RESTOCK NOW",
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _recentActivitySection(
    BuildContext context,
    List<ProductModel> products,
    ThemeData theme,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        separatorBuilder: (context, index) => Divider(
          color: theme.colorScheme.outline.withValues(alpha: 0.05),
          height: 32,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          // Simple logic for demo differentiation
          final isSale = index % 2 != 0;
          return Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.imageUrl,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      isSale ? "Sale • 15m ago" : "Update by Admin • 2m ago",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    isSale ? "-01" : "+15",
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSale
                          ? theme.colorScheme.error
                          : theme.colorScheme.tertiary,
                    ),
                  ),
                  Text(
                    "Qty: ${product.inStock}",
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

Container _inventoryValueCard(BuildContext context) {
  final theme = Theme.of(context);
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
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
          "Total inventory value".toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "\$4,289,550",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiaryContainer.withValues(
                  alpha: 0.3,
                ),
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
                      color: theme.colorScheme.tertiary,
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
