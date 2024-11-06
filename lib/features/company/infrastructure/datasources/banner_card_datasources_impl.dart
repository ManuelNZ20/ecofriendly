import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/shared/infrastructure/service/cloudinary_init.service.riverpod.dart';
import '../../../../core/shared/shared.dart';
import '../../domain/domain.dart';
import '../mapper/banner_card_mapper.dart';
import '../models/banner_card.module.dart';

class BannerCardDatasourceImpl extends BannerCardDatasource {
  final SupabaseClient supabase;
  static String nameTable = 'banner';
  final keyValueStorage = KeyValueStorageImpl();
  BannerCardDatasourceImpl({
    SupabaseClient? supabaseClientDatasource,
  }) : supabase = supabaseClientDatasource ?? Supabase.instance.client;

  @override
  Future<BannerCard> createdBanner({
    required String title,
    required String subTitle,
    required String imgUrl,
    required bool isActive,
    required String linkScreen,
    required String titleLink,
  }) async {
    final imgPath =
        await CloudinaryInit.uploadImage(imgUrl, UploadPreset.banner);
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final response = await supabase.from(nameTable).insert(
        [
          {
            'title': title,
            'subTitle': subTitle,
            'imgUrl': imgPath,
            'expired_at': DateTime.now().toIso8601String(),
            'linkScreen': linkScreen,
            'titleLink': titleLink,
            'isActive': isActive,
          }
        ],
      ).select();
      final idCompany = await keyValueStorage.getValue<String>('id');
      final banner = response
          .map((banner) => BannerCardMapper.toBannerCardEntity(
              BannerCardModel.fromJson(banner)))
          .toList()
          .first;
      await supabase.from('banners_company').insert([
        {
          'id_banner': banner.idBanner,
          'id_company': idCompany,
        }
      ]);
      return banner;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteBanner({String id = ''}) {
    throw UnimplementedError();
  }

  @override
  Future<List<BannerCard>> getBanners() async {
    try {
      final response = await supabase.from(nameTable).select();
      final banners = response
          .map((banner) => BannerCardMapper.toBannerCardEntity(
              BannerCardModel.fromJson(banner)))
          .toList();
      return banners;
    } catch (e) {
      throw Exception('Error loading banners');
    }
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
    String imgPath = '';
    if (changedImage) {
      imgPath = await CloudinaryInit.uploadImage(imgUrl, UploadPreset.banner);
    } else {
      imgPath = imgUrl;
    }
    await Future.delayed(const Duration(milliseconds: 500));
    final banner = await updateBanner(
      id: id,
      title: title,
      subTitle: subTitle,
      imgUrl: imgPath,
      isActive: isActive,
      linkScreen: linkScreen,
      titleLink: titleLink,
    );
    return banner;
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
    try {
      final response = await supabase
          .from(nameTable)
          .update(
            {
              'title': title,
              'subTitle': subTitle,
              'imgUrl': imgUrl,
              'expired_at': DateTime.now().toIso8601String(),
              'linkScreen': linkScreen,
              'titleLink': titleLink,
              'isActive': isActive,
            },
          )
          .eq('idBanner', id)
          .select();
      final banner = response
          .map((banner) => BannerCardMapper.toBannerCardEntity(
              BannerCardModel.fromJson(banner)))
          .toList()
          .first;
      return banner;
    } catch (e) {
      print('Error: ${e.toString()}');
      throw Exception(e);
    }
  }

  @override
  Future<BannerCard> getBannerById({String id = ''}) async {
    try {
      final response = await supabase.from(nameTable).select().eq(
            'idBanner',
            id,
          );
      final banner = response
          .map((banner) => BannerCardMapper.toBannerCardEntity(
              BannerCardModel.fromJson(banner)))
          .toList()
          .first;
      return banner;
    } on AuthException catch (e) {
      if (e.statusCode == '404') {
        throw Exception('Banner Not Found');
      }
      throw Exception(e);
    } catch (e) {
      throw Exception('Error loading banner, error: $e');
    }
  }
}
