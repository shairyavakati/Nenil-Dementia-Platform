import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/audio_prompt_widget.dart';

class GreetingHeaderWidget extends StatelessWidget {
  final String greetingText;
  final String patientName;
  final String timeOfDay;

  const GreetingHeaderWidget({
    super.key,
    required this.greetingText,
    required this.patientName,
    required this.timeOfDay,
  });

  @override
  Widget build(BuildContext context) {
    final spokenText = '$greetingText Welcome $patientName, let us begin today\'s activities.';

    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceL),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer.withOpacity(0.4),
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greetingText,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceXS),
                Text(
                  patientName.isNotEmpty ? 'Welcome, $patientName' : 'Welcome to your daily journey',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onBackground,
                  ),
                ),
              ],
            ),
          ),
          AudioPromptWidget(textToSpeak: spokenText),
        ],
      ),
    );
  }
}
