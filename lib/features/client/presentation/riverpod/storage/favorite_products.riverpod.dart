import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/local_storage_repository.dart';
import 'local_storage.riverpod.dart';

final productsFavoriteProvider =
    StateNotifierProvider<StorageProductNotifier, Map<int, ProductClient>>(
        (ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageProductNotifier(
    localStorageRepository: localStorageRepository,
  );
});

class StorageProductNotifier extends StateNotifier<Map<int, ProductClient>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;
  StorageProductNotifier({
    required this.localStorageRepository,
  }) : super({});

  Future<List<ProductClient>> loadNextPage() async {
    final products = await localStorageRepository.loadProducts(
      offset: page * 10,
      limit: 20,
    );
    ++page;
    final tempProductMap = <int, ProductClient>{};
    for (final product in products) {
      tempProductMap[product.id] = product;
    }
    state = {
      ...state,
      ...tempProductMap,
    };
    return products;
  }

  Future<void> toggleFavorite(ProductClient product) async {
    await localStorageRepository.toggleFavorite(product);
    final bool isProductInFavorites = state[product.id] != null;
    if (isProductInFavorites) {
      state.remove(product.id);
      state = {
        ...state,
      };
    } else {
      state = {
        ...state,
        product.id: product,
      };
    }
  }
}
