import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/nenil_button.dart';
import '../providers/patient_profile_provider.dart';

class PatientProfileScreen extends ConsumerStatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  ConsumerState<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends ConsumerState<PatientProfileScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter patient\'s name')),
      );
      return;
    }

    ref.read(patientProfileProvider.notifier).setName(name);
    context.push('/stage-selection');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.titlePatientProfile)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Patient Profile Setup',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppDimensions.spaceS),
              const Text(
                'Enter the elderly patient\'s details for personalized cognitive journey guidance.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: AppDimensions.spaceL),
              Center(
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: AppColors.primaryContainer,
                  child: Icon(Icons.person_rounded, size: 64, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceL),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Patient Full Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge_rounded),
                ),
              ),
              const Spacer(),
              NenilButton(
                label: 'Next: Select Dementia Stage',
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
