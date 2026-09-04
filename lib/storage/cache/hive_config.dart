import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// HiveConfig — Initializes Hive key-value cache boxes for offline settings.
class HiveConfig {
  static const String settingsBoxName = 'app_settings';
  static const String keyLanguage = 'preferred_language';
  static const String keyIsOnboarded = 'is_onboarded';
  static const String keyCaregiverPin = 'caregiver_pin';

  static Future<void> initialize() async {
    try {
      await Hive.initFlutter();
      await Hive.openBox(settingsBoxName);
      debugPrint('[HiveConfig] Hive initialized successfully.');
    } catch (e) {
      debugPrint('[HiveConfig] Error initializing Hive: $e');
    }
  }

  static Box get settingsBox => Hive.box(settingsBoxName);

  static String getPreferredLanguage() {
    return settingsBox.get(keyLanguage, defaultValue: 'en') as String;
  }

  static Future<void> setPreferredLanguage(String langCode) async {
    await settingsBox.put(keyLanguage, langCode);
  }

  static bool isOnboarded() {
    return settingsBox.get(keyIsOnboarded, defaultValue: false) as bool;
  }

  static Future<void> setOnboarded(bool value) async {
    await settingsBox.put(keyIsOnboarded, value);
  }
}
