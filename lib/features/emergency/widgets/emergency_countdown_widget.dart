import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/nenil_button.dart';

class EmergencyCountdownWidget extends StatelessWidget {
  final int countdownSeconds;
  final VoidCallback onCancel;

  const EmergencyCountdownWidget({
    super.key,
    required this.countdownSeconds,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 140,
              height: 140,
              child: CircularProgressIndicator(
                value: countdownSeconds / 5.0,
                strokeWidth: 8,
                backgroundColor: AppColors.surface,
                color: AppColors.emergency,
              ),
            ),
            Text(
              '$countdownSeconds',
              style: const TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.bold,
                color: AppColors.emergency,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceL),
        const Text(
          'Emergency SOS Triggered',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.emergency),
        ),
        const SizedBox(height: AppDimensions.spaceS),
        const Text(
          'Connecting call in seconds. Tap Cancel below if triggered by mistake.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
        NenilButton(
          label: 'CANCEL SOS CALL',
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.onBackground,
          icon: Icons.cancel_rounded,
          onPressed: onCancel,
        ),
      ],
    );
  }
}
