import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrlOpenApp(Uri uri, bool inApp) async {
  try {
    if (await canLaunchUrl(uri)) {
      if (inApp) {
        await launchUrl(
          uri,
          mode: LaunchMode.inAppBrowserView,
        );
      } else {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }
    }
  } catch (e) {
    print(e.toString());
  }
}
