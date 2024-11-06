import '../entities/category_client.dart';

abstract class CategoryClientRepository {
  Future<List<CategoryClient>> getCategories();
  Future<CategoryClient> getCategoryById({String id});

  Stream<List<CategoryClient>> getCategoriesStream();
}
