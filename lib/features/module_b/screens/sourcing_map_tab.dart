import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class SourcingHub {
  final String category;
  final String hubName;
  final String city;
  final IconData icon;

  const SourcingHub({
    required this.category,
    required this.hubName,
    required this.city,
    required this.icon,
  });
}

const List<SourcingHub> _hubs = [
  SourcingHub(
    category: 'Readymade Garments / Textiles',
    hubName: 'Gandhi Nagar Market & Fatehpuri Wholesale Market',
    city: 'Delhi',
    icon: Icons.checkroom_rounded,
  ),
  SourcingHub(
    category: 'Artificial Jewelry, Toys & Cosmetics',
    hubName: 'Sadar Bazar',
    city: 'Delhi',
    icon: Icons.diamond_rounded,
  ),
  SourcingHub(
    category: 'Electronics & Mobile Accessories',
    hubName: 'Karol Bagh Market',
    city: 'Delhi',
    icon: Icons.devices_rounded,
  ),
  SourcingHub(
    category: 'Daily Groceries & FMCG Bulk',
    hubName: 'Naharpur Wholesale Market',
    city: 'Rohini, Delhi',
    icon: Icons.shopping_basket_rounded,
  ),
];

class SourcingMapTab extends StatefulWidget {
  const SourcingMapTab({super.key});

  @override
  State<SourcingMapTab> createState() => _SourcingMapTabState();
}

class _SourcingMapTabState extends State<SourcingMapTab> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = _hubs
        .where((h) =>
            h.category.toLowerCase().contains(_query.toLowerCase()) ||
            h.hubName.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search_rounded),
              hintText: 'Search product category…',
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final hub = filtered[index];
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: CircleAvatar(
                    backgroundColor: AppColors.royalBlue.withValues(alpha: 0.12),
                    child: Icon(hub.icon, color: AppColors.royalBlue),
                  ),
                  title: Text(hub.category,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text('${hub.hubName} · ${hub.city}',
                        style: const TextStyle(fontSize: 12.5)),
                  ),
                  trailing: const Icon(Icons.map_outlined, color: AppColors.emeraldGreen),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            'Prices and market conditions change — always verify current rates '
            'on-site before bulk buying.',
            style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
