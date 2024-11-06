import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/category_client.dart';
import '../../domain/repositories/category_client_repository.dart';
import 'repository/repositories_provider.dart';

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, CategoriesState>((ref) {
  final categoryRepository = ref.watch(categoryRepositoryProvider);
  return CategoriesNotifier(
    categoryRepository: categoryRepository,
  );
});

class CategoriesNotifier extends StateNotifier<CategoriesState> {
  final CategoryClientRepository categoryRepository;

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
}

class CategoriesState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<CategoryClient> categories;

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
    List<CategoryClient>? categories,
  }) =>
      CategoriesState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        categories: categories ?? this.categories,
      );
}
