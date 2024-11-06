import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/datasources/datasources.dart';
import '../../domain/entities/category_client.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/datasources.dart';

class CategoryClientRepositoryImpl extends CategoryClientRepository {
  final CategoryClientDatasource categoryDataSource;
  final SupabaseClient supabaseClient;

  CategoryClientRepositoryImpl({
    CategoryClientDatasource? categoryDataSource,
    required this.supabaseClient,
  }) : categoryDataSource = categoryDataSource ??
            CategoryClientDatasourceImpl(
                supabaseClientDatasource: supabaseClient);

  @override
  Future<List<CategoryClient>> getCategories() async {
    final categories = await categoryDataSource.getCategories();
    return categories;
  }

  @override
  Future<CategoryClient> getCategoryById({String id = ''}) async {
    final category = await categoryDataSource.getCategoryById(id: id);
    return category;
  }

  @override
  Stream<List<CategoryClient>> getCategoriesStream() {
    return categoryDataSource.getCategoriesStream();
  }
}
