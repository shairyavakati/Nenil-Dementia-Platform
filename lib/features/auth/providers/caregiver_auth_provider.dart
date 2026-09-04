import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../models/caregiver_model.dart';
import '../../../storage/cache/hive_config.dart';
import '../../../storage/database/app_database.dart';

class CaregiverAuthState {
  final CaregiverModel? currentCaregiver;
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;

  const CaregiverAuthState({
    this.currentCaregiver,
    this.isAuthenticated = false,
    this.isLoading = false,
    this.error,
  });

  CaregiverAuthState copyWith({
    CaregiverModel? currentCaregiver,
    bool? isAuthenticated,
    bool? isLoading,
    String? error,
  }) {
    return CaregiverAuthState(
      currentCaregiver: currentCaregiver ?? this.currentCaregiver,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class CaregiverAuthNotifier extends StateNotifier<CaregiverAuthState> {
  CaregiverAuthNotifier() : super(const CaregiverAuthState());

  Future<bool> registerCaregiver({
    required String name,
    required String phone,
    required String relationship,
    required String pin,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final db = await AppDatabase.database;
      final caregiverId = const Uuid().v4();
      final createdAt = DateTime.now().toIso8601String();

      final caregiver = CaregiverModel(
        id: caregiverId,
        name: name,
        phone: phone,
        relationship: relationship,
        pinHash: pin, // In production, hash with SHA256
        createdAt: createdAt,
      );

      await db.insert('caregivers', caregiver.toMap());
      await HiveConfig.settingsBox.put(HiveConfig.keyCaregiverPin, pin);

      state = state.copyWith(
        currentCaregiver: caregiver,
        isAuthenticated: true,
        isLoading: false,
      );
      debugPrint('[CaregiverAuthNotifier] Registered caregiver $name cleanly.');
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  bool verifyPin(String pin) {
    final savedPin = HiveConfig.settingsBox.get(HiveConfig.keyCaregiverPin) as String?;
    if (savedPin == null) return pin == '1234'; // Default fallback PIN for testing
    return savedPin == pin;
  }
}

final caregiverAuthProvider = StateNotifierProvider<CaregiverAuthNotifier, CaregiverAuthState>((ref) {
  return CaregiverAuthNotifier();
});
