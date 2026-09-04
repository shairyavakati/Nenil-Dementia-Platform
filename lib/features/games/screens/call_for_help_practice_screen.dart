import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/game_wrapper.dart';
import '../../../shared/widgets/nenil_button.dart';
import '../providers/game_session_provider.dart';

class CallForHelpPracticeScreen extends ConsumerStatefulWidget {
  const CallForHelpPracticeScreen({super.key});

  @override
  ConsumerState<CallForHelpPracticeScreen> createState() => _CallForHelpPracticeScreenState();
}

class _CallForHelpPracticeScreenState extends ConsumerState<CallForHelpPracticeScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  bool _tappedSos = false;

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
  }

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }

  Future<void> _onSosTapped() async {
    setState(() => _tappedSos = true);
    _stopwatch.stop();
    await ref.read(gameSessionProvider.notifier).recordCompletedSession(
      gameType: 'call_help_practice',
      durationSeconds: _stopwatch.elapsed.inSeconds,
    );
    if (mounted) context.push('/game-completion');
  }

  @override
  Widget build(BuildContext context) {
    return GameWrapper(
      title: 'Call for Help Practice',
      audioPromptText: 'Tap the large red button whenever you need help or caregiver care.',
      onBack: () => context.pop(),
      onSosPressed: () => context.push('/emergency'),
      child: Column(
        children: [
          const Text(
            'Emergency Practice',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.primary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.spaceM),
          const Text(
            'If you ever need help, tap the red SOS button.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          GestureDetector(
            onTap: _onSosTapped,
            child: CircleAvatar(
              radius: 90,
              backgroundColor: AppColors.emergency,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.emergency_rounded, size: 64, color: AppColors.onEmergency),
                  SizedBox(height: 8),
                  Text(
                    'TAP FOR HELP',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onEmergency,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          NenilButton(
            label: _tappedSos ? 'Practice Complete!' : 'I Understand — Return Home',
            icon: Icons.check_circle_rounded,
            onPressed: () => context.go('/home'),
          ),
        ],
      ),
    );
  }
}
