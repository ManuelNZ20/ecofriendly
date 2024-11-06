import '../entities/category_card.dart';

abstract class CategoryRepository {
  Future<List<CategoryCard>> getCategories();
  Future<CategoryCard> getCategoryById({String id});

  Future<CategoryCard> updatedCategory({
    required String id,
    required String name,
    required bool status,
    required String img,
  });

  Future<CategoryCard> updatedCategoryCheck({
    required String id,
    required String name,
    required bool status,
    required String img,
    required bool changedImage,
  });

  Future<CategoryCard> createdCategory({
    required String name,
    required bool status,
    required String img,
  });
}
