import 'package:flutter/material.dart';
import 'package:stockmanagement/src/feature/home/model/product_model.dart';

Container cardProductRecentActivityWidget(
  ProductModel product,
  ThemeData theme,
) {
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
            errorBuilder: (context, error, stackTrace) => Container(
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
                  child: CircularProgressIndicator(strokeWidth: 2),
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

                      style: theme.textTheme.titleMedium?.copyWith(height: 1.1),
                    ),
                    Text(
                      product.sku,
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
                        5 >= product.inStock ? "Low Stock" : "Healthy Stock",
                        maxLines: 1,
                        style: theme.textTheme.bodyMedium?.copyWith(
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "+${product.inStock}",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: 5 >= product.inStock
                          ? theme.colorScheme.error
                          : theme.colorScheme.tertiary,
                    ),
                  ),
                  Text(
                    "Units",
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: 5 >= product.inStock
                          ? theme.colorScheme.error
                          : theme.colorScheme.tertiary,
                    ),
                  ),
                  Text("In Stock:", style: theme.textTheme.labelSmall),
                  Text(
                    "${product.inStock}",
                    textAlign: TextAlign.end,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
