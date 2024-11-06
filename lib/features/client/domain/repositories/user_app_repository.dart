import '../../../auth/domain/domain.dart';

abstract class UserClientRepository {
  Future<UserApp> updateUser({
    String id,
    String email,
    String name,
    String lastName,
    String phone,
    String gender,
    String address,
    String referenceAddress,
    bool stateAccount,
    int age,
  });

  Future<bool> updateLocationUser({
    String email,
    double longitude,
    double latitude,
  });

  Future<UserApp> getUserByEmail(String email);

  Future<UserApp> getUserByUserName(String username);

  Future<List<UserApp>> getUsers();
}
