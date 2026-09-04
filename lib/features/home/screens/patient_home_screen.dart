import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../providers/home_feed_provider.dart';
import '../widgets/daily_routine_card.dart';
import '../widgets/greeting_header_widget.dart';
import '../widgets/journey_feed_widget.dart';

class PatientHomeScreen extends ConsumerWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeFeedProvider);

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
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () => ref.read(homeFeedProvider.notifier).loadHomeFeedData(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(AppDimensions.spaceL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Time-of-day spoken greeting header
                      GreetingHeaderWidget(
                        greetingText: state.greetingText,
                        patientName: state.patient?.name ?? '',
                        timeOfDay: state.timeOfDay,
                      ),
                      const SizedBox(height: AppDimensions.spaceL),

                      // 2. Daily Routines Section
                      if (state.routines.isNotEmpty) ...[
                        const Text(
                          'Daily Habits & Routine',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spaceS),
                        ...state.routines.map(
                          (routine) => DailyRoutineCard(
                            routine: routine,
                            onToggle: () {
                              ref.read(homeFeedProvider.notifier).toggleRoutineCompletion(routine.id);
                            },
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spaceL),
                      ],

                      // 3. Stage-Adapted Cognitive Journey Games Feed
                      JourneyFeedWidget(games: state.recommendedGames),
                    ],
                  ),
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
