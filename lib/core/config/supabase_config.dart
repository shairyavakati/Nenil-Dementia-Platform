import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// SupabaseConfig — Initializes Supabase client with graceful fallback for offline mode.
class SupabaseConfig {
  static const String defaultUrl = 'https://placeholder.supabase.co';
  static const String defaultAnonKey = 'placeholder-anon-key';

  static bool _initialized = false;
  static bool get isInitialized => _initialized;

  static Future<void> initialize() async {
    try {
      const url = String.fromEnvironment('SUPABASE_URL', defaultValue: defaultUrl);
      const anonKey = String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: defaultAnonKey);

      if (url == defaultUrl) {
        debugPrint('[SupabaseConfig] Running in Offline-First mode (no remote Supabase URL provided).');
        return;
      }

      await Supabase.initialize(
        url: url,
        anonKey: anonKey,
        debug: kDebugMode,
      );
      _initialized = true;
      debugPrint('[SupabaseConfig] Supabase initialized successfully.');
    } catch (e) {
      debugPrint('[SupabaseConfig] Offline mode active — Supabase initialization skipped: $e');
    }
  }

  static SupabaseClient get client {
    if (!_initialized) {
      throw StateError('Supabase client accessed while offline or uninitialized.');
    }
    return Supabase.instance.client;
  }
}
