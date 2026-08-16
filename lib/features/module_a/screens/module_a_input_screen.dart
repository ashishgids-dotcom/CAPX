import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../logic/allocation_logic.dart';
import '../providers/module_a_provider.dart';

class ModuleAInputScreen extends StatelessWidget {
  const ModuleAInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ModuleAProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Savings & Investment Guide')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'How much money do you want to allocate/invest?',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                prefixText: '₹ ',
                hintText: 'e.g. 20000',
              ),
              onChanged: provider.setAmount,
            ),
            const SizedBox(height: 28),
            const Text(
              'Select tenure',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            _TenureOption(
              label: 'Short-Term (1-2 years)',
              value: Tenure.shortTerm,
              groupValue: provider.tenure,
              onChanged: provider.setTenure,
            ),
            const SizedBox(height: 10),
            _TenureOption(
              label: 'Long-Term (5+ years)',
              value: Tenure.longTerm,
              groupValue: provider.tenure,
              onChanged: provider.setTenure,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.royalBlue.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'This is an educational, illustrative calculator only — not '
                'personalized investment advice.',
                style: TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: provider.canProceedToPayment
                  ? () => context.push('/module-a/paywall')
                  : null,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TenureOption extends StatelessWidget {
  final String label;
  final Tenure value;
  final Tenure groupValue;
  final ValueChanged<Tenure> onChanged;

  const _TenureOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return Material(
      color: isSelected ? AppColors.emeraldGreen.withValues(alpha: 0.1) : Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => onChanged(value),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? AppColors.emeraldGreen : AppColors.cardBorder,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: isSelected ? AppColors.emeraldGreen : AppColors.textSecondary,
              ),
              const SizedBox(width: 12),
              Text(label, style: const TextStyle(fontSize: 15.5)),
            ],
          ),
        ),
      ),
    );
  }
}
