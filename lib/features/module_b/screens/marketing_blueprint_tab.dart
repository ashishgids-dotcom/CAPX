import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class MarketingBlueprintTab extends StatelessWidget {
  const MarketingBlueprintTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _BlueprintCard(
          icon: Icons.print_rounded,
          title: 'Printing Local Pamphlets / Flyers',
          steps: [
            'Headline: Ek offer jo turant dhyaan khinche (e.g. "20% OFF is Weekend Only").',
            'Ek clear discount coupon box banayein jise kaatkar layein.',
            'Shop ka naam, address aur Google Maps QR code zaroor add karein.',
            'Local newspaper insert ya nearby societies mein baantwayein.',
          ],
        ),
        _BlueprintCard(
          icon: Icons.campaign_rounded,
          title: 'Meta / Instagram Hyper-Local Ads Setup',
          steps: [
            'Meta Business Suite mein account banayein (free).',
            'Ad Objective: "Store Traffic" ya "Messages" choose karein.',
            'Radius targeting set karein — apni dukaan se 2 km ka circle.',
            'Ek clear product photo + discount text ke saath ₹100-200/day budget se test karein.',
          ],
        ),
        _BlueprintCard(
          icon: Icons.chat_rounded,
          title: 'WhatsApp Business Automation',
          steps: [
            'WhatsApp Business app install karein, catalog banayein.',
            'Broadcast list mein saved customer numbers add karein.',
            'Seasonal sale template: "🎉 [Shop Name] par Diwali Sale! Aaj hi visit karein, limited stock."',
            'Har hafte ek offer message bhejein — spam na karein, max 1-2/week.',
          ],
        ),
      ],
    );
  }
}

class _BlueprintCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> steps;

  const _BlueprintCard({required this.icon, required this.title, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.emeraldGreen.withValues(alpha: 0.15),
                  child: Icon(icon, color: AppColors.emeraldGreen),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15.5)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...steps.asMap().entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${e.key + 1}.',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, color: AppColors.royalBlue)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(e.value, style: const TextStyle(fontSize: 13.5, height: 1.4)),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
