import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/nenil_button.dart';
import '../../../shared/widgets/nenil_card.dart';

class StageSelectionScreen extends StatefulWidget {
  const StageSelectionScreen({super.key});

  @override
  State<StageSelectionScreen> createState() => _StageSelectionScreenState();
}

class _StageSelectionScreenState extends State<StageSelectionScreen> {
  String _selectedStage = 'mild';

  @override
  Widget build(BuildContext context) {
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
                'This adapts game choice complexity, audio guidance, and session length.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: AppDimensions.spaceL),
              NenilCard(
                title: 'Mild (Early Stage)',
                subtitle: 'Richer visual choices, 10–15 min sessions',
                icon: Icons.filter_1_rounded,
                onTap: () => setState(() => _selectedStage = 'mild'),
              ),
              NenilCard(
                title: 'Moderate (Mid Stage)',
                subtitle: 'Simplified 2-card choices, audio-first',
                icon: Icons.filter_2_rounded,
                onTap: () => setState(() => _selectedStage = 'moderate'),
              ),
              NenilCard(
                title: 'Severe (Late Stage)',
                subtitle: 'Single focal interaction, music & sensory focus',
                icon: Icons.filter_3_rounded,
                onTap: () => setState(() => _selectedStage = 'severe'),
              ),
              const Spacer(),
              NenilButton(
                label: 'Go to Patient Home',
                onPressed: () => context.go('/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
