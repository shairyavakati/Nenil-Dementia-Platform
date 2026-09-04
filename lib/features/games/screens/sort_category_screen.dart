import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/game_wrapper.dart';
import '../../../shared/widgets/nenil_card.dart';
import '../engine/errorless_learning_handler.dart';
import '../providers/game_session_provider.dart';

class SortCategoryScreen extends ConsumerStatefulWidget {
  const SortCategoryScreen({super.key});

  @override
  ConsumerState<SortCategoryScreen> createState() => _SortCategoryScreenState();
}

class _SortCategoryScreenState extends ConsumerState<SortCategoryScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  int _highlightedIndex = -1;

  final List<Map<String, dynamic>> _items = const [
    {
      'title': 'Fresh Oranges & Apples',
      'desc': 'Delicious fruits for health and energy.',
      'icon': Icons.apple_rounded,
      'category': 'Fruit',
    },
    {
      'title': 'Garden Pruning Shears',
      'desc': 'Tool for watering and trimming plants.',
      'icon': Icons.content_cut_rounded,
      'category': 'Tool',
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

  void _onCategorySelected(int index) {
    if (index == 0) {
      _finishGame();
    } else {
      ErrorlessLearningHandler.handleSelection(
        isCorrect: false,
        correctOptionTitle: 'Fresh Oranges & Apples',
        onGuideToCorrect: () {
          setState(() => _highlightedIndex = 0);
        },
      );
    }
  }

  Future<void> _finishGame() async {
    _stopwatch.stop();
    await ref.read(gameSessionProvider.notifier).recordCompletedSession(
      gameType: 'sort_category',
      durationSeconds: _stopwatch.elapsed.inSeconds,
    );
    if (mounted) context.push('/game-completion');
  }

  @override
  Widget build(BuildContext context) {
    return GameWrapper(
      title: 'Sort by Category',
      audioPromptText: 'Which item belongs to the Fruit category?',
      onBack: () => context.pop(),
      onSosPressed: () => context.push('/emergency'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Select the Fruit Item:',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.spaceL),
          Expanded(
            child: ListView.separated(
              itemCount: _items.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppDimensions.spaceM),
              itemBuilder: (ctx, i) {
                final item = _items[i];
                final isHighlighted = _highlightedIndex == i;

                return NenilCard(
                  title: item['title'] as String,
                  subtitle: item['desc'] as String,
                  icon: item['icon'] as IconData,
                  backgroundColor: isHighlighted ? AppColors.secondaryContainer : AppColors.surface,
                  onTap: () => _onCategorySelected(i),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
