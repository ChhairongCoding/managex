import 'package:hive/hive.dart';
import 'package:stockmanagement/src/feature/inventory/model/inventory_model.dart';

class InventoryRepo {
  final Box _box = Hive.box("inventory");

  Future<void> addInventory(InventoryModel inventory) async {
    await _box.add(inventory.toMap());
  }

  Future<void> updateInventory(int key, InventoryModel inventory) async {
    await _box.put(key, inventory.toMap());
  }

  Future<void> deleteInventory(int key) async {
    await _box.delete(key);
  }

  Future<InventoryModel> getInventory(int key) async {
    final data = _box.get(key);
    return InventoryModel.fromMap(Map<String, dynamic>.from(data));
  }

  Future<List<InventoryModel>> getAllInventory() async {
    return _box.values
        .map((e) => InventoryModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }
}
