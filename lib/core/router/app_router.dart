import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/screens/caregiver_auth_screen.dart';
import '../../features/caregiver/screens/caregiver_dashboard_screen.dart';
import '../../features/emergency/screens/emergency_screen.dart';
import '../../features/games/screens/game_completion_screen.dart';
import '../../features/games/screens/game_module_screen.dart';
import '../../features/home/screens/patient_home_screen.dart';
import '../../features/onboarding/screens/language_selection_screen.dart';
import '../../features/onboarding/screens/patient_profile_screen.dart';
import '../../features/onboarding/screens/splash_screen.dart';
import '../../features/onboarding/screens/stage_selection_screen.dart';

/// AppRouter — GoRouter configuration managing all 10 screen routes in the Screen Build Order.
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
    GoRoute(
      path: '/game/:gameId',
      builder: (context, state) {
        final gameId = state.pathParameters['gameId'] ?? 'routine';
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
