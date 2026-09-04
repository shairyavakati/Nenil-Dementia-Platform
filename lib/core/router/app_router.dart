import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/screens/caregiver_auth_screen.dart';
import '../../features/auth/screens/pin_setup_screen.dart';
import '../../features/caregiver/screens/caregiver_dashboard_screen.dart';
import '../../features/caregiver/screens/emergency_config_screen.dart';
import '../../features/caregiver/screens/patient_linking_screen.dart';
import '../../features/caregiver/screens/session_history_screen.dart';
import '../../features/caregiver/screens/voice_recording_screen.dart';
import '../../features/emergency/screens/emergency_screen.dart';
import '../../features/games/screens/call_for_help_practice_screen.dart';
import '../../features/games/screens/comfort_choice_screen.dart';
import '../../features/games/screens/daily_routine_game_screen.dart';
import '../../features/games/screens/emotion_match_game_screen.dart';
import '../../features/games/screens/family_faces_game_screen.dart';
import '../../features/games/screens/find_my_things_game_screen.dart';
import '../../features/games/screens/game_completion_screen.dart';
import '../../features/games/screens/game_module_screen.dart';
import '../../features/games/screens/music_memory_game_screen.dart';
import '../../features/games/screens/photo_puzzle_screen.dart';
import '../../features/games/screens/picture_recipe_screen.dart';
import '../../features/games/screens/safe_home_choices_screen.dart';
import '../../features/games/screens/sort_category_screen.dart';
import '../../features/games/screens/virtual_garden_screen.dart';
import '../../features/games/screens/word_match_game_screen.dart';
import '../../features/home/screens/patient_home_screen.dart';
import '../../features/onboarding/screens/language_selection_screen.dart';
import '../../features/onboarding/screens/patient_profile_screen.dart';
import '../../features/onboarding/screens/splash_screen.dart';
import '../../features/onboarding/screens/stage_selection_screen.dart';

/// AppRouter — GoRouter configuration managing all screen routes in Nenil.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/language',
      builder: (context, state) => const LanguageSelectionScreen(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const CaregiverAuthScreen(),
    ),
    GoRoute(
      path: '/pin-setup',
      builder: (context, state) => const PinSetupScreen(),
    ),
    GoRoute(
      path: '/patient-profile',
      builder: (context, state) => const PatientProfileScreen(),
    ),
    GoRoute(
      path: '/stage-selection',
      builder: (context, state) => const StageSelectionScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const PatientHomeScreen(),
    ),

    // Game Module Routes
    GoRoute(
      path: '/game/daily_routine',
      builder: (context, state) => const DailyRoutineGameScreen(),
    ),
    GoRoute(
      path: '/game/find_things',
      builder: (context, state) => const FindMyThingsGameScreen(),
    ),
    GoRoute(
      path: '/game/family_faces',
      builder: (context, state) => const FamilyFacesGameScreen(),
    ),
    GoRoute(
      path: '/game/music_memory',
      builder: (context, state) => const MusicMemoryGameScreen(),
    ),
    GoRoute(
      path: '/game/emotion_match',
      builder: (context, state) => const EmotionMatchGameScreen(),
    ),
    GoRoute(
      path: '/game/safe_choices',
      builder: (context, state) => const SafeHomeChoicesScreen(),
    ),
    GoRoute(
      path: '/game/picture_recipe',
      builder: (context, state) => const PictureRecipeScreen(),
    ),
    GoRoute(
      path: '/game/sort_category',
      builder: (context, state) => const SortCategoryScreen(),
    ),
    GoRoute(
      path: '/game/virtual_garden',
      builder: (context, state) => const VirtualGardenScreen(),
    ),
    GoRoute(
      path: '/game/comfort_choice',
      builder: (context, state) => const ComfortChoiceScreen(),
    ),
    GoRoute(
      path: '/game/call_help_practice',
      builder: (context, state) => const CallForHelpPracticeScreen(),
    ),
    GoRoute(
      path: '/game/word_match',
      builder: (context, state) => const WordMatchGameScreen(),
    ),
    GoRoute(
      path: '/game/photo_puzzle',
      builder: (context, state) => const PhotoPuzzleScreen(),
    ),
    GoRoute(
      path: '/game/:gameId',
      builder: (context, state) {
        final gameId = state.pathParameters['gameId'] ?? 'daily_routine';
        return GameModuleScreen(gameId: gameId);
      },
    ),

    GoRoute(
      path: '/game-completion',
      builder: (context, state) => const GameCompletionScreen(),
    ),

    // Caregiver Companion Routes
    GoRoute(
      path: '/caregiver-dashboard',
      builder: (context, state) => const CaregiverDashboardScreen(),
    ),
    GoRoute(
      path: '/session-history',
      builder: (context, state) => const SessionHistoryScreen(),
    ),
    GoRoute(
      path: '/patient-linking',
      builder: (context, state) => const PatientLinkingScreen(),
    ),
    GoRoute(
      path: '/voice-recording',
      builder: (context, state) => const VoiceRecordingScreen(),
    ),
    GoRoute(
      path: '/emergency-config',
      builder: (context, state) => const EmergencyConfigScreen(),
    ),

    GoRoute(
      path: '/emergency',
      builder: (context, state) => const EmergencyScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Route Error: ${state.error}'),
    ),
  ),
);
