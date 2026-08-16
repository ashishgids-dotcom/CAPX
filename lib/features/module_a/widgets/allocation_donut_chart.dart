import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../logic/allocation_logic.dart';

class AllocationDonutChart extends StatelessWidget {
  final AllocationResult result;
  const AllocationDonutChart({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final sections = <PieChartSectionData>[
      if (result.safeZonePercent > 0)
        PieChartSectionData(
          value: result.safeZonePercent,
          color: AppColors.royalBlue,
          title: '${result.safeZonePercent.toStringAsFixed(0)}%',
          radius: 62,
          titleStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
        ),
      if (result.growthZonePercent > 0)
        PieChartSectionData(
          value: result.growthZonePercent,
          color: AppColors.emeraldGreen,
          title: '${result.growthZonePercent.toStringAsFixed(0)}%',
          radius: 62,
          titleStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
        ),
      if (result.emergencyZonePercent > 0)
        PieChartSectionData(
          value: result.emergencyZonePercent,
          color: AppColors.goldAccent,
          title: '${result.emergencyZonePercent.toStringAsFixed(0)}%',
          radius: 62,
          titleStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
        ),
    ];

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PieChart(
            PieChartData(
              sections: sections,
              centerSpaceRadius: 52,
              sectionsSpace: 3,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            if (result.safeZonePercent > 0)
              _LegendItem(
                color: AppColors.royalBlue,
                icon: Icons.lock_rounded,
                label: 'Safe Zone (Post Office / FD)',
              ),
            if (result.growthZonePercent > 0)
              _LegendItem(
                color: AppColors.emeraldGreen,
                icon: Icons.park_rounded,
                label: 'Growth Zone (Index/Mutual Funds)',
              ),
            if (result.emergencyZonePercent > 0)
              _LegendItem(
                color: AppColors.goldAccent,
                icon: Icons.emergency_rounded,
                label: 'Emergency Zone (Digital Gold)',
              ),
          ],
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;

  const _LegendItem({required this.color, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(radius: 12, backgroundColor: color, child: Icon(icon, size: 14, color: Colors.white)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12.5)),
      ],
    );
  }
}
