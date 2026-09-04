import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../auth/providers/caregiver_auth_provider.dart';
import '../../auth/widgets/pin_input_dialog.dart';

class CaregiverDashboardScreen extends ConsumerWidget {
  const CaregiverDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleDashboard),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: AppDimensions.iconMedium),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Caregiver Control Hub',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppDimensions.spaceM),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.person_rounded, size: AppDimensions.iconLarge, color: AppColors.primary),
                  title: Text('Linked Patient Profile'),
                  subtitle: Text('Stage: Mild · Language: English / Assamese'),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceL),
              const Text(
                'Caregiver Actions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
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
                title: const StringText('Session Activity History'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () async {
                  await showDialog<bool>(
                    context: context,
                    builder: (ctx) => PinInputDialog(
                      onVerify: (pin) => ref.read(caregiverAuthProvider.notifier).verifyPin(pin),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.family_restroom_rounded, color: AppColors.primary),
                title: const StringText('Upload Family Photos & Music'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () async {
                  await showDialog<bool>(
                    context: context,
                    builder: (ctx) => PinInputDialog(
                      onVerify: (pin) => ref.read(caregiverAuthProvider.notifier).verifyPin(pin),
                    ),
                  );
                },
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
