import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../services/audio_service.dart';
import '../../../shared/widgets/game_wrapper.dart';
import '../../../shared/widgets/nenil_button.dart';
import '../providers/game_session_provider.dart';

class MusicMemoryGameScreen extends ConsumerStatefulWidget {
  const MusicMemoryGameScreen({super.key});

  @override
  ConsumerState<MusicMemoryGameScreen> createState() => _MusicMemoryGameScreenState();
}

class _MusicMemoryGameScreenState extends ConsumerState<MusicMemoryGameScreen> {
  final AudioService _audioService = AudioService();
  final Stopwatch _stopwatch = Stopwatch();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
  }

  @override
  void dispose() {
    _audioService.dispose();
    _stopwatch.stop();
    super.dispose();
  }

  void _togglePlay() {
    setState(() => _isPlaying = !_isPlaying);
    // In production, plays regional folk asset: AppAssets.promptWelcomeAs
  }

  Future<void> _completeMusicMemory() async {
    _stopwatch.stop();
    await ref.read(gameSessionProvider.notifier).recordCompletedSession(
      gameType: 'music_memory',
      durationSeconds: _stopwatch.elapsed.inSeconds,
    );
    if (mounted) context.push('/game-completion');
  }

  @override
  Widget build(BuildContext context) {
    return GameWrapper(
      title: AppStrings.gameMusicMemory,
      audioPromptText: 'Music Memory Journey. Listen to familiar folk songs and regional melodies.',
      onBack: () => context.pop(),
      onSosPressed: () => context.push('/emergency'),
      child: Column(
        children: [
          Expanded(
            child: Card(
              elevation: AppDimensions.elevationMedium,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusL)),
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.spaceXL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryContainer,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.secondary, width: 3),
                      ),
                      child: Icon(
                        _isPlaying ? Icons.graphic_eq_rounded : Icons.music_note_rounded,
                        size: 72,
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spaceL),
                    const Text(
                      'Traditional Folk Melody',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.secondary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimensions.spaceS),
                    const Text(
                      'Assamese & Regional Memory Melodies',
                      style: TextStyle(fontSize: 18, color: AppColors.onBackground),
                    ),
                    const SizedBox(height: AppDimensions.spaceXL),
                    IconButton(
                      iconSize: 72,
                      icon: Icon(
                        _isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                        color: AppColors.primary,
                      ),
                      onPressed: _togglePlay,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceL),
          NenilButton(
            label: 'I Remember This Song ❤️',
            icon: Icons.favorite_rounded,
            backgroundColor: AppColors.secondary,
            onPressed: _completeMusicMemory,
          ),
        ],
      ),
    );
  }
}
