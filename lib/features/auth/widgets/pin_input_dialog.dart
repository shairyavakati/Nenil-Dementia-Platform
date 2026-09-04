import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/nenil_button.dart';

class PinInputDialog extends StatefulWidget {
  final bool Function(String pin) onVerify;

  const PinInputDialog({super.key, required this.onVerify});

  @override
  State<PinInputDialog> createState() => _PinInputDialogState();
}

class _PinInputDialogState extends State<PinInputDialog> {
  final TextEditingController _pinController = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _verify() {
    final pin = _pinController.text.trim();
    if (widget.onVerify(pin)) {
      Navigator.of(context).pop(true);
    } else {
      setState(() => _error = 'Incorrect PIN. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Caregiver PIN', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Please enter your 4-digit PIN to access Caregiver Mode.'),
          const SizedBox(height: AppDimensions.spaceM),
          TextField(
            controller: _pinController,
            keyboardType: TextInputType.number,
            maxLength: 4,
            obscureText: true,
            autofocus: true,
            style: const TextStyle(fontSize: 24, letterSpacing: 8),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '••••',
            ),
          ),
          if (_error != null)
            Text(_error!, style: const TextStyle(color: AppColors.emergency, fontSize: 14)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel', style: TextStyle(fontSize: 18)),
        ),
        SizedBox(
          width: 120,
          child: NenilButton(
            label: 'Unlock',
            onPressed: _verify,
          ),
        ),
      ],
    );
  }
}
