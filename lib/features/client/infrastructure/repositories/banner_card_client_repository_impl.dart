import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/datasources/datasources.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/datasources.dart';

class BannerCardClientRepositoryImpl extends BannerClientRepository {
  final BannerCardClientDatasource bannerDataSource;
  final SupabaseClient supabaseClient;

  BannerCardClientRepositoryImpl({
    BannerCardClientDatasource? bannerDataSource,
    required this.supabaseClient,
  }) : bannerDataSource = bannerDataSource ??
            BannerCardClientDatasourceImpl(
                supabaseClientDatasource: supabaseClient);

  @override
  Future<List<BannerClient>> getBanners() async {
    return await bannerDataSource.getBanners();
  }

  @override
  Future<BannerClient> getBannerById({String id = ''}) async {
    return await bannerDataSource.getBannerById(id: id);
  }

  @override
  Stream<List<BannerClient>> getBannersStream() {
    return bannerDataSource.getBannersStream();
  }
}
