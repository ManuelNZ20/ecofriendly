import '../entities/entities.dart';

abstract class LocalStorageRepository {
  Future<void> toggleFavorite(ProductClient product);

  Future<bool> isProductFavorite(int productId);

  Future<List<ProductClient>> loadProducts({int limit = 0, int offset = 0});
}
