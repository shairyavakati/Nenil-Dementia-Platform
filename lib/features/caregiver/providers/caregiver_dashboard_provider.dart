import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/session_model.dart';
import '../../../storage/database/app_database.dart';

class CaregiverDashboardState {
  final List<SessionModel> sessionHistory;
  final int totalSessionsCompleted;
  final int totalMinutesEngaged;
  final String favoriteGame;
  final bool isLoading;

  const CaregiverDashboardState({
    this.sessionHistory = const [],
    this.totalSessionsCompleted = 0,
    this.totalMinutesEngaged = 0,
    this.favoriteGame = 'My Daily Routine',
    this.isLoading = false,
  });

  CaregiverDashboardState copyWith({
    List<SessionModel>? sessionHistory,
    int? totalSessionsCompleted,
    int? totalMinutesEngaged,
    String? favoriteGame,
    bool? isLoading,
  }) {
    return CaregiverDashboardState(
      sessionHistory: sessionHistory ?? this.sessionHistory,
      totalSessionsCompleted: totalSessionsCompleted ?? this.totalSessionsCompleted,
      totalMinutesEngaged: totalMinutesEngaged ?? this.totalMinutesEngaged,
      favoriteGame: favoriteGame ?? this.favoriteGame,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class CaregiverDashboardNotifier extends StateNotifier<CaregiverDashboardState> {
  CaregiverDashboardNotifier() : super(const CaregiverDashboardState(isLoading: true)) {
    loadCaregiverData();
  }

  Future<void> loadCaregiverData() async {
    try {
      final db = await AppDatabase.database;
      if (db == null) {
        debugPrint('[CaregiverDashboardNotifier] SQLite unavailable on web \u2014 showing empty dashboard.');
        state = state.copyWith(isLoading: false);
        return;
      }
      final maps = await db.query('sessions', orderBy: 'completed_at DESC');

      final history = maps.map((m) => SessionModel.fromMap(m)).toList();
      final totalSessions = history.length;
      final totalSeconds = history.fold<int>(0, (sum, item) => sum + item.durationSeconds);
      final totalMinutes = (totalSeconds / 60).round();

      state = state.copyWith(
        sessionHistory: history,
        totalSessionsCompleted: totalSessions,
        totalMinutesEngaged: totalMinutes,
        isLoading: false,
      );
      debugPrint('[CaregiverDashboardNotifier] Loaded ${history.length} session records from SQLite.');
    } catch (e) {
      debugPrint('[CaregiverDashboardNotifier] Error loading sessions: $e');
      state = state.copyWith(isLoading: false);
    }
  }
}

final caregiverDashboardProvider = StateNotifierProvider<CaregiverDashboardNotifier, CaregiverDashboardState>((ref) {
  return CaregiverDashboardNotifier();
});
