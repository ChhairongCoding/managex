import 'package:flutter/material.dart';

class ProductScanModal extends StatefulWidget {
  const ProductScanModal({super.key});

  @override
  State<ProductScanModal> createState() => _ProductScanModalState();
}

class _ProductScanModalState extends State<ProductScanModal> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Product(0)", style: theme.textTheme.titleLarge),
              CircleAvatar(
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          // Cancel Button
          Spacer(),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: theme.colorScheme.onTertiary,
              minimumSize: Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Sell Items",
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.surface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
