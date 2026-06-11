import 'dart:io';

import 'package:hive/hive.dart';
import 'package:managex/src/feature/inventory/model/inventory_model.dart';

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

  Future<void> updateInventoryImage(int key, File image) async {
    await _box.put(key, image.path);
  }

  Future<void> sellProduct(int key, int quantity) async {
    final inventory = await getInventory(key);
    final newQuantity = inventory.quantity - quantity;
    await updateInventory(key, inventory.copyWith(quantity: newQuantity));
  }

  Future<void> manualUpdateProduct({
    required int key,
    required int quantity,
    required double price,
    required String type,
    required String description,
    required int lowStockThreshold,
    required File imagePath,
  }) async {
    final inventory = await getInventory(key);
    final newQuantity = inventory.quantity + quantity;
    await updateInventory(key, inventory.copyWith(quantity: newQuantity));
  }
}
