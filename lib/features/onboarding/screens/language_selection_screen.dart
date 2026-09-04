import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/nenil_button.dart';
import '../../../shared/widgets/nenil_card.dart';
import '../providers/language_provider.dart';

class LanguageSelectionScreen extends ConsumerWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLang = ref.watch(languageProvider);

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
                    final isSelected = selectedLang == lang['code'];
                    return NenilCard(
                      title: lang['name']!,
                      icon: isSelected ? Icons.check_circle_rounded : Icons.language_rounded,
                      accentColor: isSelected ? AppColors.primary : AppColors.outline,
                      onTap: () {
                        ref.read(languageProvider.notifier).setLanguage(lang['code']!);
                      },
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
