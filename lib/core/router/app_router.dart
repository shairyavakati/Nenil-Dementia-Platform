import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/screens/caregiver_auth_screen.dart';
import '../../features/auth/screens/pin_setup_screen.dart';
import '../../features/caregiver/screens/caregiver_dashboard_screen.dart';
import '../../features/caregiver/screens/voice_recording_screen.dart';
import '../../features/emergency/screens/emergency_screen.dart';
import '../../features/games/screens/daily_routine_game_screen.dart';
import '../../features/games/screens/emotion_match_game_screen.dart';
import '../../features/games/screens/family_faces_game_screen.dart';
import '../../features/games/screens/find_my_things_game_screen.dart';
import '../../features/games/screens/game_completion_screen.dart';
import '../../features/games/screens/game_module_screen.dart';
import '../../features/games/screens/music_memory_game_screen.dart';
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

    // Sprint 3 Game Module Routes
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
    GoRoute(
      path: '/caregiver-dashboard',
      builder: (context, state) => const CaregiverDashboardScreen(),
    ),
    GoRoute(
      path: '/voice-recording',
      builder: (context, state) => const VoiceRecordingScreen(),
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
