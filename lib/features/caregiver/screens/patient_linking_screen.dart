import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/nenil_button.dart';

class PatientLinkingScreen extends StatefulWidget {
  const PatientLinkingScreen({super.key});

  @override
  State<PatientLinkingScreen> createState() => _PatientLinkingScreenState();
}

class _PatientLinkingScreenState extends State<PatientLinkingScreen> {
  final TextEditingController _codeController = TextEditingController();
  bool _isLinked = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _linkPatient() {
    if (_codeController.text.trim().length >= 6) {
      setState(() => _isLinked = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Link Patient Account'),
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
                'Pair Patient & Caregiver Device',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppDimensions.spaceS),
              const Text(
                'Enter the 6-digit pairing code shown on the patient\'s device to enable remote oversight and sync.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: AppDimensions.spaceXL),
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                style: const TextStyle(fontSize: 28, letterSpacing: 12, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: '6-Digit Pairing Code',
                  border: OutlineInputBorder(),
                  hintText: '849201',
                ),
              ),
              if (_isLinked) ...[
                const SizedBox(height: AppDimensions.spaceM),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_rounded, color: AppColors.success, size: 28),
                    SizedBox(width: 8),
                    Text('Patient Device Successfully Linked!', style: TextStyle(color: AppColors.success, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
              const Spacer(),
              NenilButton(
                label: _isLinked ? 'Done' : 'Link Patient Device',
                onPressed: _isLinked ? () => context.pop() : _linkPatient,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
