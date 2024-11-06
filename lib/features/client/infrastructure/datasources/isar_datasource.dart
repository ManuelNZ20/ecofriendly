import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/entities/entities.dart';
import '../../domain/datasources/local_storage_datasource.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;
  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [ProductClientSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isProductFavorite(int productId) async {
    final isar = await db;

    final ProductClient? isFavoriteProduct =
        await isar.productClients.filter().idEqualTo(productId).findFirst();

    return isFavoriteProduct != null;
  }

  @override
  Future<List<ProductClient>> loadProducts(
      {int limit = 10, int offset = 0}) async {
    final isar = await db;
    return isar.productClients.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavorite(ProductClient product) async {
    try {
      final isar = await db;
      final favoriteProduct =
          await isar.productClients.filter().idEqualTo(product.id).findFirst();
      if (favoriteProduct != null) {
        print('${favoriteProduct.id}');
        // borrar
        isar.writeTxnSync(
            () => isar.productClients.deleteSync(favoriteProduct.isarId!));
        return;
      }
      isar.writeTxnSync(() => isar.productClients.putSync(product));
      // insertar
    } catch (e) {
      print(e);
    }
  }
}
