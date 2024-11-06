import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/entities.dart';
import '../repository/repositories_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchProductsProvider =
    StateNotifierProvider<SearchProductNotifier, List<ProductClient>>((ref) {
  final productRepository = ref.read(productRepositoryProvider);
  return SearchProductNotifier(
    searchProduct: productRepository.searchProducts,
    ref: ref,
  );
});

typedef SearchProductCallback = Future<List<ProductClient>> Function(
    String query);

class SearchProductNotifier extends StateNotifier<List<ProductClient>> {
  final SearchProductCallback searchProduct;
  final Ref ref;
  SearchProductNotifier({
    required this.searchProduct,
    required this.ref,
  }) : super([]);

  Future<List<ProductClient>> searchProductByQuery(String query) async {
    final List<ProductClient> products = await searchProduct(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = products;
    return products;
  }
}
