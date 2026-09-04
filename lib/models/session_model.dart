/// SessionModel — Stores completed cognitive game session engagement logs.
class SessionModel {
  final String id;
  final String patientId;
  final String gameType;
  final int durationSeconds;
  final double engagementScore; // 0.0 to 1.0
  final String completedAt;
  final bool isSynced;

  const SessionModel({
    required this.id,
    required this.patientId,
    required this.gameType,
    required this.durationSeconds,
    required this.engagementScore,
    required this.completedAt,
    this.isSynced = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patient_id': patientId,
      'game_type': gameType,
      'duration_seconds': durationSeconds,
      'engagement_score': engagementScore,
      'completed_at': completedAt,
      'is_synced': isSynced ? 1 : 0,
    };
  }

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    return SessionModel(
      id: map['id'] as String,
      patientId: map['patient_id'] as String,
      gameType: map['game_type'] as String,
      durationSeconds: map['duration_seconds'] as int,
      engagementScore: (map['engagement_score'] as num).toDouble(),
      completedAt: map['completed_at'] as String,
      isSynced: (map['is_synced'] as int? ?? 0) == 1,
    );
  }
}
