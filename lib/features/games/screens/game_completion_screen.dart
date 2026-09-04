import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/audio_prompt_widget.dart';
import '../../../shared/widgets/nenil_button.dart';

class GameCompletionScreen extends StatelessWidget {
  const GameCompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
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
              const AudioPromptWidget(textToSpeak: 'Wonderful Job! You have completed today\'s activity.'),
              const SizedBox(height: AppDimensions.spaceS),
              const Text(
                'You have completed this activity with calm focus.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              NenilButton(
                label: 'Return to Home',
                onPressed: () => context.go('/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
