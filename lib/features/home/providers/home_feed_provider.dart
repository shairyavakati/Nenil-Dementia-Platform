import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/patient_model.dart';
import '../../../models/routine_model.dart';
import '../../../storage/database/app_database.dart';
import '../../onboarding/providers/patient_profile_provider.dart';

class HomeFeedState {
  final String greetingText;
  final String timeOfDay; // 'morning', 'afternoon', 'evening'
  final PatientModel? patient;
  final List<RoutineModel> routines;
  final List<Map<String, dynamic>> recommendedGames;
  final bool isLoading;

  const HomeFeedState({
    required this.greetingText,
    required this.timeOfDay,
    this.patient,
    this.routines = const [],
    this.recommendedGames = const [],
    this.isLoading = false,
  });

  HomeFeedState copyWith({
    String? greetingText,
    String? timeOfDay,
    PatientModel? patient,
    List<RoutineModel>? routines,
    List<Map<String, dynamic>>? recommendedGames,
    bool? isLoading,
  }) {
    return HomeFeedState(
      greetingText: greetingText ?? this.greetingText,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      patient: patient ?? this.patient,
      routines: routines ?? this.routines,
      recommendedGames: recommendedGames ?? this.recommendedGames,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class HomeFeedNotifier extends StateNotifier<HomeFeedState> {
  final Ref ref;

  HomeFeedNotifier(this.ref) : super(_initialState()) {
    loadHomeFeedData();
  }

  static HomeFeedState _initialState() {
    final hour = DateTime.now().hour;
    String greeting;
    String tod;

    if (hour < 12) {
      greeting = 'Good Morning!';
      tod = 'morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon!';
      tod = 'afternoon';
    } else {
      greeting = 'Good Evening!';
      tod = 'evening';
    }

    return HomeFeedState(
      greetingText: greeting,
      timeOfDay: tod,
      isLoading: true,
    );
  }

  Future<void> loadHomeFeedData() async {
    try {
      final db = await AppDatabase.database;

      // 1. Fetch latest patient profile
      final patientMaps = await db.query('patients', limit: 1, orderBy: 'created_at DESC');
      PatientModel? patient;
      if (patientMaps.isNotEmpty) {
        patient = PatientModel.fromMap(patientMaps.first);
      }

      // 2. Fetch routines for current time of day
      final routineMaps = await db.query(
        'routines',
        where: 'time_of_day = ?',
        whereArgs: [state.timeOfDay],
      );
      final routines = routineMaps.map((m) => RoutineModel.fromMap(m)).toList();

      // If no routines in DB, load default routine items
      final activeRoutines = routines.isNotEmpty ? routines : _defaultRoutines(state.timeOfDay);

      // 3. Filter recommended games based on dementia stage
      final stage = patient?.stage ?? ref.read(patientProfileProvider).stage;
      final games = _filterGamesByStage(stage);

      state = state.copyWith(
        patient: patient,
        routines: activeRoutines,
        recommendedGames: games,
        isLoading: false,
      );
      debugPrint('[HomeFeedNotifier] Loaded home feed for stage: $stage');
    } catch (e) {
      debugPrint('[HomeFeedNotifier] Error loading home feed: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  List<RoutineModel> _defaultRoutines(String tod) {
    if (tod == 'morning') {
      return const [
        RoutineModel(id: 'r1', patientId: 'p1', title: 'Enjoy Warm Morning Tea', timeOfDay: 'morning', iconName: 'local_cafe'),
        RoutineModel(id: 'r2', patientId: 'p1', title: 'Water Garden Plants', timeOfDay: 'morning', iconName: 'eco'),
      ];
    } else if (tod == 'afternoon') {
      return const [
        RoutineModel(id: 'r3', patientId: 'p1', title: 'Afternoon Rest & Music', timeOfDay: 'afternoon', iconName: 'music_note'),
      ];
    } else {
      return const [
        RoutineModel(id: 'r4', patientId: 'p1', title: 'Family Evening Conversation', timeOfDay: 'evening', iconName: 'people'),
      ];
    }
  }

  List<Map<String, dynamic>> _filterGamesByStage(String stage) {
    final allGames = [
      {
        'id': 'daily_routine',
        'title': 'My Daily Routine',
        'subtitle': 'Morning visual guide & habits',
        'icon': 'wb_sunny_rounded',
      },
      {
        'id': 'find_things',
        'title': 'Find My Things',
        'subtitle': 'Find your reading glasses',
        'icon': 'search_rounded',
      },
      {
        'id': 'family_faces',
        'title': 'Family Faces & Stories',
        'subtitle': 'Stories of family members',
        'icon': 'people_rounded',
      },
      {
        'id': 'music_memory',
        'title': 'Music Memory Journey',
        'subtitle': 'Folk songs & regional music',
        'icon': 'music_note_rounded',
      },
      {
        'id': 'emotion_match',
        'title': 'Emotion Match',
        'subtitle': 'Facial expression recognition',
        'icon': 'sentiment_satisfied_alt_rounded',
      },
    ];

    if (stage == 'severe') {
      // Severe stage: 1 primary focal activity (Music & Memory)
      return [allGames[3]];
    } else if (stage == 'moderate') {
      // Moderate stage: 2 primary focal activities
      return [allGames[0], allGames[2]];
    } else {
      // Mild stage: All activities available
      return allGames;
    }
  }

  Future<void> toggleRoutineCompletion(String routineId) async {
    final updated = state.routines.map((r) {
      if (r.id == routineId) {
        return RoutineModel(
          id: r.id,
          patientId: r.patientId,
          title: r.title,
          timeOfDay: r.timeOfDay,
          audioPromptPath: r.audioPromptPath,
          iconName: r.iconName,
          isCompleted: !r.isCompleted,
        );
      }
      return r;
    }).toList();

    state = state.copyWith(routines: updated);
  }
}

final homeFeedProvider = StateNotifierProvider<HomeFeedNotifier, HomeFeedState>((ref) {
  return HomeFeedNotifier(ref);
});
