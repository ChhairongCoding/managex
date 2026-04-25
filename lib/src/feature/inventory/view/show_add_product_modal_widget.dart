import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockmanagement/src/feature/inventory/bloc/index.dart';
import 'package:stockmanagement/src/feature/inventory/model/inventory_model.dart';
import 'package:stockmanagement/src/widgets/text_field_custom_widget.dart';

class ShowAddProductModalWidget extends StatefulWidget {
  const ShowAddProductModalWidget({super.key});

  @override
  State<ShowAddProductModalWidget> createState() =>
      _ShowAddProductModalWidgetState();
}

class _ShowAddProductModalWidgetState extends State<ShowAddProductModalWidget> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productStockController = TextEditingController();
  final _productLowStockController = TextEditingController();
  final _productVariantController = TextEditingController();
  final _productTypeController = TextEditingController();

  @override
  void dispose() {
    _productNameController.dispose();
    _productDescriptionController.dispose();
    _productPriceController.dispose();
    _productStockController.dispose();
    _productLowStockController.dispose();
    _productVariantController.dispose();
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
                    icon: const Icon(Icons.close),
                  ),
                  const Text(
                    "Add Product",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
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
                            ).colorScheme.primary.withOpacity(0.04),
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
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 0,
                      right: 0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(double.infinity, 50),
                        ),
                        onPressed: () {
                          context.read<InventoryBloc>().add(
                            AddInventoryEvent(
                              inventory: InventoryModel(
                                id: 0,
                                name: _productNameController.text,
                                description: _productDescriptionController.text,
                                price: double.parse(
                                  _productPriceController.text,
                                ),
                                quantity: int.parse(
                                  _productStockController.text,
                                ),
                                isLowStock:
                                    int.parse(_productLowStockController.text) >
                                    0,
                                productType: _productTypeController.text,
                              ),
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
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                              ),
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
