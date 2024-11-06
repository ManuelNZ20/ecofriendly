import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/product_client.dart';
import '../../domain/repositories/product_client_repository.dart';
import 'products_provider.dart';
import 'repository/repositories_provider.dart';

final productDetailProvider =
    FutureProvider.family<ProductClient, int>((ref, id) async {
  final product = ref.watch(productsProvider.notifier).getProduct(id: id);
  return product;
});

final productProvider =
    StateNotifierProvider.family<ProductNotifier, ProductState, int>(
        (ref, idProduct) {
  final productRepository = ref.watch(productRepositoryProvider);
  return ProductNotifier(
    idProduct: idProduct,
    productRepository: productRepository,
  );
});

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductClientRepository productRepository;
  ProductNotifier({
    required int idProduct,
    required this.productRepository,
  }) : super(ProductState(id: idProduct)) {
    loadProduct();
  }
  ProductClient newEmptyProduct() {
    return ProductClient(
      id: 0,
      idProduct: 'new',
      nameProduct: '',
      brand: '',
      description: '',
      status: false,
      img: '',
      price: 0,
      amount: 0,
      createAt: DateTime.now(),
      updateAt: DateTime.now(),
      expireProduct: DateTime(2024, DateTime.december, 10, 11, 59),
      idCategory: 0,
      idproductdiscount: 'new',
      discountpercentage: 0,
    );
  }

  Future<void> loadProduct() async {
    try {
      if (state.id == 'new') {
        state = state.copyWith(
          isLoading: false,
          product: newEmptyProduct(),
        );
        return;
      }
      final product =
          await productRepository.getProductById(idProduct: state.id);
      state = state.copyWith(
        isLoading: false,
        product: product,
      );
    } catch (e) {
      throw (e.toString());
    }
  }
}

class ProductState {
  final int id;
  final ProductClient? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id,
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });

  ProductState copyWith({
    int? id,
    ProductClient? product,
    bool? isLoading,
    bool? isSaving,
  }) =>
      ProductState(
        id: id ?? this.id,
        product: product ?? this.product,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
