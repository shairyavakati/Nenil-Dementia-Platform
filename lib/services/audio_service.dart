import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

/// AudioService — Handles audio playback for music memory and caregiver voice prompts.
class AudioService {
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  Future<void> playAsset(String assetPath) async {
    try {
      await _player.setAsset(assetPath);
      await _player.play();
    } catch (e) {
      debugPrint('[AudioService] Playback error for $assetPath: $e');
    }
  }

  Future<void> playFilePath(String filePath) async {
    try {
      await _player.setFilePath(filePath);
      await _player.play();
    } catch (e) {
      debugPrint('[AudioService] Playback error for $filePath: $e');
    }
  }

  Future<void> stop() async {
    await _player.stop();
  }

  void dispose() {
    _player.dispose();
  }
}
