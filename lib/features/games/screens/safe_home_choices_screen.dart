import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/game_wrapper.dart';
import '../../../shared/widgets/nenil_card.dart';
import '../engine/errorless_learning_handler.dart';
import '../providers/game_session_provider.dart';

class SafeHomeChoicesScreen extends ConsumerStatefulWidget {
  const SafeHomeChoicesScreen({super.key});

  @override
  ConsumerState<SafeHomeChoicesScreen> createState() => _SafeHomeChoicesScreenState();
}

class _SafeHomeChoicesScreenState extends ConsumerState<SafeHomeChoicesScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  int _highlightedIndex = -1;

  final List<Map<String, dynamic>> _options = const [
    {
      'title': 'Use Walker Support',
      'desc': 'Hold walker handles firmly before standing up.',
      'icon': Icons.accessible_forward_rounded,
      'isSafe': true,
    },
    {
      'title': 'Walk Without Support',
      'desc': 'Walk quickly without holding nearby furniture.',
      'icon': Icons.directions_walk_rounded,
      'isSafe': false,
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

  void _onChoiceSelected(int index) {
    final item = _options[index];
    final bool isSafe = item['isSafe'] as bool;

    if (isSafe) {
      _finishGame();
    } else {
      ErrorlessLearningHandler.handleSelection(
        isCorrect: false,
        correctOptionTitle: 'Use Walker Support',
        onGuideToCorrect: () {
          setState(() {
            _highlightedIndex = 0; // Highlight safe option
          });
        },
      );
    }
  }

  Future<void> _finishGame() async {
    _stopwatch.stop();
    await ref.read(gameSessionProvider.notifier).recordCompletedSession(
      gameType: 'safe_choices',
      durationSeconds: _stopwatch.elapsed.inSeconds,
    );
    if (mounted) context.push('/game-completion');
  }

  @override
  Widget build(BuildContext context) {
    return GameWrapper(
      title: 'Safe Home Choices',
      audioPromptText: 'Which action keeps you safe and steady when walking?',
      onBack: () => context.pop(),
      onSosPressed: () => context.push('/emergency'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Which choice is safe for standing up?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.spaceL),
          Expanded(
            child: ListView.separated(
              itemCount: _options.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppDimensions.spaceM),
              itemBuilder: (ctx, i) {
                final item = _options[i];
                final isHighlighted = _highlightedIndex == i;

                return NenilCard(
                  title: item['title'] as String,
                  subtitle: item['desc'] as String,
                  icon: item['icon'] as IconData,
                  backgroundColor: isHighlighted ? AppColors.secondaryContainer : AppColors.surface,
                  onTap: () => _onChoiceSelected(i),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
