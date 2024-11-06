import '../../domain/entities/entities.dart';
import '../model/model.dart';

class CategoryClientMapper {
  static CategoryClient toCategoryEntity(CategoryClientModel category) =>
      CategoryClient(
        idCategory: category.idCategory,
        name: category.name,
        status: category.status,
        img: category.img,
      );
}
