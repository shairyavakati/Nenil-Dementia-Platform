import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/nenil_button.dart';
import '../../../shared/widgets/nenil_card.dart';
import '../providers/patient_profile_provider.dart';

class StageSelectionScreen extends ConsumerWidget {
  const StageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(patientProfileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.titleStageSelection)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Dementia Stage',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppDimensions.spaceS),
              const Text(
                'This adapts game choice complexity, audio guidance, and session targets.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: AppDimensions.spaceL),
              NenilCard(
                title: 'Mild (Early Stage)',
                subtitle: 'Richer visual choices, 10–15 min sessions',
                icon: Icons.filter_1_rounded,
                accentColor: profileState.stage == 'mild' ? AppColors.primary : AppColors.outline,
                onTap: () {
                  ref.read(patientProfileProvider.notifier).setStage('mild');
                },
              ),
              NenilCard(
                title: 'Moderate (Mid Stage)',
                subtitle: 'Simplified 2-card choices, audio-first',
                icon: Icons.filter_2_rounded,
                accentColor: profileState.stage == 'moderate' ? AppColors.primary : AppColors.outline,
                onTap: () {
                  ref.read(patientProfileProvider.notifier).setStage('moderate');
                },
              ),
              NenilCard(
                title: 'Severe (Late Stage)',
                subtitle: 'Single focal interaction, music & sensory focus',
                icon: Icons.filter_3_rounded,
                accentColor: profileState.stage == 'severe' ? AppColors.primary : AppColors.outline,
                onTap: () {
                  ref.read(patientProfileProvider.notifier).setStage('severe');
                },
              ),
              const Spacer(),
              NenilButton(
                label: 'Save & Go to Patient Home',
                onPressed: () async {
                  await ref.read(patientProfileProvider.notifier).saveProfileToDatabase();
                  if (context.mounted) context.go('/home');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
