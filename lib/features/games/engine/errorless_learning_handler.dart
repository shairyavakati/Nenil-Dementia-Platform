import 'package:flutter/foundation.dart';
import '../../../services/tts_service.dart';

/// ErrorlessLearningHandler — Prevents wrong-answer frustration by intercepting incorrect choices and providing warm visual/audio guidance.
class ErrorlessLearningHandler {
  static Future<void> handleSelection({
    required bool isCorrect,
    required String correctOptionTitle,
    required VoidCallback onGuideToCorrect,
  }) async {
    if (isCorrect) {
      debugPrint('[ErrorlessLearning] Target selected correctly.');
      TTSService.speak('Wonderful! That is correct.');
    } else {
      debugPrint('[ErrorlessLearning] Non-target selected. Triggering positive errorless guidance.');
      // Spoken guidance without error sounds or failure screens
      TTSService.speak('Let\'s choose $correctOptionTitle together.');
      onGuideToCorrect();
    }
  }
}
