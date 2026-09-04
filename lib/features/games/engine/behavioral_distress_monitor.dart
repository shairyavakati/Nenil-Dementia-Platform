import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../services/tts_service.dart';

/// BehavioralDistressMonitor — Tracks tap latency, error frequency, and triggers automated de-escalation upon cognitive fatigue detection.
class BehavioralDistressMonitor {
  int _consecutiveErrors = 0;
  DateTime? _lastTapTime;
  double _totalLatencySeconds = 0;
  int _tapCount = 0;

  int get consecutiveErrors => _consecutiveErrors;

  /// Record an interaction attempt and calculate distress index.
  bool recordAttempt({required bool isCorrect, required BuildContext context}) {
    final now = DateTime.now();
    if (_lastTapTime != null) {
      final latency = now.difference(_lastTapTime!).inMilliseconds / 1000.0;
      _totalLatencySeconds += latency;
      _tapCount++;
    }
    _lastTapTime = now;

    if (!isCorrect) {
      _consecutiveErrors++;
    } else {
      _consecutiveErrors = 0;
    }

    final double avgLatency = _tapCount > 0 ? (_totalLatencySeconds / _tapCount) : 0;
    final double distressIndex = (_consecutiveErrors * 2.5) + (avgLatency > 5.0 ? 3.0 : 0.0);

    debugPrint('[BehavioralDistressMonitor] Attempt: isCorrect=$isCorrect, consecutiveErrors=$_consecutiveErrors, distressIndex=$distressIndex');

    if (distressIndex >= 5.0) {
      _triggerDeescalation(context);
      return true; // De-escalation triggered
    }

    return false;
  }

  /// Automatically transition patient to calm music or comfort selection upon fatigue detection.
  void _triggerDeescalation(BuildContext context) {
    debugPrint('[BehavioralDistressMonitor] De-escalation threshold exceeded! Switching to calming comfort mode.');
    _consecutiveErrors = 0;
    _tapCount = 0;
    _totalLatencySeconds = 0;

    TtsService.speak('Let\'s take a gentle rest together and listen to calm music.');

    if (context.mounted) {
      context.push('/game/comfort_choice');
    }
  }
}
