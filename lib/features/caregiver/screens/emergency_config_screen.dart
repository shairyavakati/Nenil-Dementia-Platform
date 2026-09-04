import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/nenil_button.dart';
import '../../emergency/providers/emergency_provider.dart';

class EmergencyConfigScreen extends ConsumerStatefulWidget {
  const EmergencyConfigScreen({super.key});

  @override
  ConsumerState<EmergencyConfigScreen> createState() => _EmergencyConfigScreenState();
}

class _EmergencyConfigScreenState extends ConsumerState<EmergencyConfigScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController.text = ref.read(emergencyProvider).primaryContactPhone;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _saveContact() {
    final phone = _phoneController.text.trim();
    if (phone.isNotEmpty) {
      ref.read(emergencyProvider.notifier).updatePrimaryContact(phone);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Primary emergency contact updated!')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contacts Config'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: AppDimensions.iconMedium),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Configure Primary Caregiver Contact',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppDimensions.spaceS),
              const Text(
                'This number will be dialed immediately when the patient presses the SOS button or triggers a voice emergency call.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: AppDimensions.spaceXL),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Primary Caregiver Phone Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone_rounded),
                ),
              ),
              const Spacer(),
              NenilButton(
                label: 'Save Emergency Number',
                onPressed: _saveContact,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
