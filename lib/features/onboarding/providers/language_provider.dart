import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../storage/cache/hive_config.dart';

class LanguageNotifier extends StateNotifier<String> {
  LanguageNotifier() : super(HiveConfig.getPreferredLanguage());

  Future<void> setLanguage(String langCode) async {
    state = langCode;
    await HiveConfig.setPreferredLanguage(langCode);
  }
}

final languageProvider = StateNotifierProvider<LanguageNotifier, String>((ref) {
  return LanguageNotifier();
});
