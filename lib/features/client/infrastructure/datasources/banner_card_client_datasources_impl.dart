import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/datasources/datasources.dart';
import '../../domain/entities/entities.dart';
import '../mappers/mappers.dart';
import '../model/banner_client_model.dart';

class BannerCardClientDatasourceImpl extends BannerCardClientDatasource {
  final SupabaseClient supabase;
  static String nameTable = 'banner';
  BannerCardClientDatasourceImpl({
    SupabaseClient? supabaseClientDatasource,
  }) : supabase = supabaseClientDatasource ?? Supabase.instance.client;
  @override
  Future<List<BannerClient>> getBanners() async {
    try {
      final response =
          await supabase.from(nameTable).select().eq('isActive', true);
      final banners = _responseBanner(response);
      return banners;
    } catch (e) {
      throw Exception('Error loading banners');
    }
  }

  @override
  Future<BannerClient> getBannerById({String id = ''}) async {
    try {
      final response = await supabase.from(nameTable).select().eq(
            'idBanner',
            id,
          );
      final banner = _responseBanner(response).first;
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

  @override
  Stream<List<BannerClient>> getBannersStream() {
    try {
      final response = supabase
          .from(nameTable)
          .stream(primaryKey: ['idBanner']).neq('isActive', false);
      final banners = response.map((event) => _responseBanner(event));
      return banners;
    } catch (e) {
      throw Exception(e);
    }
  }

  List<BannerClient> _responseBanner(List<Map<String, dynamic>> response) {
    final banners = response
        .map((banner) => BannerClientMapper.toBannerCardEntity(
            BannerClientModel.fromJson(banner)))
        .toList();
    return banners;
  }
}
