import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/game_wrapper.dart';
import '../../../shared/widgets/nenil_card.dart';
import '../providers/game_session_provider.dart';

class FindMyThingsGameScreen extends ConsumerStatefulWidget {
  const FindMyThingsGameScreen({super.key});

  @override
  ConsumerState<FindMyThingsGameScreen> createState() => _FindMyThingsGameScreenState();
}

class _FindMyThingsGameScreenState extends ConsumerState<FindMyThingsGameScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  String? _selectedObject;

  final List<Map<String, dynamic>> _items = const [
    {
      'id': 'glasses',
      'name': 'Reading Glasses',
      'location': 'On the bedside wooden table',
      'icon': Icons.visibility_rounded,
    },
    {
      'id': 'keys',
      'name': 'House Keys',
      'location': 'Hanging on the wall key hook',
      'icon': Icons.vpn_key_rounded,
    },
    {
      'id': 'book',
      'name': 'Favorite Storybook',
      'location': 'On the living room shelf',
      'icon': Icons.menu_book_rounded,
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

  Future<void> _selectItem(String id) async {
    setState(() => _selectedObject = id);
    _stopwatch.stop();

    await ref.read(gameSessionProvider.notifier).recordCompletedSession(
      gameType: 'find_my_things',
      durationSeconds: _stopwatch.elapsed.inSeconds,
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) context.push('/game-completion');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GameWrapper(
      title: AppStrings.gameFindThings,
      audioPromptText: 'Find My Things. Where are your reading glasses located?',
      onBack: () => context.pop(),
      onSosPressed: () => context.push('/emergency'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Where do we keep your Reading Glasses?',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
          const SizedBox(height: AppDimensions.spaceS),
          const Text(
            'Tap the card showing where your glasses belong.',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: AppDimensions.spaceL),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                final isSelected = _selectedObject == item['id'];
                return NenilCard(
                  title: item['name'] as String,
                  subtitle: item['location'] as String,
                  icon: item['icon'] as IconData,
                  accentColor: isSelected ? AppColors.success : AppColors.primary,
                  onTap: () => _selectItem(item['id'] as String),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
