import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'repository/product_discount_repository_provider.riverpod.dart';

final productsDiscountProvider =
    StateNotifierProvider<ProductsDiscountNotifier, ProductsDiscountState>(
        (ref) {
  final productDiscountRepository =
      ref.watch(productDiscountRepositoryProvider);
  return ProductsDiscountNotifier(
    productDiscountRepository: productDiscountRepository,
  );
});

class ProductsDiscountNotifier extends StateNotifier<ProductsDiscountState> {
  final ProductDiscountRepository productDiscountRepository;
  ProductsDiscountNotifier({
    required this.productDiscountRepository,
  }) : super(
          ProductsDiscountState(),
        ) {
    loadProductsDiscount();
  }
  Stream<List<ProductDiscount>> getProductsDiscountStream() {
    try {
      final productsDiscount = productDiscountRepository.getProductsStream();
      return productsDiscount;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<void> loadProductsDiscount() async {
    try {
      state = state.copyWith(
        productsDiscount: [],
      );
      if (state.isLoading) return;
      state = state.copyWith(
        isLoading: true,
      );
      final productsDiscount =
          await productDiscountRepository.getProductsDiscount();
      if (productsDiscount.isEmpty) {
        state = state.copyWith(
          isLoading: false,
        );
        return;
      }
      state = state.copyWith(
        isLoading: false,
        productsDiscount: productsDiscount,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
      );
    }
  }

  Future<bool> createdOrUpdateProductDiscount(
    String idproductdiscount,
    int idproduct,
    double percentage,
  ) async {
    try {
      if (idproductdiscount == 'new') {
        final productDiscount =
            await productDiscountRepository.createProductDiscount(
          idproduct: idproduct,
          discountPercentage: percentage,
        );
        state = state.copyWith(
          productsDiscount: [...state.productsDiscount, productDiscount],
        );
        return true;
      }
      final productDiscount =
          await productDiscountRepository.updateProductDiscount(
        idproductdiscount: idproductdiscount,
        idproduct: idproduct,
        discountPercentage: percentage,
      );
      state = state.copyWith(
        productsDiscount: state.productsDiscount
            .map((e) => (e.idproductdiscount == idproductdiscount)
                ? productDiscount
                : e)
            .toList(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

class ProductsDiscountState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<ProductDiscount> productsDiscount;

  ProductsDiscountState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.productsDiscount = const [],
  });

  ProductsDiscountState copyWith({
    bool? isLastPage,
    int? limit = 10,
    int? offset = 0,
    bool? isLoading,
    List<ProductDiscount>? productsDiscount,
  }) =>
      ProductsDiscountState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        productsDiscount: productsDiscount ?? this.productsDiscount,
      );
}
