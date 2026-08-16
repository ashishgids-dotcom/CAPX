import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/language_provider.dart';

/// First-launch language selection grid. Also reachable later via the
/// persistent globe icon on the dashboard (in "switch" mode, where picking
/// a language does not re-trigger onboarding).
class LanguageSelectionScreen extends StatelessWidget {
  final bool isSwitchMode;
  const LanguageSelectionScreen({super.key, this.isSwitchMode = false});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LanguageProvider>();

    return Scaffold(
      appBar: isSwitchMode
          ? AppBar(title: const Text('Change Language / भाषा बदलें'))
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!isSwitchMode) ...[
                const SizedBox(height: 24),
                const Icon(Icons.language, size: 56, color: AppColors.royalBlue),
                const SizedBox(height: 8),
                const Text(
                  'CAPX - Financial & Merchant Suite',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Choose your language\nअपनी भाषा चुनें',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 28),
              ],
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.3,
                  ),
                  itemCount: AppLanguage.values.length,
                  itemBuilder: (context, index) {
                    final lang = AppLanguage.values[index];
                    final isSelected = provider.language == lang && provider.hasOnboarded;

                    return _LanguageCard(
                      language: lang,
                      isSelected: isSelected,
                      onTap: () async {
                        await provider.setLanguage(lang);
                        if (context.mounted) {
                          if (isSwitchMode) {
                            context.pop();
                          } else {
                            context.go('/dashboard');
                          }
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final AppLanguage language;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.emeraldGreen : Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected ? AppColors.emeraldGreen : AppColors.cardBorder,
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            language.nativeName,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
