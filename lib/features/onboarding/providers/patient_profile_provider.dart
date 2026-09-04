import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../models/patient_model.dart';
import '../../../storage/cache/hive_config.dart';
import '../../../storage/database/app_database.dart';

class PatientProfileState {
  final String patientName;
  final String stage;
  final String preferredLanguage;
  final String? avatarUrl;
  final bool isSaved;

  const PatientProfileState({
    this.patientName = '',
    this.stage = 'mild',
    this.preferredLanguage = 'en',
    this.avatarUrl,
    this.isSaved = false,
  });

  PatientProfileState copyWith({
    String? patientName,
    String? stage,
    String? preferredLanguage,
    String? avatarUrl,
    bool? isSaved,
  }) {
    return PatientProfileState(
      patientName: patientName ?? this.patientName,
      stage: stage ?? this.stage,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}

class PatientProfileNotifier extends StateNotifier<PatientProfileState> {
  PatientProfileNotifier() : super(const PatientProfileState());

  void setName(String name) {
    state = state.copyWith(patientName: name);
  }

  void setStage(String stage) {
    state = state.copyWith(stage: stage);
  }

  void setLanguage(String lang) {
    state = state.copyWith(preferredLanguage: lang);
  }

  Future<bool> saveProfileToDatabase() async {
    try {
      final db = await AppDatabase.database;
      final patientId = const Uuid().v4();
      final createdAt = DateTime.now().toIso8601String();

      final patient = PatientModel(
        id: patientId,
        name: state.patientName.isEmpty ? 'Elderly Parent' : state.patientName,
        stage: state.stage,
        preferredLanguage: state.preferredLanguage,
        avatarUrl: state.avatarUrl,
        createdAt: createdAt,
      );

      await db.insert('patients', patient.toMap());
      await HiveConfig.setOnboarded(true);

      state = state.copyWith(isSaved: true);
      debugPrint('[PatientProfileNotifier] Patient profile saved to SQLite DB cleanly.');
      return true;
    } catch (e) {
      debugPrint('[PatientProfileNotifier] Save error: $e');
      return false;
    }
  }
}

final patientProfileProvider = StateNotifierProvider<PatientProfileNotifier, PatientProfileState>((ref) {
  return PatientProfileNotifier();
});
