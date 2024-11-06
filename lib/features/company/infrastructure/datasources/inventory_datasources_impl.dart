import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';
import '../models/inventory.module.dart';

class InventoryDatasourcesImpl implements InventoryDatasource {
  static String table = 'inventory_company';
  final supabase = Supabase.instance.client;
  @override
  Future<Inventory> createInventory(
      String name, String description, String idCompany) async {
    try {
      final response = await supabase.from('inventory_company').insert(
        [
          {
            'name': name,
            'description': description,
            'id_company': idCompany,
          }
        ],
      ).select();
      final inventory = _responseInvetory(response.first);
      return inventory;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<List<Inventory>> getInventoriesStream() {
    final response = supabase.from(table).stream(primaryKey: ['id']);
    final inventories = response.map((inventory) =>
        inventory.map((element) => _responseInvetory(element)).toList());

    return inventories;
  }

  @override
  Future<Inventory> getInventoryById(int idInventory) async {
    try {
      final response =
          await supabase.from(table).select().eq('id', idInventory);
      final inventory = _responseInvetory(response.first);
      return inventory;
    } catch (e) {
      throw Exception('Error loading product, product: $e');
    }
  }

  @override
  Future<Inventory> updateInventory(
      String name, String description, int id) async {
    try {
      final response = await supabase
          .from(table)
          .update({
            'name': name,
            'description': description,
          })
          .eq('id', id)
          .select();
      final inventory = _responseInvetory(response.first);
      return inventory;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Inventory>> getInventories() async {
    try {
      final response = await supabase.from(table).select();
      return response.map((e) => _responseInvetory(e)).toList();
    } catch (e) {
      throw Exception('Error Inventories');
    }
  }

  Inventory _responseInvetory(Map<String, dynamic> response) {
    final inventory = InventoryModel.fromJson(response).toInventoryEntity();
    return inventory;
  }
}
