import 'package:equatable/equatable.dart';
import 'package:stockmanagement/src/feature/inventory/model/inventory_model.dart';

abstract class InventoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventoryLoaded extends InventoryState {
  final List<InventoryModel> inventory;

  InventoryLoaded({required this.inventory});

  InventoryLoaded copyWith({List<InventoryModel>? inventory}) {
    return InventoryLoaded(inventory: inventory ?? this.inventory);
  }

  @override
  List<Object?> get props => [inventory];
}

class InventoryError extends InventoryState {
  final String message;

  InventoryError({required this.message});

  @override
  List<Object?> get props => [message];
}
