import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/nenil_button.dart';
import '../../../shared/widgets/nenil_card.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLang = 'en';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.titleLanguage)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select your preferred language / ভাষা বাছক',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppDimensions.spaceL),
              Expanded(
                child: ListView.builder(
                  itemCount: AppStrings.languages.length,
                  itemBuilder: (context, index) {
                    final lang = AppStrings.languages[index];
                    final isSelected = _selectedLang == lang['code'];
                    return NenilCard(
                      title: lang['name']!,
                      icon: isSelected ? Icons.check_circle_rounded : Icons.language_rounded,
                      accentColor: isSelected ? AppColors.primary : AppColors.outline,
                      onTap: () => setState(() => _selectedLang = lang['code']!),
                    );
                  },
                ),
              ),
              NenilButton(
                label: AppStrings.btnContinue,
                onPressed: () => context.push('/auth'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
