import '../../domain/domain.dart';
import '../models/category.module.dart';

class CategoryMapper {
  static CategoryCard toCategoryEntity(CategoryModel category) => CategoryCard(
        idCategory: category.idCategory,
        name: category.name,
        status: category.status,
        img: category.img,
      );
}
