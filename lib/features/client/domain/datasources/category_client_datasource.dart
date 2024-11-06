import '../entities/entities.dart';

abstract class CategoryClientDatasource {
  Future<List<CategoryClient>> getCategories();
  Future<CategoryClient> getCategoryById({String id});

  Stream<List<CategoryClient>> getCategoriesStream();
}
