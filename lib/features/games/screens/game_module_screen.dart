import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/game_wrapper.dart';
import '../../../shared/widgets/nenil_button.dart';

class GameModuleScreen extends StatelessWidget {
  final String gameId;

  const GameModuleScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return GameWrapper(
      title: 'Cognitive Activity',
      audioPromptText: 'Tap the matching card to complete the exercise.',
      onBack: () => context.pop(),
      onSosPressed: () => context.push('/emergency'),
      child: Column(
        children: [
          const Expanded(
            child: Center(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.spaceXXL),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.stars_rounded, size: AppDimensions.iconHuge, color: AppColors.primary),
                      SizedBox(height: AppDimensions.spaceM),
                      Text(
                        'Calm Cognitive Game Placeholder',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          NenilButton(
            label: 'Complete Exercise',
            onPressed: () => context.push('/game-completion'),
          ),
        ],
      ),
    );
  }
}
