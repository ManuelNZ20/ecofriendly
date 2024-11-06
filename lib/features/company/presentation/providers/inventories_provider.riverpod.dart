import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'repository/inventory_repository.riverpod.dart';

final inventoriesProvider =
    StateNotifierProvider<InventoryNotifier, InventoryState>((ref) {
  final inventoryRepository = ref.watch(inventoryRepositoryProvider);
  return InventoryNotifier(
    inventoryRepository: inventoryRepository,
  );
});

class InventoryNotifier extends StateNotifier<InventoryState> {
  final InventoryRepository inventoryRepository;
  InventoryNotifier({
    required this.inventoryRepository,
  }) : super(InventoryState()) {
    loadInventories();
  }

  Stream<List<Inventory>> getInventoriesStream() {
    final inventories = inventoryRepository.getInventoriesStream();
    return inventories;
  }

  Future<void> loadInventories() async {
    try {
      state = state.copyWith(inventories: []);
      if (state.isLoading) return;
      state = state.copyWith(isLoading: true);
      final inventory = await inventoryRepository.getInventories();
      if (inventory.isEmpty) {
        state = state.copyWith(isLoading: false);
        return;
      }
      state = state.copyWith(
        isLoading: false,
        inventories: inventory,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
      );
    }
  }

  Future<bool> createdOrUpdateInventory(int id, String name, String description,
      String idCompany, String createAt) async {
    try {
      if (id == 0) {
        final inventory = await inventoryRepository.createInventory(
            name, description, idCompany);
        state = state.copyWith(inventories: [...state.inventories, inventory]);
        return true;
      }
      final inventory = await inventoryRepository.updateInventory(
        name,
        description,
        id,
      );
      state = state.copyWith(
        inventories:
            state.inventories.map((e) => e.id == id ? inventory : e).toList(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

class InventoryState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Inventory> inventories;

  InventoryState({
    this.isLastPage = false,
    this.limit = 0,
    this.offset = 0,
    this.isLoading = false,
    this.inventories = const [],
  });

  InventoryState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Inventory>? inventories,
  }) =>
      InventoryState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        inventories: inventories ?? this.inventories,
      );
}
