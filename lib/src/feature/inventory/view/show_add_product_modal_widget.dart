import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managex/src/feature/home/model/product_model.dart';
import 'package:managex/src/feature/inventory/bloc/index.dart';
import 'package:managex/src/feature/inventory/model/inventory_model.dart';
import 'package:managex/src/feature/scan/view/scan_page.dart';
import 'package:managex/src/widgets/text_field_custom_widget.dart';

class ShowAddProductModalWidget extends StatefulWidget {
  final int? productId;
  final ProductModel? product;
  final bool isUpdate;
  const ShowAddProductModalWidget({
    super.key,
    this.productId,
    this.product,
    this.isUpdate = false,
  });

  @override
  State<ShowAddProductModalWidget> createState() =>
      _ShowAddProductModalWidgetState();
}

class _ShowAddProductModalWidgetState extends State<ShowAddProductModalWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _productNameController;
  late final TextEditingController _productSKUController;
  late final TextEditingController _productPriceController;
  late final TextEditingController _productStockController;
  late final TextEditingController _productLowStockController;
  late final TextEditingController _productVariantController;
  late final TextEditingController _productTypeController;


  int _newStock = 0;
  int _currentStock = 0;

  bool isUpdating = true;
  @override
  void initState() {
    super.initState();
    _productNameController = TextEditingController(
      text: widget.product?.name ?? "",
    );
    _productSKUController = TextEditingController(
      text: widget.product?.sku ?? "",
    );
    _productPriceController = TextEditingController(
      text: widget.product?.price.toString() ?? "",
    );
    _productStockController = TextEditingController(
      text: widget.product?.qty.toString() ?? "",
    );
    _productLowStockController = TextEditingController(
      text: widget.product?.inStock.toString() ?? "",
    );
    _productVariantController = TextEditingController(
      text: widget.product?.category.toString() ?? "",
    );

    _productTypeController = TextEditingController(
  text: widget.product?.type ?? "",
);
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productSKUController.dispose();
    _productPriceController.dispose();
    _productStockController.dispose();
    _productLowStockController.dispose();
    _productVariantController.dispose();
    _productTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.black),
                  ),
                  const Text(
                    "Add Product",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ScanPage()),
                    ),
                    icon: Icon(
                      Icons.qr_code_scanner,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      right: 20,
                      top: 50,
                      child: Transform.rotate(
                        angle: 0.5,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.04),
                          ),
                        ),
                      ),
                    ),
                    // Actual Form Content (Filled to space)
                    Positioned.fill(
                      top: 50,
                      child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "New Entry".toUpperCase(),
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          Text(
                            "Product Details",
                            style: theme.textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Fill the primary ledger information to update the inventory flow.",
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: Column(
                              spacing: 20,
                              children: [
                                TextFieldCustomWidget(
                                  theme: theme,
                                  hintText: "Enter item name...",
                                  label: "Product Name",
                                  productNameController: _productNameController,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFieldCustomWidget(
                                        theme: theme,
                                        hintText: "0",
                                        label: "Initial Stock",
                                        productNameController:
                                            _productStockController,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: TextFieldCustomWidget(
                                        theme: theme,
                                        hintText: "0.00",
                                        label: "Unit Price (\$)",
                                        productNameController:
                                            _productPriceController,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: TextFieldCustomWidget(
                                        theme: theme,
                                        hintText: "5",
                                        label: "Low Stock Threshold",
                                        productNameController:
                                            _productLowStockController,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 14,
                                        ),
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.error
                                              .withValues(alpha: 0.2),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.warning,
                                              color: theme.colorScheme.error,
                                              size: 20,
                                            ),
                                            SizedBox(width: 2),
                                            Text(
                                              "Alert at 5",
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                    color:
                                                        theme.colorScheme.error,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Current Stock",
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "$_currentStock",
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      "New Level Restock: ",
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "$_newStock",
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 0,
                      right: 0,
                      child: isUpdating
                          ? ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(double.infinity, 50),
                              ),
                              onPressed: () {
                                context.read<InventoryBloc>().add(
                                  AddInventoryEvent(
                                    inventory: InventoryModel(
                                      id: 0,
                                      name: _productNameController.text,
                                      price: double.parse(
                                        _productPriceController.text,
                                      ),
                                      quantity: int.parse(
                                        _productStockController.text,
                                      ),
                                      isLowStock:
                                          int.parse(
                                            _productLowStockController.text,
                                          ) >
                                          0,
                                      productType: _productTypeController.text,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.check_box),
                              label: Text("Confirm Restock"),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(double.infinity, 50),
                              ),
                              onPressed: () {
                                context.read<InventoryBloc>().add(
                                  UpdateInventoryEvent(
                                    inventory: InventoryModel(
                                      id: widget.product!.id,
                                      name: _productNameController.text,
                                      price: double.parse(
                                        _productPriceController.text,
                                      ),
                                      quantity: int.parse(
                                        _productStockController.text,
                                      ),
                                      isLowStock:
                                          int.parse(
                                            _productLowStockController.text,
                                          ) >
                                          0,
                                      productType: _productTypeController.text,
                                    ),
                                    key: widget.product!.id,
                                  ),
                                );

                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 5,
                                children: [
                                  Icon(Icons.add_circle),
                                  Text(
                                    "Add Product",
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
