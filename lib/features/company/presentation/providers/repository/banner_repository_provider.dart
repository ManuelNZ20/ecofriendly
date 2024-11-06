import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared/infrastructure/service/supabase_cliente_provider.riverpod.dart';
import '../../../domain/domain.dart';
import '../../../infrastructure/infrastructure.dart';

// Banner
final bannerRepositoryProvider = Provider<BannerCardRepository>((ref) {
  final supabaseClient = ref.watch(supabaseProvider);

  final bannerCardRepository = BannerCardRepositoryImpl(
    supabaseClient: supabaseClient,
    bannerDataSource: BannerCardDatasourceImpl(),
  );
  return bannerCardRepository;
});
