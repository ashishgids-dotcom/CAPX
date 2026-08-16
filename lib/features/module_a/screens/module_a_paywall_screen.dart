import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../providers/module_a_provider.dart';

/// Mockup payment sheet simulating a Razorpay/UPI intent launch for ₹29.
///
/// This is a UI-only simulation. To go live you must:
///  1. Integrate the real razorpay_flutter (or preferred PSP) SDK.
///  2. Create the order server-side (never trust a client-generated amount).
///  3. Verify the payment signature server-side before unlocking content.
///  4. Handle failure/timeout/refund flows per your PSP's guidelines.
class ModuleAPaywallScreen extends StatelessWidget {
  const ModuleAPaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ModuleAProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Complete Payment')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 12),
            const CircleAvatar(
              radius: 36,
              backgroundColor: AppColors.emeraldGreen,
              child: Icon(Icons.lock_open_rounded, color: Colors.white, size: 34),
            ),
            const SizedBox(height: 16),
            const Text(
              'Unlock your personalized allocation view',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _PaymentSummaryCard(),
            const Spacer(),
            _buildActionArea(context, provider),
            const SizedBox(height: 8),
            const Text(
              'Simulated payment sheet (Razorpay/UPI intent placeholder) — '
              'wire up a real PSP SDK before release.',
              style: TextStyle(fontSize: 11.5, color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionArea(BuildContext context, ModuleAProvider provider) {
    switch (provider.paymentStatus) {
      case PaymentStatus.notStarted:
      case PaymentStatus.failed:
        return ElevatedButton.icon(
          icon: const Icon(Icons.qr_code_rounded),
          label: const Text('Pay Now · ₹29'),
          onPressed: () async {
            await provider.simulatePayment();
            if (context.mounted && provider.paymentStatus == PaymentStatus.success) {
              context.go('/module-a/output');
            }
          },
        );
      case PaymentStatus.processing:
        return const Column(
          children: [
            CircularProgressIndicator(color: AppColors.emeraldGreen),
            SizedBox(height: 12),
            Text('Processing payment via UPI…'),
          ],
        );
      case PaymentStatus.success:
        return const Column(
          children: [
            Icon(Icons.check_circle_rounded, color: AppColors.emeraldGreen, size: 40),
            SizedBox(height: 8),
            Text('Payment Successful'),
          ],
        );
    }
  }
}

class _PaymentSummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _row('Item', 'Savings & Investment Guide'),
            const Divider(),
            _row('Amount', '₹29.00', bold: true),
            const Divider(),
            _row('Payment mode', 'UPI / Razorpay (simulated)'),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
          Text(
            value,
            style: TextStyle(fontWeight: bold ? FontWeight.w800 : FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
