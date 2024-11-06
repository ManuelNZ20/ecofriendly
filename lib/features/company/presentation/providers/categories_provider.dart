import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import 'repository/category_repository_provider.dart';

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, CategoriesState>((ref) {
  final categoryRepository = ref.watch(categoryRepositoryProvider);
  return CategoriesNotifier(
    categoryRepository: categoryRepository,
  );
});

class CategoriesNotifier extends StateNotifier<CategoriesState> {
  final CategoryRepository categoryRepository;

  CategoriesNotifier({
    required this.categoryRepository,
  }) : super(CategoriesState()) {
    loadCategories();
  }
  Future<void> loadCategories() async {
    try {
      state = state.copyWith(
        categories: [],
      );
      if (state.isLoading) return;
      state = state.copyWith(isLoading: true);
      final categories = await categoryRepository.getCategories();
      if (categories.isEmpty) {
        state = state.copyWith(isLoading: false);
        return;
      }
      state = state.copyWith(
        isLoading: false,
        categories: categories,
      );
    } catch (e) {
      print('Error: $e');
      state = state.copyWith(
        isLoading: false,
      );
    }
  }

  Future<bool> createdOrUpdatedCategory(
    String id,
    String name,
    bool status,
    String img,
  ) async {
    try {
      if (id == 'new') {
        final category = await categoryRepository.createdCategory(
          name: name,
          status: status,
          img: img,
        );
        state = state.copyWith(categories: [
          ...state.categories,
          category,
        ]);
        return true;
      }
      final existingCategory = state.categories.firstWhere(
        (element) => element.idCategory == id,
      );
      final bool hasImageChanged = existingCategory.img != img;

      final category = await categoryRepository.updatedCategoryCheck(
        id: id,
        name: name,
        status: status,
        img: img,
        changedImage: hasImageChanged,
      );
      state = state.copyWith(
          categories: state.categories
              .map((e) => (e.idCategory) == id ? category : e)
              .toList());
      return true;
    } catch (e) {
      return false;
    }
  }
}

class CategoriesState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<CategoryCard> categories;

  CategoriesState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.categories = const [],
  });

  CategoriesState copyWith({
    bool? isLastPage,
    int? limit = 10,
    int? offset = 0,
    bool? isLoading,
    List<CategoryCard>? categories,
  }) =>
      CategoriesState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        categories: categories ?? this.categories,
      );
}
