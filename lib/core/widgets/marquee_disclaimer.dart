import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../constants/app_strings.dart';
import '../theme/app_theme.dart';

/// Persistent legal disclaimer marquee, pinned to the bottom of the
/// dashboard. Runs at a smooth default velocity; text is never truncated.
class MarqueeDisclaimer extends StatelessWidget {
  final AppLanguage language;
  const MarqueeDisclaimer({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final text = AppStrings.marqueeWarning(language);

    return Container(
      width: double.infinity,
      height: 44,
      color: AppColors.royalBlue,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Marquee(
              text: text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
              ),
              velocity: 40.0,
              blankSpace: 60.0,
              startPadding: 10.0,
              pauseAfterRound: const Duration(seconds: 1),
              accelerationDuration: const Duration(milliseconds: 400),
              decelerationDuration: const Duration(milliseconds: 400),
            ),
          ),
        ],
      ),
    );
  }
}

/// Full-screen mandatory disclaimer acknowledgement gate.
/// Use before unlocking Module A (savings allocation) and Module B / Tab 4
/// (GST & ITR guidance) so the disclaimer isn't just decorative.
class DisclaimerGateScreen extends StatelessWidget {
  final AppLanguage language;
  final VoidCallback onAcknowledge;

  const DisclaimerGateScreen({
    super.key,
    required this.language,
    required this.onAcknowledge,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Please Read')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.shield_outlined, size: 56, color: AppColors.royalBlue),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  AppStrings.globalDisclaimer(language),
                  style: const TextStyle(fontSize: 15.5, height: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onAcknowledge,
              child: Text(AppStrings.t('i_understand_continue', language)),
            ),
          ],
        ),
      ),
    );
  }
}
