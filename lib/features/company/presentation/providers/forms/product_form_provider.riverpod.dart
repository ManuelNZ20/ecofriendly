import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/domain.dart';
import '../products_provider.riverpod.dart';

final productFormProvider = StateNotifierProvider.family<ProductFormNotifier,
    ProductFormState, Product>((ref, product) {
  final createdOrUpdateProduct =
      ref.watch(productsProvider.notifier).createdOrUpdatedProduct;
  return ProductFormNotifier(
    onSubmitCallback: createdOrUpdateProduct,
    product: product,
  );
});

final productFormByInventoryProvider = StateNotifierProvider.family<
    ProductFormNotifier,
    ProductFormState,
    Map<String, dynamic>>((ref, extraData) {
  final createdOrUpdateProduct =
      ref.watch(productsProvider.notifier).createdOrUpdatedProduct;
  return ProductFormNotifier(
    onSubmitCallback: createdOrUpdateProduct,
    product: extraData['product'],
  );
});

class ProductFormNotifier extends StateNotifier<ProductFormState> {
  final Future<bool> Function(
    int idProduct,
    String nameProduct,
    String brand,
    String description,
    bool status,
    String img,
    double price,
    int amount,
    DateTime createAt,
    DateTime updateAt,
    DateTime expireProduct,
    int idCategory,
  )? onSubmitCallback;

  ProductFormNotifier({
    this.onSubmitCallback,
    required Product product,
  }) : super(
          ProductFormState(
            idProduct: product.id,
            nameProduct: product.nameProduct,
            brand: product.brand,
            description: product.description,
            status: product.status,
            img: product.img,
            price: product.price,
            amount: product.amount,
            createAtParams: product.createAt,
            updateAtParams: product.updateAt,
            expireProductParams: product.expireProduct,
            idCategory: product.idCategory,
            isFormValid: true,
          ),
        );

  void updateProductImage(String img) {
    state = state.copyWith(
      img: img,
    );
  }

  void onNameProductChange(String value) {
    state = state.copyWith(
      nameProduct: value,
      isFormValid: true,
    );
  }

  void onBrandChange(String value) {
    state = state.copyWith(
      brand: value,
      isFormValid: true,
    );
  }

  void onDescriptionChange(String value) {
    state = state.copyWith(
      description: value,
      isFormValid: true,
    );
  }

  void onStatusChange(bool value) {
    state = state.copyWith(
      status: value,
      isFormValid: true,
    );
  }

  void onPriceChange(String value) {
    state = state.copyWith(
      price: double.parse(value.isEmpty ? '0' : value),
      isFormValid: true,
    );
  }

  void onAmountChange(String value) {
    state = state.copyWith(
      amount: int.parse(value.isEmpty ? '0' : value),
      isFormValid: true,
    );
  }

  void onCreateAtChange(String value) {
    state = state.copyWith(
      createAt: DateTime.parse(value),
      isFormValid: true,
    );
  }

  void onUpdateAtChange(String value) {
    state = state.copyWith(
      updateAt: DateTime.parse(value),
      isFormValid: true,
    );
  }

  void onExpireProductChange(String value) {
    state = state.copyWith(
      expireProduct: DateTime.parse(value),
      isFormValid: true,
    );
  }

  void onIdCategoryChange(String? value) {
    state = state.copyWith(
      idCategory: int.parse(value ?? '1'),
      isFormValid: true,
    );
  }

  Future<bool> onFormSubmit() async {
    if (!state.isFormValid) return false;
    if (onSubmitCallback == null) return false;
    try {
      return await onSubmitCallback!(
        state.idProduct ?? 0,
        state.nameProduct,
        state.brand,
        state.description,
        state.status,
        state.img,
        state.price,
        state.amount,
        state.createAt ?? DateTime.now(),
        state.updateAt ?? DateTime.now(),
        state.expireProduct ?? DateTime.now(),
        state.idCategory,
      );
    } catch (e) {
      return false;
    }
  }
}

class ProductFormState {
  final bool isFormValid;
  final int? idProduct;
  final String nameProduct;
  final String brand;
  final String description;
  final bool status;
  final String img;
  final double price;
  final int amount;
  final DateTime? createAt = DateTime.now();
  final DateTime? updateAt = DateTime.now();
  final DateTime? expireProduct = DateTime.now();
  final int idCategory;

  ProductFormState({
    this.isFormValid = false,
    this.idProduct = 0,
    this.nameProduct = '',
    this.brand = '',
    this.description = '',
    this.status = false,
    this.img = '',
    this.price = 0.0,
    this.amount = 0,
    createAtParams,
    updateAtParams,
    expireProductParams,
    this.idCategory = 0,
  });

  ProductFormState copyWith({
    bool? isFormValid,
    int? idProduct,
    String? nameProduct,
    String? brand,
    String? description,
    bool? status,
    String? img,
    double? price,
    int? amount,
    DateTime? createAt,
    DateTime? updateAt,
    DateTime? expireProduct,
    int? idCategory,
  }) =>
      ProductFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        idProduct: idProduct ?? this.idProduct,
        nameProduct: nameProduct ?? this.nameProduct,
        brand: brand ?? this.brand,
        description: description ?? this.description,
        status: status ?? this.status,
        img: img ?? this.img,
        price: price ?? this.price,
        amount: amount ?? this.amount,
        createAtParams: createAt ?? this.createAt,
        updateAtParams: updateAt ?? this.updateAt,
        expireProductParams: expireProduct ?? this.expireProduct,
        idCategory: idCategory ?? this.idCategory,
      );
}
