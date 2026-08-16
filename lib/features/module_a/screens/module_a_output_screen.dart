import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../../language_selection/providers/language_provider.dart';
import '../providers/module_a_provider.dart';
import '../widgets/allocation_donut_chart.dart';
import '../widgets/audio_summary_player.dart';
import '../widgets/historical_reference_ranges.dart';
import '../widgets/scam_detector_widget.dart';

class ModuleAOutputScreen extends StatelessWidget {
  const ModuleAOutputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ModuleAProvider>();
    final language = context.watch<LanguageProvider>().language;
    final result = provider.result;

    if (provider.paymentStatus != PaymentStatus.success || result == null) {
      return const Scaffold(
        body: Center(child: Text('Please complete payment first.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Your Savings Split')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Top-of-screen badge: sits right next to the numbers, not just
          // buried in a footer marquee.
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: AppColors.royalBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.verified_user_outlined, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    AppStrings.notSebiBadge(language),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: AllocationDonutChart(result: result),
            ),
          ),
          const SizedBox(height: 16),

          HistoricalReferenceRanges(result: result),
          const SizedBox(height: 16),

          AudioSummaryPlayer(languageCode: language.code),
          const SizedBox(height: 16),
          const ScamDetectorWidget(),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.royalBlue.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              AppStrings.globalDisclaimer(language),
              style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
