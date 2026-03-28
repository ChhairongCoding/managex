import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:stockmanagement/src/feature/home/model/product_model.dart';
import 'package:stockmanagement/src/feature/home/view/widgets/item_cart_widget.dart';
import 'package:stockmanagement/src/widgets/card_product_widget.dart';
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
    Future.delayed(const Duration(seconds: 5), () {
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
        title: "Sennheiser Headphones",
        description: "High-quality wireless headphones with noise cancelling.",
        qty: 2,
        inStock: 20,
        imageUrl:
            "https://images.squarespace-cdn.com/content/v1/62957e003c63212b17de5749/cb3406ee-bb0d-418c-9ba1-4f182180ef2a/Sennheiser-Product-Gel0018.jpg",
      ),
      ProductModel(
        title: "Mechanical Keyboard",
        description: "RGB Backlit mechanical keyboard with brown switches.",
        qty: 15,
        inStock: 30,
        imageUrl:
            "https://images.unsplash.com/photo-1511467687858-23d96c32e4ae?q=80&w=2070&auto=format&fit=crop",
      ),
      ProductModel(
        title: "Gaming Mouse",
        description: "Ultra-lightweight gaming mouse with 25k DPI sensor.",
        qty: 5,
        inStock: 50,
        imageUrl:
            "https://images.unsplash.com/photo-1527814732934-94a1fe58abc1?q=80&w=2080&auto=format&fit=crop",
      ),
      ProductModel(
        title: "4K Monitor 27\"",
        description: "IPS panel monitor with 144Hz refresh rate for gaming.",
        qty: 1,
        inStock: 5,
        imageUrl:
            "https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?q=80&w=2070&auto=format&fit=crop",
      ),
      ProductModel(
        title: "USB-C Hub",
        description: "7-in-1 USB-C hub with HDMI, PD, and USB 3.0 ports.",
        qty: 25,
        inStock: 40,
        imageUrl:
            "https://images.unsplash.com/photo-1625842268584-8f3bf4375081?q=80&w=2070&auto=format&fit=crop",
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
            itemCardWidget(
              context,
              "Total Items",
              "0",
              HugeIcons.strokeRoundedPackage01,
              Colors.black,
              Theme.of(context).colorScheme.primary,
            ),
            itemCardWidget(
              context,
              "Low Stock Items",
              "08",
              Icons.error_outline,
              Theme.of(context).colorScheme.error,
              Theme.of(context).colorScheme.error,
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Inventory Items",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "Showing all available stock items.",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
                Text(
                  "View all".toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),

            // Display 5 Products
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length.clamp(0, 5),
              itemBuilder: (context, index) {
                final product = products[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: cardProductWidget(
                    context: context,
                    theme: theme,
                    title: product.title,
                    description: product.description,
                    qty: product.qty,
                    inStock: product.inStock,
                    imageUrl: product.imageUrl,
                  ),
                );
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Inventory Items",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "Showing all available stock items.",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length.clamp(0, 5),
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          product.imageUrl,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                height: 100,
                                width: 100,
                                color: theme.colorScheme.surfaceVariant,
                                child: Icon(
                                  Icons.broken_image_outlined,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 100,
                              width: 100,
                              color: theme.colorScheme.surfaceVariant,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                spacing: 8,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    maxLines: 2,

                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(height: 1.1),
                                  ),
                                  Text(
                                    product.description,
                                    maxLines: 1,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: 5 >= product.inStock
                                          ? theme.colorScheme.error
                                          : theme.colorScheme.tertiary,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      5 >= product.inStock
                                          ? "Low Stock"
                                          : "Healthy Stock",
                                      maxLines: 1,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: product.qty < product.inStock
                                                ? theme.colorScheme.onError
                                                : theme.colorScheme.onTertiary,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${product.inStock}",
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: 5 >= product.inStock
                                        ? theme.colorScheme.error
                                        : theme.colorScheme.tertiary,
                                  ),
                                ),
                                Text(
                                  "In Stock",
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: 5 >= product.inStock
                                        ? theme.colorScheme.error
                                        : theme.colorScheme.tertiary,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.remove,
                                        color: theme.colorScheme.error,
                                      ),
                                    ),

                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.add,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Container _inventoryValueCard(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total inventory value".toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "\$0.00",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 38,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            spacing: 15,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.tertiary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.arrow_upward_rounded,
                      color: Theme.of(context).colorScheme.tertiary,
                      size: 20,
                    ),
                    Text(
                      "0.0%",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "vs last month",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
