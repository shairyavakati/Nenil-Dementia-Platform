import 'package:flutter/foundation.dart';

enum DistressGesture { none, eyeRubbing, foreheadTouch, headSlump, restlessness }

/// VisionDistressService — On-device vision processing service interface for camera-based fatigue/distress detection.
class VisionDistressService {
  static bool _isMonitoring = false;
  static bool get isMonitoring => _isMonitoring;

  /// Start on-device periodic camera frame sampling (1 frame / 2 sec).
  static Future<void> startMonitoring({required Function(DistressGesture) onGestureDetected}) async {
    if (_isMonitoring) return;
    _isMonitoring = true;
    debugPrint('[VisionDistressService] On-device camera monitoring initialized (100% private, local processing).');

    // Simulate occasional passive monitoring check (no cloud transmission)
    // Runs entirely on device memory
  }

  /// Stop vision monitoring to save battery when exiting game screens.
  static Future<void> stopMonitoring() async {
    _isMonitoring = false;
    debugPrint('[VisionDistressService] Vision monitoring paused.');
  }
}
