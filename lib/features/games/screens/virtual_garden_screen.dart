import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/game_wrapper.dart';
import '../../../shared/widgets/nenil_button.dart';
import '../providers/game_session_provider.dart';

class VirtualGardenScreen extends ConsumerStatefulWidget {
  const VirtualGardenScreen({super.key});

  @override
  ConsumerState<VirtualGardenScreen> createState() => _VirtualGardenScreenState();
}

class _VirtualGardenScreenState extends ConsumerState<VirtualGardenScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  int _wateredPlants = 0;

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

  Future<void> _waterPlant() async {
    setState(() => _wateredPlants++);
    if (_wateredPlants >= 3) {
      _stopwatch.stop();
      await ref.read(gameSessionProvider.notifier).recordCompletedSession(
        gameType: 'virtual_garden',
        durationSeconds: _stopwatch.elapsed.inSeconds,
      );
      if (mounted) context.push('/game-completion');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GameWrapper(
      title: 'Virtual Garden Care',
      audioPromptText: 'Tap the watering can to water your garden plants.',
      onBack: () => context.pop(),
      onSosPressed: () => context.push('/emergency'),
      child: Column(
        children: [
          const Text(
            'Calm Garden & Plant Care',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.primary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.spaceL),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.spaceXL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _wateredPlants >= 3 ? Icons.local_florist_rounded : Icons.eco_rounded,
                      size: 100,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: AppDimensions.spaceL),
                    Text(
                      'Plants Watered: $_wateredPlants / 3',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppDimensions.spaceM),
                    const Text(
                      'Enjoy watering your green garden leaves and flowers.',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceL),
          NenilButton(
            label: _wateredPlants >= 3 ? 'Garden Complete!' : 'Water Next Plant',
            icon: Icons.water_drop_rounded,
            onPressed: _waterPlant,
          ),
        ],
      ),
    );
  }
}
