import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/core.dart';
import '../../../auth/infrastructure/infrastructure.dart';
import '../../domain/domain.dart';

class EmailDatasourceImpl implements EmailDatasources {
  final dio = Dio();
  @override
  Future<void> sendEmailToken({String? email, String? token}) async {
    final headers = {
      'Authorization': 'Bearer ${Environment.apiKeyResend}',
      'Content-Type': 'application/json',
    };
    final data = {
      'from': 'Ecofriendly <${Environment.emailSender}>',
      'to': [email],
      'subject': 'Verificación de Token',
      'html': '''
              <h2>Hola EcoAlido!</h2>
              <p>Para ultimar detalles con tu registro se te ha enviado un token de acceso</p>
              <h3><b>Token: </b>$token</h3>
              ''',
    };
    try {
      await dio.post(
        'https://api.resend.com/emails',
        options: Options(
          headers: headers,
        ),
        data: data,
      );
    } on EmailErrors catch (e) {
      throw EmailErrors(
          'No se logro enviar el correo electronico ${e.toString()}');
    }
  }

  @override
  Future<void> openGmail(
      {required String email, required String? subject, String? body}) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query:
          'subject=${Uri.encodeComponent(subject ?? '')}&body=${Uri.encodeComponent(body ?? '')}',
    );
    try {
      print(emailUri.toString());
      // Verificamos si se puede abrir la URL
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        print('No se puede abrir el email en este dispositivo');
      }
    } catch (e) {
      print('Error al lanzar URL del email: $e');
    }
  }
}
