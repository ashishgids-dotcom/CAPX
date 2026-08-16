import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/module_c_provider.dart';

const _industries = [
  'D2C / E-commerce',
  'Food & Beverage',
  'Retail / Kirana',
  'Services (Local)',
  'SaaS / Tech',
  'Manufacturing',
  'Other',
];

const _cityTiers = ['Tier 1', 'Tier 2', 'Tier 3 / Rural'];

class ModuleCInputScreen extends StatelessWidget {
  const ModuleCInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ModuleCProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Startup Advisory Setup')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Startup Industry Category',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: provider.industryCategory.isEmpty ? null : provider.industryCategory,
              items: _industries
                  .map((i) => DropdownMenuItem(value: i, child: Text(i)))
                  .toList(),
              onChanged: (v) => provider.setIndustry(v ?? ''),
              decoration: const InputDecoration(hintText: 'Select category'),
            ),
            const SizedBox(height: 24),
            const Text('Operating City Tier',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            SegmentedButton<String>(
              segments: _cityTiers
                  .map((t) => ButtonSegment(value: t, label: Text(t)))
                  .toList(),
              selected: {provider.cityTier},
              onSelectionChanged: (s) => provider.setCityTier(s.first),
            ),
            const SizedBox(height: 24),
            const Text('Starting Capital', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(prefixText: '₹ ', hintText: 'e.g. 200000'),
              onChanged: provider.setStartingCapital,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: provider.canProceedToPayment
                  ? () => context.push('/module-c/paywall')
                  : null,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
