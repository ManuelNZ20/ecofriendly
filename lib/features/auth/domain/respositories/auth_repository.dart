import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain.dart';

abstract class AuthRepository {
  // verifyOtp()
  Future<UserLogin> login(String email, String password);
  // signUser()
  Future<UserApp> signUp(
      String email, String password, String name, String lastName);
  // signCompany()
  Future<CompanyApp> signUpCompany(
      String email, String password, String nameCompany, String phone);
  // authStatus User
  Future<UserApp> checkAuthStatusUser(String? token);
  // authStatus Company
  Future<CompanyApp> checkAuthStatusCompany(String? token);
  // authStatus
  Future<UserApp> checkAuthStateAccount(String? otp);
  // Otp User
  Future<UserApp> checkUserOtp(String otp1, String otp2, String otp3,
      String otp4, String otp5, String otp6, String email);
  // Otp Company
  Future<CompanyApp> checkCompanyOtp(String otp1, String otp2, String otp3,
      String otp4, String otp5, String otp6, String email);
  // listenToAuthStatus()
  StreamSubscription<AuthState> listenToAuthStatus();
  // isLoggedIn()
  bool isLoggedIn();
  // signOutUser()
  Future<void> signOut();

  Future<Session?> getSessionSupabase();
  Future<UserApp> getDataUser(String id);
  Future<CompanyApp> getDataCompany(String id);
}
