import 'package:flutter/foundation.dart';

/// SpacedRetrievalEngine — Clinical spaced retrieval engine tracking recall intervals for practical skills.
class SpacedRetrievalEngine {
  static const List<Duration> retrievalIntervals = [
    Duration(minutes: 1),
    Duration(minutes: 5),
    Duration(minutes: 15),
    Duration(hours: 1),
    Duration(hours: 24),
  ];

  /// Compute next interval duration based on current level and recall success.
  static Duration getNextInterval({required int currentLevel, required bool wasSuccessful}) {
    if (!wasSuccessful) {
      // Return to baseline 1-minute interval upon recall difficulty
      debugPrint('[SpacedRetrievalEngine] Recall unsuccessful. Resetting to 1-minute interval.');
      return retrievalIntervals.first;
    }

    final nextIndex = (currentLevel + 1).clamp(0, retrievalIntervals.length - 1);
    final nextInterval = retrievalIntervals[nextIndex];
    debugPrint('[SpacedRetrievalEngine] Recall successful! Expanding interval to ${nextInterval.inMinutes} mins.');
    return nextInterval;
  }
}
