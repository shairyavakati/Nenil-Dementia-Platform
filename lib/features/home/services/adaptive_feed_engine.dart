import 'package:flutter/foundation.dart';
import '../../../models/patient_model.dart';
import '../../../models/session_model.dart';

class ActivityRecommendation {
  final String id;
  final String title;
  final String description;
  final String iconName;
  final String route;
  final String category; // 'routine', 'memory', 'sensory', 'safety', 'reminiscence'
  final double priorityScore;

  const ActivityRecommendation({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.route,
    required this.category,
    required this.priorityScore,
  });
}

/// AdaptiveFeedEngine — Reddit-style personalization algorithm ranking games and activities based on patient profile and session logs.
class AdaptiveFeedEngine {
  static List<ActivityRecommendation> generatePersonalizedFeed({
    required PatientModel? patient,
    required List<SessionModel> sessionHistory,
    required DateTime currentTime,
  }) {
    final stage = patient?.stage ?? 'mild';
    final preferredLang = patient?.preferredLanguage ?? 'en';
    final hour = currentTime.hour;

    // 1. All available activity modules catalog
    final allModules = [
      const ActivityRecommendation(
        id: 'daily_routine',
        title: 'My Daily Routine',
        description: 'Morning to evening sequential routine practice',
        iconName: 'wb_sunny_rounded',
        route: '/game/daily_routine',
        category: 'routine',
        priorityScore: 10.0,
      ),
      const ActivityRecommendation(
        id: 'find_things',
        title: 'Find My Things',
        description: 'Object-location memory association for household items',
        iconName: 'search_rounded',
        route: '/game/find_things',
        category: 'memory',
        priorityScore: 9.0,
      ),
      const ActivityRecommendation(
        id: 'family_faces',
        title: 'Family Faces & Stories',
        description: 'Recognize family members with photo & voice stories',
        iconName: 'people_rounded',
        route: '/game/family_faces',
        category: 'reminiscence',
        priorityScore: 8.5,
      ),
      const ActivityRecommendation(
        id: 'music_memory',
        title: 'Music Memory Journey',
        description: 'Listen to regional NER folk tunes and familiar melodies',
        iconName: 'music_note_rounded',
        route: '/game/music_memory',
        category: 'sensory',
        priorityScore: 8.0,
      ),
      const ActivityRecommendation(
        id: 'emotion_match',
        title: 'Emotion Match',
        description: 'Gentle emotion recognition and expression cards',
        iconName: 'face_rounded',
        route: '/game/emotion_match',
        category: 'sensory',
        priorityScore: 7.5,
      ),
      const ActivityRecommendation(
        id: 'safe_choices',
        title: 'Safe Home Choices',
        description: 'Practice safe household decisions and awareness',
        iconName: 'shield_rounded',
        route: '/game/safe_choices',
        category: 'safety',
        priorityScore: 7.0,
      ),
      const ActivityRecommendation(
        id: 'picture_recipe',
        title: 'Picture Recipe Steps',
        description: 'Arrange step-by-step visual cards for tea and garden care',
        iconName: 'restaurant_menu_rounded',
        route: '/game/picture_recipe',
        category: 'routine',
        priorityScore: 7.0,
      ),
      const ActivityRecommendation(
        id: 'sort_category',
        title: 'Sort by Category',
        description: 'Sort visual cards into fruits, tools, and temple items',
        iconName: 'category_rounded',
        route: '/game/sort_category',
        category: 'memory',
        priorityScore: 6.5,
      ),
      const ActivityRecommendation(
        id: 'virtual_garden',
        title: 'Virtual Garden & Home Care',
        description: 'Water plants and feed garden birds with simple taps',
        iconName: 'eco_rounded',
        route: '/game/virtual_garden',
        category: 'sensory',
        priorityScore: 6.5,
      ),
      const ActivityRecommendation(
        id: 'comfort_choice',
        title: 'Comfort Choice Game',
        description: 'Choose tea, shawl, music, or seating preferences',
        iconName: 'chair_rounded',
        route: '/game/comfort_choice',
        category: 'sensory',
        priorityScore: 8.0,
      ),
      const ActivityRecommendation(
        id: 'call_help_practice',
        title: 'Call for Help Practice',
        description: 'Practice emergency SOS button tapping',
        iconName: 'emergency_rounded',
        route: '/game/call_help_practice',
        category: 'safety',
        priorityScore: 9.5,
      ),
      const ActivityRecommendation(
        id: 'word_match',
        title: 'Regional Word Match',
        description: 'Match regional NER language words to picture cards',
        iconName: 'translate_rounded',
        route: '/game/word_match',
        category: 'memory',
        priorityScore: 7.5,
      ),
      const ActivityRecommendation(
        id: 'photo_puzzle',
        title: 'Family Photo Puzzle',
        description: 'Assemble 4-tile visual family photo puzzle',
        iconName: 'extension_rounded',
        route: '/game/photo_puzzle',
        category: 'reminiscence',
        priorityScore: 8.0,
      ),
    ];

    // 2. Score adjustments based on time of day and stage
    final rankedModules = allModules.map((module) {
      double score = module.priorityScore;

      // Time-of-day boost
      if (hour >= 6 && hour < 12) {
        // Morning: Boost routine and garden
        if (module.category == 'routine') score += 3.0;
      } else if (hour >= 12 && hour < 17) {
        // Afternoon: Boost memory and safety
        if (module.category == 'memory' || module.category == 'safety') score += 2.5;
      } else {
        // Evening: Boost music and sensory relaxation
        if (module.category == 'sensory' || module.category == 'reminiscence') score += 3.5;
      }

      // Stage adjustments
      if (stage == 'severe') {
        if (module.id == 'comfort_choice' || module.id == 'music_memory' || module.id == 'emotion_match') {
          score += 5.0;
        } else if (module.id == 'safe_choices' || module.id == 'picture_recipe') {
          score -= 10.0; // Filter out complex tasks
        }
      } else if (stage == 'moderate') {
        if (module.id == 'safe_choices') score -= 5.0;
      }

      // Past engagement boost
      final completedCount = sessionHistory.where((s) => s.gameType == module.id).length;
      score += (completedCount * 0.5);

      return ActivityRecommendation(
        id: module.id,
        title: module.title,
        description: module.description,
        iconName: module.iconName,
        route: module.route,
        category: module.category,
        priorityScore: score,
      );
    }).toList();

    // Sort descending by priority score
    rankedModules.sort((a, b) => b.priorityScore.compareTo(a.priorityScore));

    debugPrint('[AdaptiveFeedEngine] Generated ${rankedModules.length} ranked recommendations for $stage stage.');
    return rankedModules;
  }
}
