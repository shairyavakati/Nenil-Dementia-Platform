import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/nenil_card.dart';

class JourneyFeedWidget extends StatelessWidget {
  final List<Map<String, dynamic>> games;

  const JourneyFeedWidget({super.key, required this.games});

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'wb_sunny_rounded':
        return Icons.wb_sunny_rounded;
      case 'search_rounded':
        return Icons.search_rounded;
      case 'people_rounded':
        return Icons.people_rounded;
      case 'music_note_rounded':
        return Icons.music_note_rounded;
      case 'sentiment_satisfied_alt_rounded':
        return Icons.sentiment_satisfied_alt_rounded;
      default:
        return Icons.sports_esports_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cognitive Activities',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceS),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: games.length,
          itemBuilder: (context, index) {
            final game = games[index];
            return NenilCard(
              title: game['title'] as String,
              subtitle: game['subtitle'] as String?,
              icon: _getIconData(game['icon'] as String),
              onTap: () => context.push('/game/${game['id']}'),
            );
          },
        ),
      ],
    );
  }
}
