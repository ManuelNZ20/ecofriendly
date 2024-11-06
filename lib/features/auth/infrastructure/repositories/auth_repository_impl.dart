import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';
import '../datasources/auth_datasource_impl.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource authDataSource;

  AuthRepositoryImpl({
    AuthDatasource? authDatasource,
  }) : authDataSource = authDatasource ?? AuthDatasourceImpl();

  @override
  Future<UserApp> checkAuthStateAccount(String? otp) async {
    return await authDataSource.checkAuthStateAccount(otp);
  }

  @override
  Future<UserApp> checkAuthStatusUser(String? token) async {
    return await authDataSource.checkAuthStatusUser(token);
  }

  @override
  Future<CompanyApp> checkAuthStatusCompany(String? token) async {
    return await authDataSource.checkAuthStatusCompany(token);
  }

  @override
  Future<Session?> getSessionSupabase() async {
    return await authDataSource.getSessionSupabase();
  }

  @override
  bool isLoggedIn() {
    return authDataSource.isLoggedIn();
  }

  @override
  StreamSubscription<AuthState> listenToAuthStatus() {
    return authDataSource.listenToAuthStatus();
  }

  @override
  Future<UserLogin> login(String email, String password) async {
    return await authDataSource.login(email, password);
  }

  @override
  Future<void> signOut() async {
    return await authDataSource.signOut();
  }

  @override
  Future<UserApp> signUp(
      String email, String password, String name, String lastName) async {
    return await authDataSource.signUp(email, password, name, lastName);
  }

  @override
  Future<UserApp> checkUserOtp(String otp1, String otp2, String otp3,
      String otp4, String otp5, String otp6, String email) async {
    return await authDataSource.checkUserOtp(
        otp1, otp2, otp3, otp4, otp5, otp6, email);
  }

  @override
  Future<CompanyApp> signUpCompany(
      String email, String password, String nameCompany, String phone) async {
    return await authDataSource.signUpCompany(
        email, password, nameCompany, phone);
  }

  @override
  Future<CompanyApp> checkCompanyOtp(String otp1, String otp2, String otp3,
      String otp4, String otp5, String otp6, String email) async {
    return await authDataSource.checkCompanyOtp(
        otp1, otp2, otp3, otp4, otp5, otp6, email);
  }

  @override
  Future<UserApp> getDataUser(String id) async {
    return await authDataSource.getDataUser(id);
  }

  @override
  Future<CompanyApp> getDataCompany(String id) async {
    return await authDataSource.getDataCompany(id);
  }
}
