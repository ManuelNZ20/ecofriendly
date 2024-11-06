import '../../domain/entities/entities.dart';
import '../../domain/datasources/local_storage_datasource.dart';
import '../../domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);
  @override
  Future<bool> isProductFavorite(int productId) async {
    return await datasource.isProductFavorite(productId);
  }

  @override
  Future<List<ProductClient>> loadProducts(
      {int limit = 0, int offset = 0}) async {
    return await datasource.loadProducts(
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<void> toggleFavorite(ProductClient product) async {
    return await datasource.toggleFavorite(product);
  }
}
