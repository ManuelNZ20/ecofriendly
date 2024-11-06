import '../entities/entities.dart';

abstract class BannerCardClientDatasource {
  Future<List<BannerClient>> getBanners();
  Future<BannerClient> getBannerById({String id});

  Stream<List<BannerClient>> getBannersStream();
}
