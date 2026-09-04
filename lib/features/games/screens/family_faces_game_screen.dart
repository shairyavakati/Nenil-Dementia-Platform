import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/audio_prompt_widget.dart';
import '../../../shared/widgets/game_wrapper.dart';
import '../../../shared/widgets/nenil_button.dart';
import '../providers/game_session_provider.dart';

class FamilyFacesGameScreen extends ConsumerStatefulWidget {
  const FamilyFacesGameScreen({super.key});

  @override
  ConsumerState<FamilyFacesGameScreen> createState() => _FamilyFacesGameScreenState();
}

class _FamilyFacesGameScreenState extends ConsumerState<FamilyFacesGameScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  String? _selectedRelation;

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

  Future<void> _chooseRelation(String relation) async {
    setState(() => _selectedRelation = relation);
    _stopwatch.stop();

    await ref.read(gameSessionProvider.notifier).recordCompletedSession(
      gameType: 'family_faces',
      durationSeconds: _stopwatch.elapsed.inSeconds,
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) context.push('/game-completion');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GameWrapper(
      title: AppStrings.gameFamilyFaces,
      audioPromptText: 'Family Faces & Stories. Who is in this photo? Tap the matching name.',
      onBack: () => context.pop(),
      onSosPressed: () => context.push('/emergency'),
      child: Column(
        children: [
          Card(
            elevation: AppDimensions.elevationMedium,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusL)),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.spaceL),
              child: Column(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    ),
                    child: const Icon(Icons.face_rounded, size: 100, color: AppColors.primary),
                  ),
                  const SizedBox(height: AppDimensions.spaceM),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Family Festival Memory',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      AudioPromptWidget(textToSpeak: 'This photo was taken during Bihu festival celebrations with your family.'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceL),
          const Text(
            'Who is in this picture?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
          const SizedBox(height: AppDimensions.spaceM),
          Expanded(
            child: Column(
              children: [
                NenilButton(
                  label: 'Rahul (Son)',
                  icon: Icons.person_rounded,
                  backgroundColor: _selectedRelation == 'rahul' ? AppColors.success : AppColors.primary,
                  onPressed: () => _chooseRelation('rahul'),
                ),
                const SizedBox(height: AppDimensions.spaceM),
                NenilButton(
                  label: 'Priya (Daughter)',
                  icon: Icons.person_3_rounded,
                  backgroundColor: _selectedRelation == 'priya' ? AppColors.success : AppColors.secondary,
                  onPressed: () => _chooseRelation('priya'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
