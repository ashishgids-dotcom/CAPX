import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/marquee_disclaimer.dart';
import '../../language_selection/providers/language_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    final lang = languageProvider.language;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppStrings.t('app_name', lang)),
            Text(
              AppStrings.t('app_tagline', lang),
              style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w400, color: Colors.white70),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Change language',
            icon: const Text('🌐', style: TextStyle(fontSize: 22)),
            onPressed: () => context.push('/language?switch=true'),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _TierCard(
                  color: AppColors.emeraldGreen,
                  icon: Icons.savings_rounded,
                  title: AppStrings.t('card_a_title', lang),
                  price: AppStrings.t('card_a_price', lang),
                  onTap: () => context.push('/module-a-disclaimer'),
                ),
                const SizedBox(height: 16),
                _TierCard(
                  color: AppColors.royalBlue,
                  icon: Icons.storefront_rounded,
                  title: AppStrings.t('card_b_title', lang),
                  price: AppStrings.t('card_b_price', lang),
                  onTap: () => context.push('/module-b'),
                ),
                const SizedBox(height: 16),
                _TierCard(
                  color: const Color(0xFF1F2937),
                  icon: Icons.rocket_launch_rounded,
                  title: AppStrings.t('card_c_title', lang),
                  price: AppStrings.t('card_c_price', lang),
                  onTap: () => context.push('/module-c'),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          MarqueeDisclaimer(language: lang),
        ],
      ),
    );
  }
}

class _TierCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String price;
  final VoidCallback onTap;

  const _TierCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.75)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                child: Icon(icon, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      price,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
