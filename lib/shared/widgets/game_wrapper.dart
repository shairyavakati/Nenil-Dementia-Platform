import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import 'audio_prompt_widget.dart';
import 'celebration_overlay.dart';

/// GameWrapper — Calm container scaffold for game modules with top navigation & floating SOS button.
class GameWrapper extends StatelessWidget {
  final String title;
  final String audioPromptText;
  final Widget child;
  final VoidCallback onBack;
  final VoidCallback? onSosPressed;
  final bool showCelebration;
  final VoidCallback? onCelebrationDismissed;
  final String celebrationTitle;
  final String celebrationMessage;

  const GameWrapper({
    super.key,
    required this.title,
    required this.audioPromptText,
    required this.child,
    required this.onBack,
    this.onSosPressed,
    this.showCelebration = false,
    this.onCelebrationDismissed,
    this.celebrationTitle = 'Wonderful Job!',
    this.celebrationMessage = 'You completed the activity with great care and attention.',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: AppDimensions.iconMedium),
          onPressed: onBack,
        ),
        title: Text(title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppDimensions.spaceM),
            child: AudioPromptWidget(textToSpeak: audioPromptText),
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.spaceL),
              child: child,
            ),
          ),
          if (showCelebration)
            CelebrationOverlay(
              title: celebrationTitle,
              message: celebrationMessage,
              onDismiss: () {
                if (onCelebrationDismissed != null) {
                  onCelebrationDismissed!();
                }
              },
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onSosPressed,
        backgroundColor: AppColors.emergency,
        foregroundColor: AppColors.onEmergency,
        icon: const Icon(Icons.emergency, size: AppDimensions.iconMedium),
        label: const Text(
          'SOS',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

