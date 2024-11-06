import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared/infrastructure/service/supabase_cliente_provider.riverpod.dart';
import '../../../infrastructure/infrastructure.dart';
import '../../../domain/domain.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final supabaseClient = ref.watch(supabaseProvider);
  final productRepository = ProductRepositoryImpl(
    supabaseClient: supabaseClient,
    productDataSource: ProductDatasourceImpl(),
  );
  return productRepository;
});
