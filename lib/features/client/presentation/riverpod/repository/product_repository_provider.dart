import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/shared/infrastructure/service/supabase_cliente_provider.riverpod.dart';
import '../../../domain/repositories/repositories.dart';
import '../../../infrastructure/infrastructure.dart';

final productRepositoryProvider = Provider<ProductClientRepository>((ref) {
  final supabaseClient = ref.watch(supabaseProvider);
  final productRepository = ProductClientRepositoryImpl(
    supabaseClient: supabaseClient,
    productDataSource: ProductClientDatasourceImpl(),
  );
  return productRepository;
});
