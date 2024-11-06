import 'package:supabase_flutter/supabase_flutter.dart';

import '../core.dart';

class SupabaseInit {
  static initSupabase() async {
    await Supabase.initialize(
      url: Environment.urlBase,
      anonKey: Environment.anonKey,
      authOptions: const FlutterAuthClientOptions(
        autoRefreshToken: true,
        authFlowType: AuthFlowType.pkce,
      ),
    );
  }
}
