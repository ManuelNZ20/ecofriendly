import '../entities/banner_card.dart';

abstract class BannerCardRepository {
  Future<List<BannerCard>> getBanners();
  Future<BannerCard> getBannerById({String id});

  Future<void> deleteBanner({String id});

  Future<BannerCard> updateBanner({
    required String id,
    required String title,
    required String subTitle,
    required String imgUrl,
    required bool isActive,
    required String linkScreen,
    required String titleLink,
  });

  Future<BannerCard> updateBannerCheck({
    required String id,
    required String title,
    required String subTitle,
    required String imgUrl,
    required bool isActive,
    required String linkScreen,
    required String titleLink,
    required bool changedImage,
  });
  Future<BannerCard> createdBanner({
    required String title,
    required String subTitle,
    required String imgUrl,
    required bool isActive,
    required String linkScreen,
    required String titleLink,
  });
}
