import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/domain.dart';
import '../../../infrastructure/infrastructure.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final categoryRepository = CategoryRepositoryImpl(
    categoryDataSource: CategoryDatasourceImpl(),
  );
  return categoryRepository;
});
