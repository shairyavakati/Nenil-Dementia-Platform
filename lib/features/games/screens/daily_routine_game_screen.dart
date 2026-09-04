import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/game_wrapper.dart';
import '../../../shared/widgets/nenil_button.dart';
import '../providers/game_session_provider.dart';

class DailyRoutineGameScreen extends ConsumerStatefulWidget {
  const DailyRoutineGameScreen({super.key});

  @override
  ConsumerState<DailyRoutineGameScreen> createState() => _DailyRoutineGameScreenState();
}

class _DailyRoutineGameScreenState extends ConsumerState<DailyRoutineGameScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  int _currentStep = 0;

  final List<Map<String, String>> _routineSteps = const [
    {
      'title': 'Morning Warm Tea',
      'desc': 'Enjoy a warm cup of morning tea or water.',
      'icon': 'local_cafe_rounded',
    },
    {
      'title': 'Water the Garden',
      'desc': 'Walk outside and water the green plants.',
      'icon': 'eco_rounded',
    },
    {
      'title': 'Comfortable Sitting Rest',
      'desc': 'Sit in your favorite chair and rest your mind.',
      'icon': 'chair_rounded',
    },
  ];

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

  Future<void> _nextStep() async {
    if (_currentStep < _routineSteps.length - 1) {
      setState(() => _currentStep++);
    } else {
      _stopwatch.stop();
      await ref.read(gameSessionProvider.notifier).recordCompletedSession(
        gameType: 'daily_routine',
        durationSeconds: _stopwatch.elapsed.inSeconds,
      );
      if (mounted) context.push('/game-completion');
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = _routineSteps[_currentStep];

    return GameWrapper(
      title: AppStrings.gameDailyRoutine,
      audioPromptText: 'Step ${_currentStep + 1}: ${step['title']}. ${step['desc']}',
      onBack: () => context.pop(),
      onSosPressed: () => context.push('/emergency'),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentStep + 1) / _routineSteps.length,
            backgroundColor: AppColors.primaryContainer,
            color: AppColors.primary,
            minHeight: 8,
          ),
          const SizedBox(height: AppDimensions.spaceL),
          Expanded(
            child: Card(
              elevation: AppDimensions.elevationMedium,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusL),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.spaceXL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppDimensions.spaceL),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.wb_sunny_rounded, size: 80, color: AppColors.primary),
                    ),
                    const SizedBox(height: AppDimensions.spaceL),
                    Text(
                      step['title']!,
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimensions.spaceM),
                    Text(
                      step['desc']!,
                      style: const TextStyle(fontSize: 20, color: AppColors.onBackground),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceL),
          NenilButton(
            label: _currentStep < _routineSteps.length - 1 ? 'Complete Step & Next' : 'Finish Routine Activity',
            icon: Icons.check_circle_rounded,
            onPressed: _nextStep,
          ),
        ],
      ),
    );
  }
}
