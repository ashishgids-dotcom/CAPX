import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../logic/allocation_logic.dart';

class ScamDetectorWidget extends StatefulWidget {
  const ScamDetectorWidget({super.key});

  @override
  State<ScamDetectorWidget> createState() => _ScamDetectorWidgetState();
}

class _ScamDetectorWidgetState extends State<ScamDetectorWidget> {
  final _controller = TextEditingController();
  double? _enteredReturn;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFraudFlag =
        _enteredReturn != null && ScamDetector.isLikelyFraud(_enteredReturn!);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              children: [
                Icon(Icons.gpp_maybe_rounded, color: AppColors.royalBlue),
                SizedBox(width: 8),
                Text('Scam Detector Calculator',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              "Enter the scheme's promised fixed annual return (%)",
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(suffixText: '% annually'),
              onChanged: (v) => setState(() => _enteredReturn = double.tryParse(v)),
            ),
            const SizedBox(height: 16),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: isFraudFlag
                  ? _RedFlagBox(key: const ValueKey('flag'))
                  : (_enteredReturn != null
                      ? Container(
                          key: const ValueKey('ok'),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.emeraldGreen.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.check_circle_outline,
                                  color: AppColors.emeraldGreen),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'This return looks within a plausible range — '
                                  'still verify the scheme is SEBI/RBI regulated '
                                  'before investing.',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(key: ValueKey('empty'))),
            ),
          ],
        ),
      ),
    );
  }
}

class _RedFlagBox extends StatelessWidget {
  const _RedFlagBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.crimsonRed,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.crimsonRed.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              ScamDetector.warningMessage,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 14.5,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
