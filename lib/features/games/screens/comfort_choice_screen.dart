import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/game_wrapper.dart';
import '../../../shared/widgets/nenil_card.dart';
import '../providers/game_session_provider.dart';

class ComfortChoiceScreen extends ConsumerStatefulWidget {
  const ComfortChoiceScreen({super.key});

  @override
  ConsumerState<ComfortChoiceScreen> createState() => _ComfortChoiceScreenState();
}

class _ComfortChoiceScreenState extends ConsumerState<ComfortChoiceScreen> {
  final Stopwatch _stopwatch = Stopwatch();

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

  Future<void> _selectComfort(String title) async {
    _stopwatch.stop();
    await ref.read(gameSessionProvider.notifier).recordCompletedSession(
      gameType: 'comfort_choice',
      durationSeconds: _stopwatch.elapsed.inSeconds,
    );
    if (mounted) context.push('/game-completion');
  }

  @override
  Widget build(BuildContext context) {
    return GameWrapper(
      title: 'Comfort Choice',
      audioPromptText: 'What would make you feel most comfortable right now?',
      onBack: () => context.pop(),
      onSosPressed: () => context.push('/emergency'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'What would you like right now?',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.primary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.spaceL),
          Expanded(
            child: GridView.count(
              crossAxisCount: 1,
              mainAxisSpacing: AppDimensions.spaceM,
              childAspectRatio: 2.2,
              children: [
                NenilCard(
                  title: 'Warm Assam Tea',
                  subtitle: 'A warm, soothing cup of fresh morning tea.',
                  icon: Icons.coffee_rounded,
                  onTap: () => _selectComfort('Warm Assam Tea'),
                ),
                NenilCard(
                  title: 'Soft Warm Shawl',
                  subtitle: 'Wrap a cozy, warm shawl around your shoulders.',
                  icon: Icons.dry_cleaning_rounded,
                  onTap: () => _selectComfort('Soft Warm Shawl'),
                ),
                NenilCard(
                  title: 'Calm Music Track',
                  subtitle: 'Listen to gentle regional folk melodies.',
                  icon: Icons.music_note_rounded,
                  onTap: () => _selectComfort('Calm Music Track'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
