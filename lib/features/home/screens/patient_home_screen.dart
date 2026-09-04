import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/audio_prompt_widget.dart';
import '../../../shared/widgets/nenil_card.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleHome),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings_rounded, size: AppDimensions.iconMedium),
            onPressed: () => context.push('/caregiver-dashboard'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.spaceL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Good Morning!',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  AudioPromptWidget(textToSpeak: 'Good Morning! Let us begin today\'s activities.'),
                ],
              ),
              const SizedBox(height: AppDimensions.spaceL),
              const Text(
                'Recommended Activities',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
              const SizedBox(height: AppDimensions.spaceM),
              NenilCard(
                title: AppStrings.gameDailyRoutine,
                subtitle: 'Morning routine visual guide',
                icon: Icons.wb_sunny_rounded,
                onTap: () => context.push('/game/daily_routine'),
              ),
              NenilCard(
                title: AppStrings.gameFindThings,
                subtitle: 'Find your reading glasses',
                icon: Icons.search_rounded,
                onTap: () => context.push('/game/find_things'),
              ),
              NenilCard(
                title: AppStrings.gameFamilyFaces,
                subtitle: 'Stories of family members',
                icon: Icons.people_rounded,
                onTap: () => context.push('/game/family_faces'),
              ),
              NenilCard(
                title: AppStrings.gameMusicMemory,
                subtitle: 'Folk songs & regional music',
                icon: Icons.music_note_rounded,
                onTap: () => context.push('/game/music_memory'),
              ),
              NenilCard(
                title: AppStrings.gameEmotionMatch,
                subtitle: 'Facial expression recognition',
                icon: Icons.sentiment_satisfied_alt_rounded,
                onTap: () => context.push('/game/emotion_match'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/emergency'),
        backgroundColor: AppColors.emergency,
        foregroundColor: AppColors.onEmergency,
        icon: const Icon(Icons.emergency, size: AppDimensions.iconMedium),
        label: const Text('SOS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
