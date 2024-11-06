import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../auth/domain/domain.dart';
import '../../../auth/infrastructure/infrastructure.dart';
import '../../domain/datasources/datasources.dart';

class UserDatasourceImpl extends UserClientDatasource {
  final SupabaseClient supabaseClient;
  static String nameTable = 'user_app';
  UserDatasourceImpl({
    SupabaseClient? supabaseClientDatasource,
  }) : supabaseClient = supabaseClientDatasource ?? Supabase.instance.client;

  @override
  Future<UserApp> getUserByEmail(String email) async {
    try {
      final response =
          await supabaseClient.from(nameTable).select().eq('email', email);
      final user = _responseUser(response).first;
      return user;
    } on AuthException catch (e) {
      if (e.statusCode == '404') {
        throw Exception('Product Not Found');
      }
      throw Exception(e);
    } catch (e) {
      throw Exception('Error loading user, product: $e');
    }
  }

  @override
  Future<UserApp> getUserByUserName(String username) async {
    try {
      final response = await supabaseClient
          .from(nameTable)
          .select()
          .eq('username', username);
      final user = _responseUser(response).first;
      return user;
    } on AuthException catch (e) {
      if (e.statusCode == '404') {
        throw Exception('Product Not Found');
      }
      throw Exception(e);
    } catch (e) {
      throw Exception('Error loading product, product: $e');
    }
  }

  @override
  Future<List<UserApp>> getUsers() async {
    try {
      final response = await supabaseClient.from(nameTable).select();
      final usersProfile = _responseUser(response);
      return usersProfile;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserApp> updateUser({
    String id = '',
    String email = '',
    String name = '',
    String lastName = '',
    String phone = '',
    String gender = '',
    String address = '',
    String referenceAddress = '',
    bool stateAccount = true,
    int age = 0,
  }) async {
    try {
      final response = await supabaseClient
          .from(nameTable)
          .update({
            'name': name,
            'last_name': lastName,
            'phone': phone,
            'gender': gender,
            'address': address,
            'reference_address': referenceAddress,
            'state_account': stateAccount,
            'age': age,
          })
          .eq('id', id)
          .select();
      final user = _responseUser(response).first;
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> updateLocationUser({
    String email = '',
    double longitude = 0,
    double latitude = 0,
  }) async {
    try {
      final response = await supabaseClient
          .from(nameTable)
          .update({
            'longitude': longitude,
            'latitude': latitude,
          })
          .eq('email', email)
          .select();
      return response.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  List<UserApp> _responseUser(List<Map<String, dynamic>> response) {
    final usersProfiles = response
        .map((u) => UserAppMapper.userJsonToEntity(UserModel.fromJson(u)))
        .toList();
    return usersProfiles;
  }
}
