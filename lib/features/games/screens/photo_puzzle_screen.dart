import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/game_wrapper.dart';
import '../../../shared/widgets/nenil_button.dart';
import '../providers/game_session_provider.dart';

class PhotoPuzzleScreen extends ConsumerStatefulWidget {
  const PhotoPuzzleScreen({super.key});

  @override
  ConsumerState<PhotoPuzzleScreen> createState() => _PhotoPuzzleScreenState();
}

class _PhotoPuzzleScreenState extends ConsumerState<PhotoPuzzleScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  final List<bool> _placedTiles = [false, false, false, false];

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

  void _onTileTap(int index) {
    setState(() {
      _placedTiles[index] = true;
    });

    if (_placedTiles.every((placed) => placed)) {
      _finishGame();
    }
  }

  Future<void> _finishGame() async {
    _stopwatch.stop();
    await ref.read(gameSessionProvider.notifier).recordCompletedSession(
      gameType: 'photo_puzzle',
      durationSeconds: _stopwatch.elapsed.inSeconds,
    );
    if (mounted) context.push('/game-completion');
  }

  @override
  Widget build(BuildContext context) {
    final int completedCount = _placedTiles.where((p) => p).length;

    return GameWrapper(
      title: 'Family Photo Puzzle',
      audioPromptText: 'Tap each puzzle piece to assemble your family memory photo.',
      onBack: () => context.pop(),
      onSosPressed: () => context.push('/emergency'),
      child: Column(
        children: [
          const Text(
            'Assemble the Family Photo:',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.spaceL),
          Expanded(
            child: GridView.builder(
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppDimensions.spaceM,
                mainAxisSpacing: AppDimensions.spaceM,
              ),
              itemBuilder: (ctx, i) {
                final isPlaced = _placedTiles[i];

                return GestureDetector(
                  onTap: () => _onTileTap(i),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isPlaced ? AppColors.primaryContainer : AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                      border: Border.all(
                        color: isPlaced ? AppColors.primary : AppColors.outline,
                        width: 3,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isPlaced ? Icons.family_restroom_rounded : Icons.extension_rounded,
                          size: 56,
                          color: isPlaced ? AppColors.primary : AppColors.onBackground.withOpacity(0.5),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isPlaced ? 'Tile ${i + 1} Set!' : 'Tap Piece ${i + 1}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isPlaced ? AppColors.primary : AppColors.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppDimensions.spaceL),
          NenilButton(
            label: completedCount == 4 ? 'Photo Assembled!' : 'Pieces Placed: $completedCount / 4',
            icon: Icons.check_circle_rounded,
            onPressed: () {
              if (completedCount == 4) _finishGame();
            },
          ),
        ],
      ),
    );
  }
}
