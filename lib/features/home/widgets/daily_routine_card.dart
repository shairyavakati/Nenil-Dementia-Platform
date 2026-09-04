import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../models/routine_model.dart';
import '../../../shared/widgets/audio_prompt_widget.dart';

class DailyRoutineCard extends StatelessWidget {
  final RoutineModel routine;
  final VoidCallback onToggle;

  const DailyRoutineCard({
    super.key,
    required this.routine,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppDimensions.elevationLow,
      margin: const EdgeInsets.symmetric(vertical: AppDimensions.spaceS),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        side: BorderSide(
          color: routine.isCompleted ? AppColors.success : AppColors.surfaceVariant,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceM),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  routine.isCompleted ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                  size: AppDimensions.iconLarge,
                  color: routine.isCompleted ? AppColors.success : AppColors.outline,
                ),
                onPressed: onToggle,
              ),
              const SizedBox(width: AppDimensions.spaceM),
              Expanded(
                child: Text(
                  routine.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: routine.isCompleted ? TextDecoration.lineThrough : null,
                    color: routine.isCompleted ? AppColors.onBackground.withOpacity(0.6) : AppColors.onBackground,
                  ),
                ),
              ),
              AudioPromptWidget(textToSpeak: 'Routine item: ${routine.title}'),
            ],
          ),
        ),
      ),
    );
  }
}
