import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/game_wrapper.dart';
import '../../../shared/widgets/nenil_card.dart';
import '../providers/game_session_provider.dart';

class EmotionMatchGameScreen extends ConsumerStatefulWidget {
  const EmotionMatchGameScreen({super.key});

  @override
  ConsumerState<EmotionMatchGameScreen> createState() => _EmotionMatchGameScreenState();
}

class _EmotionMatchGameScreenState extends ConsumerState<EmotionMatchGameScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  String? _selectedEmotion;

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
  }

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }

  Future<void> _chooseEmotion(String id) async {
    setState(() => _selectedEmotion = id);
    _stopwatch.stop();

    await ref.read(gameSessionProvider.notifier).recordCompletedSession(
      gameType: 'emotion_match',
      durationSeconds: _stopwatch.elapsed.inSeconds,
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) context.push('/game-completion');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GameWrapper(
      title: AppStrings.gameEmotionMatch,
      audioPromptText: 'Emotion Match. Which picture shows a warm, happy smile?',
      onBack: () => context.pop(),
      onSosPressed: () => context.push('/emergency'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Which card shows a Happy Smile?',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
          const SizedBox(height: AppDimensions.spaceS),
          const Text(
            'Tap the picture that feels warm and joyful.',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: AppDimensions.spaceL),
          Expanded(
            child: ListView(
              children: [
                NenilCard(
                  title: 'Warm Happy Smile',
                  subtitle: 'Smiling face with joyful eyes',
                  icon: Icons.sentiment_very_satisfied_rounded,
                  accentColor: _selectedEmotion == 'happy' ? AppColors.success : AppColors.primary,
                  onTap: () => _chooseEmotion('happy'),
                ),
                NenilCard(
                  title: 'Calm & Peaceful',
                  subtitle: 'Restful, peaceful expression',
                  icon: Icons.sentiment_satisfied_rounded,
                  accentColor: _selectedEmotion == 'calm' ? AppColors.success : AppColors.secondary,
                  onTap: () => _chooseEmotion('calm'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
