import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/audio_prompt_widget.dart';
import '../../../shared/widgets/celebration_overlay.dart';
import '../../../shared/widgets/nenil_button.dart';

class GameCompletionScreen extends StatefulWidget {
  const GameCompletionScreen({super.key});

  @override
  State<GameCompletionScreen> createState() => _GameCompletionScreenState();
}

class _GameCompletionScreenState extends State<GameCompletionScreen> {
  bool _showCelebration = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.spaceXL),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.sentiment_very_satisfied_rounded, size: AppDimensions.iconHuge * 1.5, color: AppColors.success),
                  const SizedBox(height: AppDimensions.spaceL),
                  const Text(
                    'Wonderful Job!',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.success),
                  ),
                  const SizedBox(height: AppDimensions.spaceM),
                  const AudioPromptWidget(textToSpeak: 'Wonderful Job! You have completed today\'s activity with calm focus.'),
                  const SizedBox(height: AppDimensions.spaceS),
                  const Text(
                    'You have completed this activity with calm focus and care.',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  NenilButton(
                    label: 'Return to Home',
                    icon: Icons.home_rounded,
                    onPressed: () => context.go('/home'),
                  ),
                ],
              ),
            ),
          ),
          if (_showCelebration)
            CelebrationOverlay(
              title: 'Wonderful Job!',
              message: 'You have completed today\'s cognitive activity with calm focus.',
              onDismiss: () {
                setState(() => _showCelebration = false);
              },
            ),
        ],
      ),
    );
  }
}
