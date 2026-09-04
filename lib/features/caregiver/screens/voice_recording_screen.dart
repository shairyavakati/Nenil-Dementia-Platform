import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../services/audio_service.dart';
import '../../../services/voice_recording_service.dart';
import '../../../shared/widgets/nenil_button.dart';

class VoiceRecordingScreen extends StatefulWidget {
  const VoiceRecordingScreen({super.key});

  @override
  State<VoiceRecordingScreen> createState() => _VoiceRecordingScreenState();
}

class _VoiceRecordingScreenState extends State<VoiceRecordingScreen> {
  final VoiceRecordingService _recorder = VoiceRecordingService();
  final AudioService _player = AudioService();

  bool _isRecording = false;
  String? _recordedPath;
  bool _isPlaying = false;

  @override
  void dispose() {
    _recorder.dispose();
    _player.dispose();
    super.dispose();
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      final path = await _recorder.stopRecording();
      setState(() {
        _isRecording = false;
        _recordedPath = path;
      });
    } else {
      final success = await _recorder.startRecording('custom_routine_prompt');
      if (success) {
        setState(() => _isRecording = true);
      }
    }
  }

  Future<void> _playback() async {
    if (_recordedPath != null) {
      setState(() => _isPlaying = true);
      await _player.playFilePath(_recordedPath!);
      setState(() => _isPlaying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Voice Prompt'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: AppDimensions.iconMedium),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceXL),
          child: Column(
            children: [
              const Text(
                'Caregiver Voice Guidance',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppDimensions.spaceS),
              const Text(
                'Record a gentle, familiar voice prompt to guide your loved one during daily activities.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              GestureDetector(
                onTap: _toggleRecording,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: _isRecording ? AppColors.emergencyContainer : AppColors.primaryContainer,
                    shape: BoxShape.circle,
                    border: Border.all(color: _isRecording ? AppColors.emergency : AppColors.primary, width: 4),
                  ),
                  child: Icon(
                    _isRecording ? Icons.stop_rounded : Icons.mic_rounded,
                    size: 64,
                    color: _isRecording ? AppColors.emergency : AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceM),
              Text(
                _isRecording ? 'Recording... Tap to stop' : 'Tap microphone to start recording',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _isRecording ? AppColors.emergency : AppColors.primary,
                ),
              ),
              const Spacer(),
              if (_recordedPath != null) ...[
                NenilButton(
                  label: _isPlaying ? 'Playing Audio...' : 'Play Back Recording',
                  icon: Icons.play_arrow_rounded,
                  backgroundColor: AppColors.secondary,
                  onPressed: _playback,
                ),
                const SizedBox(height: AppDimensions.spaceM),
              ],
              NenilButton(
                label: 'Save Recording',
                onPressed: () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
