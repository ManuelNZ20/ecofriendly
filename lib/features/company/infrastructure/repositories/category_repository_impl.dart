import '../../domain/domain.dart';
import '../infrastructure.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDatasource categoryDataSource;

  CategoryRepositoryImpl({
    CategoryDatasource? categoryDataSource,
  }) : categoryDataSource = categoryDataSource ?? CategoryDatasourceImpl();

  @override
  Future<CategoryCard> createdCategory({
    required String name,
    required bool status,
    required String img,
  }) async {
    final category = await categoryDataSource.createdCategory(
      name: name,
      status: status,
      img: img,
    );
    return category;
  }

  @override
  Future<List<CategoryCard>> getCategories() async {
    final categories = await categoryDataSource.getCategories();
    return categories;
  }

  @override
  Future<CategoryCard> getCategoryById({String id = ''}) async {
    final category = await categoryDataSource.getCategoryById(id: id);
    return category;
  }

  @override
  Future<CategoryCard> updatedCategory(
      {required String id,
      required String name,
      required bool status,
      required String img}) async {
    final category = await updatedCategory(
      id: id,
      name: name,
      status: status,
      img: img,
    );
    return category;
  }

  @override
  Future<CategoryCard> updatedCategoryCheck({
    required String id,
    required String name,
    required bool status,
    required String img,
    required bool changedImage,
  }) async {
    final category = await categoryDataSource.updatedCategoryCheck(
      id: id,
      name: name,
      status: status,
      img: img,
      changedImage: changedImage,
    );
    return category;
  }
}
