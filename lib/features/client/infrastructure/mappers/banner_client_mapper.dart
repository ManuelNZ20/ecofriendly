import '../../domain/entities/entities.dart';
import '../model/model.dart';

class BannerClientMapper {
  static BannerClient toBannerCardEntity(BannerClientModel banner) =>
      BannerClient(
        idBanner: banner.idBanner,
        title: banner.title,
        subTitle: banner.subTitle,
        imgUrl: banner.imgUrl,
        createdAt: banner.createdAt,
        expiredAt: banner.expiredAt,
        linkScreen: banner.linkScreen,
        isActive: banner.isActive,
        titleLink: banner.titleLink,
      );
}
