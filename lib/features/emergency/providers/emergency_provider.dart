import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/call_service.dart';
import '../../../services/location_service.dart';

enum SosStatus { idle, countdown, active, cancelled }

class EmergencyState {
  final SosStatus status;
  final int countdownSeconds;
  final String primaryContactPhone;
  final Map<String, double>? locationCoordinates;
  final bool isCalling;

  const EmergencyState({
    this.status = SosStatus.idle,
    this.countdownSeconds = 5,
    this.primaryContactPhone = '+91 98765 43210',
    this.locationCoordinates,
    this.isCalling = false,
  });

  EmergencyState copyWith({
    SosStatus? status,
    int? countdownSeconds,
    String? primaryContactPhone,
    Map<String, double>? locationCoordinates,
    bool? isCalling,
  }) {
    return EmergencyState(
      status: status ?? this.status,
      countdownSeconds: countdownSeconds ?? this.countdownSeconds,
      primaryContactPhone: primaryContactPhone ?? this.primaryContactPhone,
      locationCoordinates: locationCoordinates ?? this.locationCoordinates,
      isCalling: isCalling ?? this.isCalling,
    );
  }
}

class EmergencyNotifier extends StateNotifier<EmergencyState> {
  Timer? _timer;

  EmergencyNotifier() : super(const EmergencyState());

  void startSosCountdown() {
    _timer?.cancel();
    state = state.copyWith(status: SosStatus.countdown, countdownSeconds: 5);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.countdownSeconds > 1) {
        state = state.copyWith(countdownSeconds: state.countdownSeconds - 1);
      } else {
        timer.cancel();
        triggerActiveEmergency();
      }
    });
  }

  void cancelSos() {
    _timer?.cancel();
    state = state.copyWith(status: SosStatus.cancelled, countdownSeconds: 5, isCalling: false);
  }

  Future<void> triggerActiveEmergency() async {
    state = state.copyWith(status: SosStatus.active, isCalling: true);

    // Fetch GPS coordinates
    final loc = await LocationService.getCurrentLocation();
    state = state.copyWith(locationCoordinates: loc);

    // Trigger Phone Call
    await CallService.makePhoneCall(state.primaryContactPhone);
    debugPrint('[EmergencyNotifier] SOS Active! Location: $loc, Called: ${state.primaryContactPhone}');
  }

  void updatePrimaryContact(String phone) {
    state = state.copyWith(primaryContactPhone: phone);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final emergencyProvider = StateNotifierProvider<EmergencyNotifier, EmergencyState>((ref) {
  return EmergencyNotifier();
});
