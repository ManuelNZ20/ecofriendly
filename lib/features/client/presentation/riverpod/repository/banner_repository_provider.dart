import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/shared/infrastructure/service/supabase_cliente_provider.riverpod.dart';
import '../../../domain/repositories/repositories.dart';
import '../../../infrastructure/infrastructure.dart';

// Banner
final bannerRepositoryProvider = Provider<BannerClientRepository>((ref) {
  final supabaseClient = ref.watch(supabaseProvider);

  final bannerCardRepository = BannerCardClientRepositoryImpl(
    supabaseClient: supabaseClient,
    bannerDataSource: BannerCardClientDatasourceImpl(),
  );
  return bannerCardRepository;
});
