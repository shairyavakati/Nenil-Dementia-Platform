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

  static Box? get settingsBox => Hive.isBoxOpen(settingsBoxName) ? Hive.box(settingsBoxName) : null;

  static String getPreferredLanguage() {
    if (!Hive.isBoxOpen(settingsBoxName)) return 'en';
    return Hive.box(settingsBoxName).get(keyLanguage, defaultValue: 'en') as String? ?? 'en';
  }

  static Future<void> setPreferredLanguage(String langCode) async {
    if (!Hive.isBoxOpen(settingsBoxName)) return;
    await Hive.box(settingsBoxName).put(keyLanguage, langCode);
  }

  static bool isOnboarded() {
    if (!Hive.isBoxOpen(settingsBoxName)) return false;
    return Hive.box(settingsBoxName).get(keyIsOnboarded, defaultValue: false) as bool? ?? false;
  }

  static Future<void> setOnboarded(bool value) async {
    if (!Hive.isBoxOpen(settingsBoxName)) return;
    await Hive.box(settingsBoxName).put(keyIsOnboarded, value);
  }

  static String? getCaregiverPin() {
    if (!Hive.isBoxOpen(settingsBoxName)) return null;
    return Hive.box(settingsBoxName).get(keyCaregiverPin) as String?;
  }

  static Future<void> setCaregiverPin(String pin) async {
    if (!Hive.isBoxOpen(settingsBoxName)) return;
    await Hive.box(settingsBoxName).put(keyCaregiverPin, pin);
  }
}
