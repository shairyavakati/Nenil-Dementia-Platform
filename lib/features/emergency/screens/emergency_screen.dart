import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/audio_prompt_widget.dart';
import '../../../shared/widgets/nenil_button.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.emergencyContainer,
      appBar: AppBar(
        backgroundColor: AppColors.emergencyContainer,
        title: const Text(AppStrings.titleEmergency, style: TextStyle(color: AppColors.emergency)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: AppDimensions.iconMedium, color: AppColors.emergency),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceXL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emergency_rounded, size: AppDimensions.iconHuge * 1.5, color: AppColors.emergency),
              const SizedBox(height: AppDimensions.spaceL),
              const Text(
                'Help is on the way!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.emergency),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.spaceM),
              const AudioPromptWidget(textToSpeak: 'Connecting emergency call to primary caregiver and sharing your current location.'),
              const SizedBox(height: AppDimensions.spaceL),
              const Text(
                'Calling Primary Caregiver:\n+91 98765 43210',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              NenilButton(
                label: 'Cancel Emergency',
                backgroundColor: AppColors.surface,
                foregroundColor: AppColors.onBackground,
                onPressed: () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
