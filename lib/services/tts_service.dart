import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// TtsService — Spoken text-to-speech guidance service for voice-first interactions.
/// Exposes a static [speak] convenience method for fire-and-forget TTS from any screen.
class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  TtsService._internal();

  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;

  Future<void> initialize({String languageCode = 'en-IN'}) async {
    try {
      await _flutterTts.setLanguage(languageCode);
      await _flutterTts.setSpeechRate(0.4); // Slower speech rate for elderly patients
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);
      _isInitialized = true;
      debugPrint('[TtsService] TTS initialized with language $languageCode');
    } catch (e) {
      debugPrint('[TtsService] TTS initialization error: $e');
    }
  }

  Future<void> speakText(String text) async {
    if (!_isInitialized) await initialize();
    try {
      await _flutterTts.speak(text);
    } catch (e) {
      debugPrint('[TtsService] Speech error: $e');
    }
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }

  /// Static convenience method — fire-and-forget TTS from any widget or service.
  static void speak(String text) {
    _instance.speakText(text).catchError((e) {
      debugPrint('[TtsService] Static speak error: $e');
    });
  }
}
