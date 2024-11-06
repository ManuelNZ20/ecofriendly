import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'repository/product_discount_repository_provider.riverpod.dart';

final productDiscountProvider = StateNotifierProvider.family<
    ProductDiscountNotifier, ProductDiscountState, int>(
  (ref, idproductdiscount) {
    final productDiscountRepository =
        ref.watch(productDiscountRepositoryProvider);

    return ProductDiscountNotifier(
      idproductdiscount: idproductdiscount,
      productDiscountRepository: productDiscountRepository,
    );
  },
);

class ProductDiscountNotifier extends StateNotifier<ProductDiscountState> {
  final ProductDiscountRepository productDiscountRepository;

  ProductDiscountNotifier({
    required int idproductdiscount,
    required this.productDiscountRepository,
  }) : super(ProductDiscountState(id: idproductdiscount)) {
    loadProductDiscount();
  }

  ProductDiscount newEmptyProductDiscount(int idproduct) {
    return ProductDiscount(
      idproductdiscount: 'new',
      idproduct: idproduct,
      discountpercentage: 0,
      createdAt: DateTime.now(),
      product: Product(
        id: 0,
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
      ),
    );
  }

  Future<void> loadProductDiscount() async {
    try {
      print('State ${state.id}');
      if (state.id == 0) {
        state = state.copyWith(
          isLoading: false,
          productDiscount: newEmptyProductDiscount(state.id),
        );
        return;
      }

      final productDiscount =
          await productDiscountRepository.getProductDiscountById(
        idproduct: state.id,
      );
      if (productDiscount == null) {
        state = state.copyWith(
          isLoading: false,
          productDiscount: newEmptyProductDiscount(state.id),
        );
        return;
      }
      state = state.copyWith(
        isLoading: false,
        productDiscount: productDiscount,
      );
    } catch (e) {
      throw (e.toString());
    }
  }
}

class ProductDiscountState {
  final int id;
  final ProductDiscount? productDiscount;
  final bool isLoading;
  final bool isSaving;

  ProductDiscountState({
    required this.id,
    this.productDiscount,
    this.isLoading = false,
    this.isSaving = false,
  });

  ProductDiscountState copyWith({
    int? id,
    ProductDiscount? productDiscount,
    bool? isLoading,
    bool? isSaving,
  }) =>
      ProductDiscountState(
        id: id ?? this.id,
        productDiscount: productDiscount ?? this.productDiscount,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
