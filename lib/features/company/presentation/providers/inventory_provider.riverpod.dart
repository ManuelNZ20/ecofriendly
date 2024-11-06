import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import 'repository/inventory_repository.riverpod.dart';

final inventoryProvider =
    StateNotifierProvider.family<InventoryNotifier, InventoryState, int>(
        (ref, id) {
  final inventoryRepository = ref.watch(inventoryRepositoryProvider);
  return InventoryNotifier(
    id: id,
    inventoryRepository: inventoryRepository,
  );
});

class InventoryNotifier extends StateNotifier<InventoryState> {
  final InventoryRepository inventoryRepository;
  InventoryNotifier({
    required int id,
    required this.inventoryRepository,
  }) : super(InventoryState(id: id)) {
    loadInventory();
  }

  Inventory newEmptyInventory() {
    return Inventory(
      id: 0,
      name: '',
      description: '',
      idCompany: '',
      dateRegister: DateTime.now().toString(),
    );
  }

  Future<void> loadInventory() async {
    try {
      if (state.id == 0) {
        state = state.copyWith(
          isLoading: false,
          inventory: newEmptyInventory(),
        );
        return;
      }
      final inventory = await inventoryRepository.getInventoryById(state.id);
      state = state.copyWith(
        isLoading: false,
        inventory: inventory,
      );
    } catch (e) {
      throw (e.toString());
    }
  }
}

class InventoryState {
  final int id;
  final Inventory? inventory;
  final bool isLoading;
  final bool isSaving;

  InventoryState({
    required this.id,
    this.inventory,
    this.isLoading = true,
    this.isSaving = false,
  });

  InventoryState copyWith({
    int? id,
    Inventory? inventory,
    bool? isLoading,
    bool? isSaving,
  }) =>
      InventoryState(
        id: id ?? this.id,
        inventory: inventory ?? this.inventory,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
