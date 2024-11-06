import 'package:supabase_flutter/supabase_flutter.dart';
import '../datasources/banner_card_datasources_impl.dart';
import '../../domain/domain.dart';

class BannerCardRepositoryImpl extends BannerCardRepository {
  final BannerCardDatasource bannerDataSource;
  final SupabaseClient supabaseClient;

  BannerCardRepositoryImpl({
    BannerCardDatasource? bannerDataSource,
    required this.supabaseClient,
  }) : bannerDataSource = bannerDataSource ??
            BannerCardDatasourceImpl(supabaseClientDatasource: supabaseClient);
  @override
  Future<BannerCard> createdBanner({
    required String title,
    required String subTitle,
    required String imgUrl,
    required bool isActive,
    required String linkScreen,
    required String titleLink,
  }) {
    return bannerDataSource.createdBanner(
      title: title,
      subTitle: subTitle,
      imgUrl: imgUrl,
      isActive: isActive,
      linkScreen: linkScreen,
      titleLink: titleLink,
    );
  }

  @override
  Future<void> deleteBanner({String id = ''}) {
    throw UnimplementedError();
  }

  @override
  Future<List<BannerCard>> getBanners() async {
    return await bannerDataSource.getBanners();
  }

  @override
  Future<BannerCard> updateBanner({
    required String id,
    required String title,
    required String subTitle,
    required String imgUrl,
    required bool isActive,
    required String linkScreen,
    required String titleLink,
  }) async {
    return await bannerDataSource.updateBanner(
      id: id,
      title: title,
      subTitle: subTitle,
      imgUrl: imgUrl,
      isActive: isActive,
      linkScreen: linkScreen,
      titleLink: titleLink,
    );
  }

  @override
  Future<BannerCard> updateBannerCheck({
    required String id,
    required String title,
    required String subTitle,
    required String imgUrl,
    required bool isActive,
    required String linkScreen,
    required String titleLink,
    required bool changedImage,
  }) async {
    return await bannerDataSource.updateBannerCheck(
      id: id,
      title: title,
      subTitle: subTitle,
      imgUrl: imgUrl,
      isActive: isActive,
      linkScreen: linkScreen,
      titleLink: titleLink,
      changedImage: changedImage,
    );
  }

  @override
  Future<BannerCard> getBannerById({String id = ''}) async {
    return await bannerDataSource.getBannerById(id: id);
  }
}
