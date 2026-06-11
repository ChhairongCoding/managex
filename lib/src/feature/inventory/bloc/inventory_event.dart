import 'dart:io';

import 'package:managex/src/feature/inventory/model/inventory_model.dart';

abstract class InventoryEvent {}

class InventoryLoadEvent extends InventoryEvent {}

class AddInventoryEvent extends InventoryEvent {
  final InventoryModel inventory;

  AddInventoryEvent({required this.inventory});
}

class UpdateInventoryEvent extends InventoryEvent {
  final InventoryModel inventory;
  final int key;

  UpdateInventoryEvent({required this.inventory, required this.key});
}

class DeleteInventoryEvent extends InventoryEvent {
  final int key;

  DeleteInventoryEvent({required this.key});
}

class SearchInventoryEvent extends InventoryEvent {
  final String query;

  SearchInventoryEvent({required this.query});
}

class FilterInventoryEvent extends InventoryEvent {
  final String name;

  FilterInventoryEvent({required this.name});
}

class UpdateProductImageEvent extends InventoryEvent {
  final File image;
  final int key;

  UpdateProductImageEvent({required this.image, required this.key});
}

class ManualUpdateProductEvent extends InventoryEvent {
  final int key;
  final int quantity;
  final String type;
  final String description;
  final int lowStockThreshold;
  final double price;
  final File imagePath;

  ManualUpdateProductEvent({
    required this.key,
    required this.quantity,
    required this.type,
    required this.description,
    required this.lowStockThreshold,
    required this.price,
    required this.imagePath,
  });
}

class SellInventoryEvent extends InventoryEvent {
  final int key;
  final int quantity;

  SellInventoryEvent({required this.key, required this.quantity});
}
