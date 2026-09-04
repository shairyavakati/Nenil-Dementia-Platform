import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../auth/providers/caregiver_auth_provider.dart';
import '../../auth/widgets/pin_input_dialog.dart';
import '../providers/caregiver_dashboard_provider.dart';
import '../widgets/caregiver_insights_widget.dart';

class CaregiverDashboardScreen extends ConsumerWidget {
  const CaregiverDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashState = ref.watch(caregiverDashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleDashboard),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: AppDimensions.iconMedium),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.spaceL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Caregiver Control Hub',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppDimensions.spaceM),

              // 1. Patient Summary Header
              Card(
                child: ListTile(
                  leading: const Icon(Icons.person_rounded, size: AppDimensions.iconLarge, color: AppColors.primary),
                  title: const Text('Linked Patient Profile'),
                  subtitle: const Text('Stage: Mild · Language: English / Assamese'),
                  trailing: TextButton(
                    onPressed: () => context.push('/patient-linking'),
                    child: const Text('Pair Device'),
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceL),

              // 2. Insights Panel
              CaregiverInsightsWidget(
                totalSessions: dashState.totalSessionsCompleted,
                totalMinutes: dashState.totalMinutesEngaged,
                favoriteGame: dashState.favoriteGame,
              ),
              const SizedBox(height: AppDimensions.spaceL),

              // 3. Caregiver Actions List
              const Text(
                'Caregiver Tools',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
              const SizedBox(height: AppDimensions.spaceS),
              ListTile(
                leading: const Icon(Icons.mic_rounded, color: AppColors.primary),
                title: const StringText('Record Custom Voice Prompts'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () async {
                  final unlocked = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => PinInputDialog(
                      onVerify: (pin) => ref.read(caregiverAuthProvider.notifier).verifyPin(pin),
                    ),
                  );
                  if (unlocked == true && context.mounted) {
                    context.push('/voice-recording');
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.history_rounded, color: AppColors.primary),
                title: const StringText('Session Activity History Logs'),
                subtitle: Text('${dashState.totalSessionsCompleted} completed sessions'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () async {
                  final unlocked = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => PinInputDialog(
                      onVerify: (pin) => ref.read(caregiverAuthProvider.notifier).verifyPin(pin),
                    ),
                  );
                  if (unlocked == true && context.mounted) {
                    context.push('/session-history');
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.link_rounded, color: AppColors.primary),
                title: const StringText('Pair Patient & Caregiver Devices'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => context.push('/patient-linking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StringText extends StatelessWidget {
  final String text;
  const StringText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600));
  }
}
