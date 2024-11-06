import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../auth/domain/domain.dart';
import '../../domain/datasources/datasources.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/datasources.dart';

class UserClientRepositoryImpl extends UserClientRepository {
  final UserClientDatasource userDatasource;
  final SupabaseClient supabaseClient;

  UserClientRepositoryImpl({
    UserClientDatasource? userDatasource,
    required this.supabaseClient,
  }) : userDatasource = userDatasource ??
            UserDatasourceImpl(
              supabaseClientDatasource: supabaseClient,
            );

  @override
  Future<UserApp> getUserByEmail(String email) async {
    final user = await userDatasource.getUserByEmail(email);
    return user;
  }

  @override
  Future<UserApp> getUserByUserName(String username) async {
    final user = await userDatasource.getUserByUserName(username);
    return user;
  }

  @override
  Future<List<UserApp>> getUsers() async {
    return await userDatasource.getUsers();
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
      return await userDatasource.updateUser(
        id: id,
        email: email,
        name: name,
        lastName: lastName,
        phone: phone,
        gender: gender,
        address: address,
        referenceAddress: referenceAddress,
        stateAccount: stateAccount,
        age: age,
      );
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
    return await userDatasource.updateLocationUser(
      email: email,
      longitude: longitude,
      latitude: latitude,
    );
  }
}
