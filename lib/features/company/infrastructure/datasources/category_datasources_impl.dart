import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';
import '../../../../core/shared/infrastructure/service/cloudinary_init.service.riverpod.dart';
import '../mapper/category_mapper.dart';
import '../models/category.module.dart';

class CategoryDatasourceImpl extends CategoryDatasource {
  final supabase = Supabase.instance.client;
  static String nameTable = 'category';

  @override
  Future<CategoryCard> createdCategory({
    required String name,
    required bool status,
    required String img,
  }) async {
    final imgPath =
        await CloudinaryInit.uploadImage(img, UploadPreset.category);
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final response = await supabase.from(nameTable).insert(
        [
          {
            'name': name,
            'status': status,
            'img': imgPath,
          },
        ],
      ).select();
      final category = response
          .map(
            (category) => CategoryMapper.toCategoryEntity(
              CategoryModel.fromJson(category),
            ),
          )
          .toList()
          .first;
      return category;
    } catch (e) {
      print('Created Category $e');
      throw Exception(e);
    }
  }

  @override
  Future<List<CategoryCard>> getCategories() async {
    try {
      final response = await supabase.from(nameTable).select();
      final categories = response
          .map((category) =>
              CategoryMapper.toCategoryEntity(CategoryModel.fromJson(category)))
          .toList();

      return categories;
    } catch (e) {
      throw Exception('Error loading categories $e');
    }
  }

  @override
  Future<CategoryCard> getCategoryById({String id = ''}) async {
    try {
      final response = await supabase.from(nameTable).select().eq(
            'idCategory',
            id,
          );
      final category = response
          .map((category) =>
              CategoryMapper.toCategoryEntity(CategoryModel.fromJson(category)))
          .toList()
          .first;
      return category;
    } on AuthException catch (e) {
      if (e.statusCode == '404') {
        throw Exception('Category Not Found');
      }
      throw Exception(e);
    } catch (e) {
      throw Exception('Error loading category, error: $e');
    }
  }

  @override
  Future<CategoryCard> updatedCategory({
    required String id,
    required String name,
    required bool status,
    required String img,
  }) async {
    try {
      final response = await supabase
          .from(nameTable)
          .update({
            'name': name,
            'status': status,
            'img': img,
          })
          .eq('idCategory', id)
          .select();
      final category = response
          .map((category) =>
              CategoryMapper.toCategoryEntity(CategoryModel.fromJson(category)))
          .toList()
          .first;
      return category;
    } catch (e) {
      print('Error update category: $e');
      throw Exception(e);
    }
  }

  @override
  Future<CategoryCard> updatedCategoryCheck({
    required String id,
    required String name,
    required bool status,
    required String img,
    required bool changedImage,
  }) async {
    String imgPath = '';
    if (changedImage) {
      imgPath = await CloudinaryInit.uploadImage(img, UploadPreset.category);
    } else {
      imgPath = img;
    }

    await Future.delayed(const Duration(milliseconds: 500));
    final category = await updatedCategory(
      id: id,
      name: name,
      status: status,
      img: imgPath,
    );
    return category;
  }
}
