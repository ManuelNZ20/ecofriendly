import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/domain.dart';
import '../categories_provider.dart';

final categoryFormProvider = StateNotifierProvider.family<CategoryFormNotifier,
    CategoryFormState, CategoryCard>((ref, category) {
  final createdOrUpdatedCategory =
      ref.watch(categoriesProvider.notifier).createdOrUpdatedCategory;
  return CategoryFormNotifier(
    onSubmitCallback: createdOrUpdatedCategory,
    category: category,
  );
});

class CategoryFormNotifier extends StateNotifier<CategoryFormState> {
  final Future<bool> Function(
    String id,
    String name,
    bool status,
    String img,
  )? onSubmitCallback;

  CategoryFormNotifier({
    this.onSubmitCallback,
    required CategoryCard category,
  }) : super(
          CategoryFormState(
            id: category.idCategory,
            name: category.name,
            status: category.status,
            img: category.img,
            isFormValid: true,
          ),
        );

  void onNameChange(String value) {
    state = state.copyWith(
      name: value,
      isFormValid: true,
    );
  }

  void updateCategoryImage(String img) {
    state = state.copyWith(
      img: img,
    );
  }

  void onStatusChange(bool value) {
    state = state.copyWith(
      status: value,
      isFormValid: true,
    );
  }

  Future<bool> onFormSubmit() async {
    if (!state.isFormValid) return false;
    if (onSubmitCallback == null) return false;
    try {
      return await onSubmitCallback!(
        state.id ?? '',
        state.name,
        state.status,
        state.img,
      );
    } catch (e) {
      return false;
    }
  }
}

class CategoryFormState {
  final bool isFormValid;
  final String? id;
  final String name;
  final bool status;
  final String img;

  CategoryFormState({
    this.isFormValid = false,
    this.id = '',
    this.name = '',
    this.status = false,
    this.img = '',
  });

  CategoryFormState copyWith({
    bool? isFormValid,
    String? id,
    String? name,
    bool? status,
    String? img,
  }) =>
      CategoryFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status,
        img: img ?? this.img,
      );
}
