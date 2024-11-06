import '../datasources/inventory_datasources_impl.dart';
import '../../domain/domain.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final InventoryDatasource inventoryDatasource;

  InventoryRepositoryImpl({InventoryDatasource? inventoryDatasource})
      : inventoryDatasource = inventoryDatasource ?? InventoryDatasourcesImpl();
  @override
  Future<Inventory> createInventory(
      String name, String description, String idCompany) async {
    return await inventoryDatasource.createInventory(
        name, description, idCompany);
  }

  @override
  Stream<List<Inventory>> getInventoriesStream() {
    return inventoryDatasource.getInventoriesStream();
  }

  @override
  Future<Inventory> getInventoryById(int idInventory) async {
    return await inventoryDatasource.getInventoryById(idInventory);
  }

  @override
  Future<Inventory> updateInventory(
      String name, String description, int idInventory) async {
    return await inventoryDatasource.updateInventory(
        name, description, idInventory);
  }

  @override
  Future<List<Inventory>> getInventories() async {
    return await inventoryDatasource.getInventories();
  }
}
