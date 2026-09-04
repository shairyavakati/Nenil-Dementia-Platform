import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/game_wrapper.dart';
import '../../../shared/widgets/nenil_card.dart';
import '../engine/behavioral_distress_monitor.dart';
import '../engine/errorless_learning_handler.dart';
import '../providers/game_session_provider.dart';

class WordMatchGameScreen extends ConsumerStatefulWidget {
  const WordMatchGameScreen({super.key});

  @override
  ConsumerState<WordMatchGameScreen> createState() => _WordMatchGameScreenState();
}

class _WordMatchGameScreenState extends ConsumerState<WordMatchGameScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  final BehavioralDistressMonitor _distressMonitor = BehavioralDistressMonitor();
  int _highlightedIndex = -1;

  final List<Map<String, dynamic>> _wordPairs = const [
    {
      'word': 'Saah (Assamese Tea)',
      'desc': 'Match Assamese word "Saah" with warm tea mug.',
      'icon': Icons.coffee_rounded,
      'isCorrect': true,
    },
    {
      'word': 'Jaapi (Traditional Hat)',
      'desc': 'Traditional woven NER sun shade hat.',
      'icon': Icons.dry_cleaning_rounded,
      'isCorrect': false,
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

  void _onWordSelected(int index) {
    final item = _wordPairs[index];
    final bool isCorrect = item['isCorrect'] as bool;

    final deescalated = _distressMonitor.recordAttempt(isCorrect: isCorrect, context: context);
    if (deescalated) return;

    if (isCorrect) {
      _finishGame();
    } else {
      ErrorlessLearningHandler.handleSelection(
        isCorrect: false,
        correctOptionTitle: 'Saah (Assamese Tea)',
        onGuideToCorrect: () {
          setState(() => _highlightedIndex = 0);
        },
      );
    }
  }

  Future<void> _finishGame() async {
    _stopwatch.stop();
    await ref.read(gameSessionProvider.notifier).recordCompletedSession(
      gameType: 'word_match',
      durationSeconds: _stopwatch.elapsed.inSeconds,
    );
    if (mounted) context.push('/game-completion');
  }

  @override
  Widget build(BuildContext context) {
    return GameWrapper(
      title: 'Regional Word Match',
      audioPromptText: 'Match the Assamese word Saah with the warm tea mug.',
      onBack: () => context.pop(),
      onSosPressed: () => context.push('/emergency'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Which card matches "Saah" (Tea)?',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.spaceL),
          Expanded(
            child: ListView.separated(
              itemCount: _wordPairs.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppDimensions.spaceM),
              itemBuilder: (ctx, i) {
                final item = _wordPairs[i];
                final isHighlighted = _highlightedIndex == i;

                return NenilCard(
                  title: item['word'] as String,
                  subtitle: item['desc'] as String,
                  icon: item['icon'] as IconData,
                  backgroundColor: isHighlighted ? AppColors.secondaryContainer : AppColors.surface,
                  onTap: () => _onWordSelected(i),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
