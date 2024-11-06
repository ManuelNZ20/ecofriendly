import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(
      fileName: fileName,
    );
  }

  // Supabase
  static String get fileName {
    if (kReleaseMode) return '.env.prod';
    return '.env.dev';
  }

  static String get urlBase =>
      dotenv.env['SUPABASE_URL'] ?? 'Not SUPABASE_URL especified';

  static String get anonKey =>
      dotenv.env['SUPABASE_ANON_KEY'] ?? 'Not SUPABASE_ANON_KEY especified';

  // RESEND
  static String get apiKeyResend =>
      dotenv.env['API_KEY_RESEND'] ?? 'Not API_KEY_RESEND especified';

  static String get emailSender =>
      dotenv.env['EMAIL_SENDER'] ?? 'Not EMAIL_SENDER especified';

  // CLOUDINARY
  static String get cloudName =>
      dotenv.env['CLOUD_NAME'] ?? 'Not CLOUD_NAME especified';

  static String get uploadPresetBanner =>
      dotenv.env['UPLOAD_PRESET_BANNER'] ??
      'Not UPLOAD_PRESET_BANNER especified';

  static String get uploadPresetProduct =>
      dotenv.env['UPLOAD_PRESET_PRODUCT'] ??
      'Not UPLOAD_PRESET_PRODUCT especified';

  static String get uploadPresetCategory =>
      dotenv.env['UPLOAD_PRESET_CATEGORY'] ??
      'Not UPLOAD_PRESET_PRODUCT especified';
}
