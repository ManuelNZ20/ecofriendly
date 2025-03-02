import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared/infrastructure/service/supabase_client_provider.riverpod.dart';
import '../../../domain/repositories/repositories.dart';
import '../../../infrastructure/infrastructure.dart';

final categoryRepositoryProvider = Provider<CategoryClientRepository>((ref) {
  final supabaseClient = ref.watch(supabaseProvider);

  final categoryRepository = CategoryClientRepositoryImpl(
    supabaseClient: supabaseClient,
    categoryDataSource: CategoryClientDatasourceImpl(),
  );
  return categoryRepository;
});
