import '../../domain/domain.dart';

class EmailRepositoryImpl implements EmailRepositories {
  final EmailDatasources emailDatasources;

  EmailRepositoryImpl({required this.emailDatasources});

  @override
  Future<void> sendEmailToken({String? email, String? token}) async {
    await emailDatasources.sendEmailToken(
      email: email ?? '',
      token: token ?? '',
    );
  }

  @override
  Future<void> openGmail(
      {required String email, required String? subject, String? body}) async {
    await openGmail(
      email: email,
      subject: subject,
      body: body,
    );
  }
}
