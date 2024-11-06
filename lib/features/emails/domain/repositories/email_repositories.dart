abstract class EmailRepositories {
  Future<void> sendEmailToken({String email, String token});

  Future<void> openGmail(
      {required String email, required String? subject, String? body});
}
