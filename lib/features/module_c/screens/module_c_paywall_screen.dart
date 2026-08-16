import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/module_c_provider.dart';

class ModuleCPaywallScreen extends StatelessWidget {
  const ModuleCPaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ModuleCProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Premium Unlock'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Icon(Icons.workspace_premium_rounded, color: Color(0xFFD4A017), size: 56),
            const SizedBox(height: 20),
            const Text(
              'Unlock the Complete 4Ps Strategy Blueprint\n+ Live Expert Consultation',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'for ₹2,499',
              style: TextStyle(color: Color(0xFFD4A017), fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 28),
            _buildFeatureList(),
            const Spacer(),
            _buildActionArea(context, provider),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureList() {
    const features = [
      'Product & Pricing Strategy Engine',
      'Sales & Hyper-Marketing Playbooks',
      'Distribution & Logistics Roadmap',
      'Live KPI Tracking Dashboard (CAC, LTV, MRR, Runway)',
      '30-min 1-on-1 Expert Consultation Call',
      'Instant PDF Blueprint Export',
    ];

    return Column(
      children: features
          .map((f) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded, color: Color(0xFF0E9F6E), size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Text(f,
                            style: const TextStyle(color: Colors.white70, fontSize: 14.5))),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildActionArea(BuildContext context, ModuleCProvider provider) {
    switch (provider.paymentStatus) {
      case PaymentStatus.notStarted:
      case PaymentStatus.failed:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4A017),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () async {
              await provider.simulatePayment();
              if (context.mounted && provider.paymentStatus == PaymentStatus.success) {
                context.go('/module-c/dashboard');
              }
            },
            child: const Text('Unlock for ₹2,499', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        );
      case PaymentStatus.processing:
        return const Column(
          children: [
            CircularProgressIndicator(color: Color(0xFFD4A017)),
            SizedBox(height: 12),
            Text('Processing payment…', style: TextStyle(color: Colors.white70)),
          ],
        );
      case PaymentStatus.success:
        return const Text('Unlocked ✓', style: TextStyle(color: Colors.white));
    }
  }
}
