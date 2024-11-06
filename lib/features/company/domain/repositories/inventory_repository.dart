import '../entities/inventory.dart';

abstract class InventoryRepository {
  Future<Inventory> createInventory(
    String name,
    String description,
    String idCompany,
  );

  Stream<List<Inventory>> getInventoriesStream();

  Future<Inventory> updateInventory(
    String name,
    String description,
    int idInventory,
  );

  Future<Inventory> getInventoryById(int idInventory);

  Future<List<Inventory>> getInventories();
}
