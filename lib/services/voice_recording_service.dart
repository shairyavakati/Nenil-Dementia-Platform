import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'permission_service.dart';

/// VoiceRecordingService — Manages audio recording for caregiver personalized voice prompts.
class VoiceRecordingService {
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  String? _lastRecordedFilePath;

  bool get isRecording => _isRecording;
  String? get lastRecordedFilePath => _lastRecordedFilePath;

  Future<bool> startRecording(String fileName) async {
    try {
      final hasPermission = await PermissionService.requestMicrophonePermission();
      if (!hasPermission) {
        debugPrint('[VoiceRecordingService] Microphone permission denied.');
        return false;
      }

      final directory = await getApplicationDocumentsDirectory();
      final audioDir = Directory('${directory.path}/audio_prompts');
      if (!await audioDir.exists()) {
        await audioDir.create(recursive: true);
      }

      final filePath = '${audioDir.path}/$fileName.m4a';

      await _audioRecorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: filePath,
      );

      _isRecording = true;
      _lastRecordedFilePath = filePath;
      debugPrint('[VoiceRecordingService] Started recording at $filePath');
      return true;
    } catch (e) {
      debugPrint('[VoiceRecordingService] Start recording error: $e');
      return false;
    }
  }

  Future<String?> stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      _isRecording = false;
      debugPrint('[VoiceRecordingService] Stopped recording. Output: $path');
      return path;
    } catch (e) {
      debugPrint('[VoiceRecordingService] Stop recording error: $e');
      _isRecording = false;
      return null;
    }
  }

  void dispose() {
    _audioRecorder.dispose();
  }
}
