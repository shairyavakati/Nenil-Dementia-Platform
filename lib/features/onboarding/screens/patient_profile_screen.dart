import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/nenil_button.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});

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
                'Patient Details',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppDimensions.spaceL),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Patient Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const Spacer(),
              NenilButton(
                label: 'Next: Select Dementia Stage',
                onPressed: () => context.push('/stage-selection'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
