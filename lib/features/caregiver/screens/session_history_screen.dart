import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../providers/caregiver_dashboard_provider.dart';

class SessionHistoryScreen extends ConsumerWidget {
  const SessionHistoryScreen({super.key});

  IconData _getGameIcon(String gameType) {
    switch (gameType) {
      case 'daily_routine':
        return Icons.wb_sunny_rounded;
      case 'find_my_things':
        return Icons.search_rounded;
      case 'family_faces':
        return Icons.people_rounded;
      case 'music_memory':
        return Icons.music_note_rounded;
      case 'emotion_match':
        return Icons.sentiment_satisfied_alt_rounded;
      default:
        return Icons.extension_rounded;
    }
  }

  String _formatGameTitle(String gameType) {
    switch (gameType) {
      case 'daily_routine':
        return 'My Daily Routine';
      case 'find_my_things':
        return 'Find My Things';
      case 'family_faces':
        return 'Family Faces & Stories';
      case 'music_memory':
        return 'Music Memory Journey';
      case 'emotion_match':
        return 'Emotion Match';
      default:
        return gameType;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(caregiverDashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Session History Logs'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: AppDimensions.iconMedium),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceL),
          child: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.sessionHistory.isEmpty
                  ? const Center(
                      child: Text(
                        'No completed sessions logged yet.',
                        style: TextStyle(fontSize: 18, color: AppColors.outline),
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.sessionHistory.length,
                      itemBuilder: (context, index) {
                        final session = state.sessionHistory[index];
                        final durationMins = (session.durationSeconds / 60).toStringAsFixed(1);
                        final dateStr = session.completedAt.split('T').first;

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: AppDimensions.spaceS),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColors.primaryContainer,
                              child: Icon(_getGameIcon(session.gameType), color: AppColors.primary),
                            ),
                            title: Text(_formatGameTitle(session.gameType), style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('Date: $dateStr · Duration: $durationMins mins'),
                            trailing: const Icon(Icons.star_rounded, color: Colors.amber),
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
