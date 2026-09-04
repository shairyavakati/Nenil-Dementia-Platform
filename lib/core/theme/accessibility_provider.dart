import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';

class AccessibilityState {
  final bool isHighContrast;
  final bool isLargeTextEnabled;
  final double fontScale;
  final bool isAudioGuidanceEnabled;

  const AccessibilityState({
    this.isHighContrast = false,
    this.isLargeTextEnabled = true,
    this.fontScale = 1.15,
    this.isAudioGuidanceEnabled = true,
  });

  AccessibilityState copyWith({
    bool? isHighContrast,
    bool? isLargeTextEnabled,
    double? fontScale,
    bool? isAudioGuidanceEnabled,
  }) {
    return AccessibilityState(
      isHighContrast: isHighContrast ?? this.isHighContrast,
      isLargeTextEnabled: isLargeTextEnabled ?? this.isLargeTextEnabled,
      fontScale: fontScale ?? this.fontScale,
      isAudioGuidanceEnabled: isAudioGuidanceEnabled ?? this.isAudioGuidanceEnabled,
    );
  }

  Color get primaryColor => isHighContrast ? AppColors.highContrastPrimary : AppColors.primary;
  Color get backgroundColor => isHighContrast ? AppColors.highContrastBackground : AppColors.background;
  Color get textColor => isHighContrast ? AppColors.highContrastText : AppColors.onBackground;
}

class AccessibilityNotifier extends StateNotifier<AccessibilityState> {
  AccessibilityNotifier() : super(const AccessibilityState());

  void toggleHighContrast() {
    state = state.copyWith(isHighContrast: !state.isHighContrast);
  }

  void toggleLargeText() {
    final nextState = !state.isLargeTextEnabled;
    state = state.copyWith(
      isLargeTextEnabled: nextState,
      fontScale: nextState ? 1.25 : 1.0,
    );
  }

  void toggleAudioGuidance() {
    state = state.copyWith(isAudioGuidanceEnabled: !state.isAudioGuidanceEnabled);
  }
}

final accessibilityProvider = StateNotifierProvider<AccessibilityNotifier, AccessibilityState>((ref) {
  return AccessibilityNotifier();
});
