import 'package:stockmanagement/src/feature/inventory/model/inventory_model.dart';

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
