import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/datasources/datasources.dart';
import '../../domain/entities/category_client.dart';
import '../mappers/category_client_mapper.dart';
import '../model/category_client_model.dart';

class CategoryClientDatasourceImpl extends CategoryClientDatasource {
  final SupabaseClient supabaseClient;
  static String nameTable = 'category';

  CategoryClientDatasourceImpl({
    SupabaseClient? supabaseClientDatasource,
  }) : supabaseClient = supabaseClientDatasource ?? Supabase.instance.client;

  @override
  Future<List<CategoryClient>> getCategories() async {
    try {
      final response =
          await supabaseClient.from(nameTable).select().eq('status', true);
      final categories = response
          .map((category) => CategoryClientMapper.toCategoryEntity(
              CategoryClientModel.fromJson(category)))
          .toList();

      return categories;
    } catch (e) {
      throw Exception('Error loading categories $e');
    }
  }

  @override
  Future<CategoryClient> getCategoryById({String id = ''}) async {
    try {
      final response = await supabaseClient.from(nameTable).select().eq(
            'idCategory',
            id,
          );
      final category = response
          .map((category) => CategoryClientMapper.toCategoryEntity(
              CategoryClientModel.fromJson(category)))
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
  Stream<List<CategoryClient>> getCategoriesStream() {
    try {
      final response =
          supabaseClient.from(nameTable).stream(primaryKey: ['idCategory']);
      final categories =
          response.map((category) => _responseCategory(category));
      return categories;
    } catch (e) {
      throw Exception('Error loading categories $e');
    }
  }

  List<CategoryClient> _responseCategory(List<Map<String, dynamic>> response) {
    final categories = response
        .map(
          (product) => CategoryClientMapper.toCategoryEntity(
            CategoryClientModel.fromJson(product),
          ),
        )
        .toList();
    return categories;
  }
}
