import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/category_client.dart';
import '../../domain/repositories/category_client_repository.dart';
import 'repository/repositories_provider.dart';

final categoryProvider = StateNotifierProvider.autoDispose
    .family<CategoryNotifier, CategoryState, String>((ref, idCategory) {
  final categoryRepository = ref.watch(categoryRepositoryProvider);
  return CategoryNotifier(
    categoryRepository: categoryRepository,
    idCategory: idCategory,
  );
});

class CategoryNotifier extends StateNotifier<CategoryState> {
  final CategoryClientRepository categoryRepository;

  CategoryNotifier({
    required this.categoryRepository,
    required String idCategory,
  }) : super(CategoryState(
          id: idCategory,
        )) {
    loadCategory();
  }
  CategoryClient newEmptyCategory() {
    return CategoryClient(
      idCategory: 'new',
      name: '',
      status: false,
      img:
          'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png',
    );
  }

  Future<void> loadCategory() async {
    try {
      if (state.id == 'new') {
        state = state.copyWith(
          isLoading: false,
          categoryCard: newEmptyCategory(),
        );
        return;
      }
      final category = await categoryRepository.getCategoryById(id: state.id);
      state = state.copyWith(
        isLoading: false,
        categoryCard: category,
      );
    } catch (e) {
      throw (e.toString());
    }
  }
}

class CategoryState {
  final String id;
  final CategoryClient? categoryCard;
  final bool isLoading;
  final bool isSaving;

  CategoryState({
    required this.id,
    this.categoryCard,
    this.isLoading = true,
    this.isSaving = false,
  });

  CategoryState copyWith({
    String? id,
    CategoryClient? categoryCard,
    bool? isLoading,
    bool? isSaving,
  }) =>
      CategoryState(
        id: id ?? this.id,
        categoryCard: categoryCard ?? this.categoryCard,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
