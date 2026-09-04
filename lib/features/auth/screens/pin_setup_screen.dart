import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/nenil_button.dart';

class PinSetupScreen extends ConsumerStatefulWidget {
  const PinSetupScreen({super.key});

  @override
  ConsumerState<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends ConsumerState<PinSetupScreen> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  void _savePin() {
    final pin = _pinController.text.trim();
    final confirm = _confirmPinController.text.trim();

    if (pin.length != 4 || int.tryParse(pin) == null) {
      setState(() => _errorMessage = 'PIN must be exactly 4 digits');
      return;
    }

    if (pin != confirm) {
      setState(() => _errorMessage = 'PINs do not match');
      return;
    }

    // Save PIN hash via provider or direct navigation
    context.push('/patient-profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Caregiver PIN')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create a 4-Digit Security PIN',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppDimensions.spaceS),
              const Text(
                'This PIN prevents elderly patients from accidentally altering app settings or routines.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: AppDimensions.spaceXL),
              TextField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscureText: true,
                style: const TextStyle(fontSize: 24, letterSpacing: 8),
                decoration: const InputDecoration(
                  labelText: '4-Digit PIN',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceM),
              TextField(
                controller: _confirmPinController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscureText: true,
                style: const TextStyle(fontSize: 24, letterSpacing: 8),
                decoration: const InputDecoration(
                  labelText: 'Confirm 4-Digit PIN',
                  border: OutlineInputBorder(),
                ),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: AppDimensions.spaceS),
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: AppColors.emergency, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
              const Spacer(),
              NenilButton(
                label: 'Save PIN & Continue',
                onPressed: _savePin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
