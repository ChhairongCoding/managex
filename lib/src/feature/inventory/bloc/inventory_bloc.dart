import 'package:bloc/bloc.dart';
import 'package:stockmanagement/src/feature/inventory/inventory_repo.dart';
import 'package:stockmanagement/src/feature/inventory/model/inventory_model.dart';

import 'index.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final InventoryRepo _inventoryRepo;

  //constructor
  InventoryBloc(this._inventoryRepo) : super(InventoryInitial()) {
    on<InventoryLoadEvent>((event, emit) async {
      emit(InventoryLoading());
      try {
        final inventory = await _inventoryRepo.getAllInventory();
        emit(InventoryLoaded(inventory: inventory));
      } catch (e) {
        emit(InventoryError(message: e.toString()));
      }
    });

    //add inventory
    on<AddInventoryEvent>((event, emit) async {
      try {
        if (state is InventoryLoaded) {
          final current = (state as InventoryLoaded).inventory;

          await _inventoryRepo.addInventory(event.inventory);

          final updated = List<InventoryModel>.from(current)
            ..add(event.inventory);

          emit(InventoryLoaded(inventory: updated));
        }
      } catch (e) {
        emit(InventoryError(message: e.toString()));
      }
    });

    //update inventory
    on<UpdateInventoryEvent>((event, emit) async {
      try {
        if (state is InventoryLoaded) {
          await _inventoryRepo.updateInventory(event.key, event.inventory);

          final current = (state as InventoryLoaded).inventory;
          final updated = current
              .map((e) => e.id == event.inventory.id ? event.inventory : e)
              .toList();

          emit(InventoryLoaded(inventory: updated));
        }
      } catch (e) {
        emit(InventoryError(message: e.toString()));
      }
    });

    //delete inventory
    on<DeleteInventoryEvent>((event, emit) async {
      try {
        final current = (state as InventoryLoaded).inventory;
        await _inventoryRepo.deleteInventory(event.key);
        final updated = current.where((e) => e.id != event.key).toList();
        emit(InventoryLoaded(inventory: updated));
      } catch (e) {
        emit(InventoryError(message: e.toString()));
      }
    });
  }
}
