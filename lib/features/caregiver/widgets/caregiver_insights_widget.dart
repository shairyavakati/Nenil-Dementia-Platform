import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class CaregiverInsightsWidget extends StatelessWidget {
  final int totalSessions;
  final int totalMinutes;
  final String favoriteGame;

  const CaregiverInsightsWidget({
    super.key,
    required this.totalSessions,
    required this.totalMinutes,
    required this.favoriteGame,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Weekly Patient Engagement',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                title: 'Sessions',
                value: '$totalSessions',
                icon: Icons.check_circle_outline_rounded,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppDimensions.spaceM),
            Expanded(
              child: _MetricCard(
                title: 'Time Engaged',
                value: '$totalMinutes mins',
                icon: Icons.timer_outlined,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceM),
        Card(
          color: AppColors.primaryContainer.withOpacity(0.4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusM)),
          child: const Padding(
            padding: EdgeInsets.all(AppDimensions.spaceM),
            child: Row(
              children: [
                Icon(Icons.lightbulb_rounded, color: AppColors.primary, size: 36),
                SizedBox(width: AppDimensions.spaceM),
                Expanded(
                  child: Text(
                    'Caregiver Advice: Consistent morning routine activities show highest engagement levels.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppDimensions.elevationLow,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          children: [
            Icon(icon, size: AppDimensions.iconMedium, color: color),
            const SizedBox(height: AppDimensions.spaceXS),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            Text(title, style: const TextStyle(fontSize: 14, color: AppColors.outline)),
          ],
        ),
      ),
    );
  }
}
