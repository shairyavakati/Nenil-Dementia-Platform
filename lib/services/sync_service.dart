import 'package:flutter/foundation.dart';
import '../core/config/supabase_config.dart';
import '../storage/database/app_database.dart';

/// SyncService — Manages background synchronization between local SQLite and remote Supabase.
class SyncService {
  static bool _isSyncing = false;
  static bool get isSyncing => _isSyncing;

  /// Check network connectivity (returns true if remote Supabase is reachable).
  static Future<bool> isNetworkConnected() async {
    if (!SupabaseConfig.isInitialized) {
      return false;
    }
    try {
      final client = SupabaseConfig.client;
      // Ping check or heartbeat query
      await client.from('patients').select('id').limit(1);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Synchronize all pending SQLite sessions (where is_synced = 0) to Supabase.
  static Future<int> syncPendingSessions() async {
    if (_isSyncing) {
      debugPrint('[SyncService] Sync operation already in progress.');
      return 0;
    }

    _isSyncing = true;
    int syncedCount = 0;

    try {
      final db = await AppDatabase.database;
      if (db == null) {
        debugPrint('[SyncService] SQLite not available on this platform \u2014 skipping sync.');
        _isSyncing = false;
        return 0;
      }
      final pendingRows = await db.query(
        'sessions',
        where: 'is_synced = ?',
        whereArgs: [0],
      );

      if (pendingRows.isEmpty) {
        debugPrint('[SyncService] No pending sessions to synchronize.');
        _isSyncing = false;
        return 0;
      }

      debugPrint('[SyncService] Found ${pendingRows.length} pending sessions to sync.');

      if (!SupabaseConfig.isInitialized) {
        debugPrint('[SyncService] Offline mode active — skipping remote upload. Sessions remain queued in SQLite.');
        _isSyncing = false;
        return 0;
      }

      final client = SupabaseConfig.client;

      for (final row in pendingRows) {
        final sessionId = row['id'] as String;
        try {
          await client.from('sessions').upsert({
            'id': sessionId,
            'patient_id': row['patient_id'],
            'game_type': row['game_type'],
            'duration_seconds': row['duration_seconds'],
            'engagement_score': row['engagement_score'],
            'completed_at': row['completed_at'],
          });

          // Mark as synced in local SQLite
          await db.update(
            'sessions',
            {'is_synced': 1},
            where: 'id = ?',
            whereArgs: [sessionId],
          );
          syncedCount++;
        } catch (e) {
          debugPrint('[SyncService] Failed to sync session $sessionId: $e');
        }
      }

      debugPrint('[SyncService] Successfully synchronized $syncedCount / ${pendingRows.length} sessions to Supabase.');
    } catch (e) {
      debugPrint('[SyncService] General error during background sync: $e');
    } finally {
      _isSyncing = false;
    }

    return syncedCount;
  }

  /// Trigger a full sync sweep for pending sessions and patient profiles.
  static Future<void> syncPendingData() async {
    await syncPendingSessions();
  }
}

