import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../../language_selection/providers/language_provider.dart';
import '../logic/allocation_logic.dart';

/// -----------------------------------------------------------------------
/// IMPORTANT — read before touching this file
/// -----------------------------------------------------------------------
/// This widget deliberately does NOT show a "% chance your money will
/// grow" or any similar forward-looking probability for a specific user's
/// investment. Manufacturing a specific success-probability number for an
/// individual's money is a forecast/recommendation with no real statistical
/// basis behind it, and is exactly the kind of output that turns an
/// educational calculator into unlicensed personalized investment advice —
/// a disclaimer next to a fabricated number doesn't fix that, because the
/// number itself is the problem.
///
/// What this shows instead: well-known, generic, PAST/historical reference
/// ranges for each asset category (the kind of information published by
/// the Post Office / RBI / long-term market data), clearly labeled as
/// historical and non-predictive. If you later want real numbers here,
/// source them from an official published rate table and keep them
/// generic (not tied to the user's specific input amount) — never turn
/// this into a personalized return forecast.
class HistoricalReferenceRanges extends StatelessWidget {
  final AllocationResult result;
  const HistoricalReferenceRanges({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>().language;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              children: [
                Icon(Icons.history_rounded, color: AppColors.royalBlue),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Historical Reference Ranges (Past Data Only)',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15.5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'General, publicly known ranges — NOT a prediction or promise '
              'for your money.',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 14),
            if (result.safeZonePercent > 0)
              const _RangeRow(
                icon: Icons.lock_rounded,
                color: AppColors.royalBlue,
                label: 'Safe Zone (Post Office / FD)',
                range: '~6.5% – 7.5% p.a. (typical govt-notified range, changes periodically)',
              ),
            if (result.growthZonePercent > 0)
              const _RangeRow(
                icon: Icons.park_rounded,
                color: AppColors.emeraldGreen,
                label: 'Growth Zone (Index / Mutual Funds)',
                range:
                    '~10% – 12% p.a. long-term historical average — but year-to-year '
                    'it swings a lot, and short-term losses are common and normal.',
              ),
            if (result.emergencyZonePercent > 0)
              const _RangeRow(
                icon: Icons.emergency_rounded,
                color: AppColors.goldAccent,
                label: 'Emergency Zone (Digital Gold)',
                range: '~8% – 12% p.a. long-term average — also volatile year to year.',
              ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.crimsonRed.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.crimsonRed.withValues(alpha: 0.25)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.warning_amber_rounded, color: AppColors.crimsonRed, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Past performance does NOT guarantee future returns. '
                      'Markets can go down as well as up. ${AppStrings.notSebiBadge(lang)}.',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.crimsonRedDark,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RangeRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String range;

  const _RangeRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.range,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 16, backgroundColor: color, child: Icon(icon, size: 16, color: Colors.white)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                const SizedBox(height: 2),
                Text(range, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
