import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/domain.dart';
import '../products_discount_provider.dart';

final productDiscountFormProvider = StateNotifierProvider.family<
    ProductDiscountFormNotifier,
    ProductDiscountFormState,
    ProductDiscount>((ref, productDiscount) {
  final createdOrdUpdateProductDiscount = ref
      .watch(productsDiscountProvider.notifier)
      .createdOrUpdateProductDiscount;
  return ProductDiscountFormNotifier(
    productDiscount: productDiscount,
    onSubmitCallback: createdOrdUpdateProductDiscount,
  );
});

class ProductDiscountFormNotifier
    extends StateNotifier<ProductDiscountFormState> {
  final Future<bool> Function(
    String idproductdiscount,
    int idproduct,
    double percentage,
  )? onSubmitCallback;

  ProductDiscountFormNotifier({
    this.onSubmitCallback,
    required ProductDiscount productDiscount,
  }) : super(
          ProductDiscountFormState(
            id: productDiscount.idproductdiscount,
            idproduct: productDiscount.idproduct,
            percentage: productDiscount.discountpercentage,
          ),
        );

  void onDiscountPercentageChange(String value) {
    state = state.copyWith(
      percentage: double.parse(value == '' ? '0' : value),
      total:
          state.total - (state.total * double.parse(value == '' ? '0' : value)),
      isFormValid: true,
    );
  }

  void onTotalChange(String value) {
    state = state.copyWith(
      total: double.parse(value),
    );
  }

  Future<bool> onFormSubmit() async {
    if (!state.isFormValid) return false;
    if (onSubmitCallback == null) return false;
    try {
      return await onSubmitCallback!(
        state.id ?? '',
        state.idproduct,
        (state.percentage),
      );
    } catch (e) {
      return false;
    }
  }
}

class ProductDiscountFormState {
  final bool isFormValid;
  final String? id;
  final int idproduct;
  final double percentage;
  final double total;

  ProductDiscountFormState({
    this.isFormValid = false,
    this.id = '',
    this.idproduct = 0,
    this.percentage = 0.0,
    this.total = 0.0,
  });
  ProductDiscountFormState copyWith({
    bool? isFormValid,
    String? id,
    int? idproduct,
    double? percentage,
    double? total,
  }) =>
      ProductDiscountFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        idproduct: idproduct ?? this.idproduct,
        percentage: percentage ?? this.percentage,
        total: total ?? this.total,
      );
}
