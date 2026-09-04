import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/nenil_button.dart';
import '../providers/caregiver_auth_provider.dart';

class CaregiverAuthScreen extends ConsumerStatefulWidget {
  const CaregiverAuthScreen({super.key});

  @override
  ConsumerState<CaregiverAuthScreen> createState() => _CaregiverAuthScreenState();
}

class _CaregiverAuthScreenState extends ConsumerState<CaregiverAuthScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _relationship = 'Son / Daughter';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter caregiver name and phone number')),
      );
      return;
    }

    final success = await ref.read(caregiverAuthProvider.notifier).registerCaregiver(
      name: name,
      phone: phone,
      relationship: _relationship,
      pin: '1234',
    );

    if (success && mounted) {
      context.push('/pin-setup');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(caregiverAuthProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.titleCaregiverAuth)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.spaceL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Caregiver Registration',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppDimensions.spaceS),
              const Text(
                'Register as a caregiver to manage patient profiles, record voice prompts, and view progress.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: AppDimensions.spaceL),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Caregiver Full Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_rounded),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceM),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number (Emergency Contact)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone_rounded),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceM),
              DropdownButtonFormField<String>(
                value: _relationship,
                decoration: const InputDecoration(
                  labelText: 'Relationship to Patient',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.family_restroom_rounded),
                ),
                items: const [
                  DropdownMenuItem(value: 'Son / Daughter', child: Text('Son / Daughter')),
                  DropdownMenuItem(value: 'Spouse', child: Text('Spouse')),
                  DropdownMenuItem(value: 'Grandchild', child: Text('Grandchild')),
                  DropdownMenuItem(value: 'Professional Nurse / Caregiver', child: Text('Professional Caregiver')),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _relationship = val);
                },
              ),
              const SizedBox(height: AppDimensions.spaceXXL),
              NenilButton(
                label: state.isLoading ? 'Registering...' : 'Register & Set Security PIN',
                onPressed: state.isLoading ? () {} : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
