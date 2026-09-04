import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/nenil_button.dart';

class CaregiverAuthScreen extends StatelessWidget {
  const CaregiverAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.titleCaregiverAuth)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Caregiver Setup',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppDimensions.spaceS),
              const Text(
                'Caregivers customize activities, voice prompts, and monitor cognitive progress.',
                style: TextStyle(fontSize: 18),
              ),
              const Spacer(),
              NenilButton(
                label: 'Create Patient Profile',
                onPressed: () => context.push('/patient-profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
