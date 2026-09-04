import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../models/session_model.dart';
import '../../../storage/database/app_database.dart';

class GameSessionNotifier extends StateNotifier<AsyncValue<void>> {
  GameSessionNotifier() : super(const AsyncValue.data(null));

  Future<bool> recordCompletedSession({
    required String gameType,
    required int durationSeconds,
    double engagementScore = 1.0,
  }) async {
    state = const AsyncValue.loading();
    try {
      final db = await AppDatabase.database;
      final sessionId = const Uuid().v4();
      final completedAt = DateTime.now().toIso8601String();

      // Get latest patient ID or default
      final patientMaps = await db.query('patients', limit: 1, orderBy: 'created_at DESC');
      final patientId = patientMaps.isNotEmpty ? patientMaps.first['id'] as String : 'p_default';

      final session = SessionModel(
        id: sessionId,
        patientId: patientId,
        gameType: gameType,
        durationSeconds: durationSeconds,
        engagementScore: engagementScore,
        completedAt: completedAt,
        isSynced: false,
      );

      await db.insert('sessions', session.toMap());
      state = const AsyncValue.data(null);
      debugPrint('[GameSessionNotifier] Recorded game session for $gameType cleanly in SQLite.');
      return true;
    } catch (e, stack) {
      debugPrint('[GameSessionNotifier] Error recording session: $e');
      state = AsyncValue.error(e, stack);
      return false;
    }
  }
}

final gameSessionProvider = StateNotifierProvider<GameSessionNotifier, AsyncValue<void>>((ref) {
  return GameSessionNotifier();
});
