import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/audio_prompt_widget.dart';
import '../../../shared/widgets/nenil_button.dart';
import '../providers/emergency_provider.dart';
import '../widgets/emergency_countdown_widget.dart';

class EmergencyScreen extends ConsumerStatefulWidget {
  const EmergencyScreen({super.key});

  @override
  ConsumerState<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends ConsumerState<EmergencyScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(emergencyProvider.notifier).startSosCountdown();
    });
  }

  void _cancelSos() {
    ref.read(emergencyProvider.notifier).cancelSos();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(emergencyProvider);

    return Scaffold(
      backgroundColor: AppColors.emergencyContainer,
      appBar: AppBar(
        backgroundColor: AppColors.emergencyContainer,
        title: const Text(AppStrings.titleEmergency, style: TextStyle(color: AppColors.emergency, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: AppDimensions.iconMedium, color: AppColors.emergency),
          onPressed: _cancelSos,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceXL),
          child: state.status == SosStatus.countdown
              ? EmergencyCountdownWidget(
                  countdownSeconds: state.countdownSeconds,
                  onCancel: _cancelSos,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.emergency_rounded, size: AppDimensions.iconHuge * 1.5, color: AppColors.emergency),
                    const SizedBox(height: AppDimensions.spaceL),
                    const Text(
                      'Help is on the way!',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.emergency),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimensions.spaceM),
                    AudioPromptWidget(textToSpeak: 'Connecting emergency phone call to primary caregiver ${state.primaryContactPhone} and broadcasting your current GPS location.'),
                    const SizedBox(height: AppDimensions.spaceL),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimensions.spaceM),
                        child: Column(
                          children: [
                            Text(
                              'Dialing Caregiver:\n${state.primaryContactPhone}',
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const Divider(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.location_on_rounded, color: AppColors.primary),
                                const SizedBox(width: 8),
                                Text(
                                  state.locationCoordinates != null
                                      ? 'GPS: ${state.locationCoordinates!['latitude']}° N, ${state.locationCoordinates!['longitude']}° E'
                                      : 'Fetching GPS coordinates...',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    NenilButton(
                      label: 'Return to Safety',
                      backgroundColor: AppColors.surface,
                      foregroundColor: AppColors.onBackground,
                      onPressed: () => context.pop(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
