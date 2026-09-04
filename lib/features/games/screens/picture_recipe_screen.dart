import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/game_wrapper.dart';
import '../../../shared/widgets/nenil_button.dart';
import '../providers/game_session_provider.dart';

class PictureRecipeScreen extends ConsumerStatefulWidget {
  const PictureRecipeScreen({super.key});

  @override
  ConsumerState<PictureRecipeScreen> createState() => _PictureRecipeScreenState();
}

class _PictureRecipeScreenState extends ConsumerState<PictureRecipeScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  int _currentStep = 0;

  final List<Map<String, String>> _recipeSteps = const [
    {
      'step': 'Step 1: Boil Fresh Water',
      'desc': 'Heat fresh water in the warm kettle.',
      'icon': 'local_fire_department_rounded',
    },
    {
      'step': 'Step 2: Add Tea Leaves',
      'desc': 'Add warm Assam tea leaves or ginger slice.',
      'icon': 'emoji_food_beverage_rounded',
    },
    {
      'step': 'Step 3: Pour & Enjoy',
      'desc': 'Pour warm tea into your favorite mug.',
      'icon': 'coffee_rounded',
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
    if (_currentStep < _recipeSteps.length - 1) {
      setState(() => _currentStep++);
    } else {
      _stopwatch.stop();
      await ref.read(gameSessionProvider.notifier).recordCompletedSession(
        gameType: 'picture_recipe',
        durationSeconds: _stopwatch.elapsed.inSeconds,
      );
      if (mounted) context.push('/game-completion');
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = _recipeSteps[_currentStep];

    return GameWrapper(
      title: 'Picture Recipe Steps',
      audioPromptText: '${step['step']}. ${step['desc']}',
      onBack: () => context.pop(),
      onSosPressed: () => context.push('/emergency'),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentStep + 1) / _recipeSteps.length,
            backgroundColor: AppColors.primaryContainer,
            color: AppColors.primary,
            minHeight: 8,
          ),
          const SizedBox(height: AppDimensions.spaceL),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.spaceXL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.coffee_rounded, size: 80, color: AppColors.primary),
                    const SizedBox(height: AppDimensions.spaceL),
                    Text(
                      step['step']!,
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.primary),
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
            label: _currentStep < _recipeSteps.length - 1 ? 'Next Step' : 'Finish Recipe',
            icon: Icons.check_circle_rounded,
            onPressed: _nextStep,
          ),
        ],
      ),
    );
  }
}
