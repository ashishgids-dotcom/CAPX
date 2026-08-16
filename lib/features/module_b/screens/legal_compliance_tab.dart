import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// GST / ITR guidance is general educational information, not certified
/// legal or tax filing advice. Direct users to the official portal / a CA
/// for their actual filing — see the disclaimer banner at the top.
class LegalComplianceTab extends StatelessWidget {
  const LegalComplianceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppColors.crimsonRed.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.crimsonRed.withValues(alpha: 0.3)),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.crimsonRed, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'General educational guidance only — not certified legal or '
                  'tax filing advice. Consult a Chartered Accountant for your '
                  'actual filing.',
                  style: TextStyle(fontSize: 12, color: AppColors.textPrimary),
                ),
              ),
            ],
          ),
        ),
        const _GuideCard(
          icon: Icons.receipt_long_rounded,
          title: 'How to Register a GST Number',
          bullets: [
            'GST Common Portal (services.gst.gov.in) par jaakar free mein khud register kar sakte hain — kisi agent ki zaroorat nahi.',
            'Zaroori documents: PAN card, Aadhaar, business address proof, bank account details, photo.',
            '"New Registration" select karein, OTP verify karein, aur ARN (Application Reference Number) note kar lein.',
            'Verification ke baad GSTIN 3-7 working days mein mil jaata hai.',
          ],
        ),
        const _GuideCard(
          icon: Icons.description_rounded,
          title: 'How to File Income Tax Returns (ITR) for Retailers',
          bullets: [
            'Chhote dukaandaar aksar ITR-4 (Sugam) form use karte hain agar Presumptive Taxation Scheme (Section 44AD) choose karte hain.',
            'Section 44AD ke tehat, turnover ka ek fixed % (generally 8% cash / 6% digital receipts) hi taxable profit maana jaata hai — detailed book-keeping ki zaroorat kam hoti hai.',
            'Turnover ₹2 crore se zyada ho to ITR-3 aur regular books of accounts zaroori ho sakte hain.',
            'incometax.gov.in par jaakar khud file kar sakte hain, ya ek CA se verify karwayein.',
          ],
        ),
      ],
    );
  }
}

class _GuideCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> bullets;

  const _GuideCard({required this.icon, required this.title, required this.bullets});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.royalBlue.withValues(alpha: 0.12),
          child: Icon(icon, color: AppColors.royalBlue),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5)),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: bullets
            .map((b) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle, size: 16, color: AppColors.emeraldGreen),
                      const SizedBox(width: 8),
                      Expanded(child: Text(b, style: const TextStyle(fontSize: 13, height: 1.4))),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
