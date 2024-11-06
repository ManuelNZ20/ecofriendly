import '../../domain/domain.dart';
import '../models/user_app.module.dart';

class UserAppMapper {
  static UserApp userJsonToEntity(UserModel user) => UserApp(
        id: user.id,
        email: user.email,
        password: user.password,
        accountCreated: user.accountCreated,
        name: user.name,
        lastName: user.lastName,
        age: user.age,
        phone: user.phone,
        idDisctrict: user.idDisctrict,
        gender: user.gender,
        address: user.address,
        referenceAddress: user.referenceAddress,
        accountStatus: user.accountStatus,
        idTypeUser: user.idTypeUser,
        tokenAuth: user.tokenAuth,
        tokenStateAccount: user.tokenStateAccount,
      );
}
