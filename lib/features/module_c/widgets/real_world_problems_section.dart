import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../data/problem_solution_data.dart';

/// Shows a "Real-World Problems Founders Face" list with expandable
/// solutions — this is what makes each Module C sub-tab more than a
/// calculator or a video-call booking screen.
class RealWorldProblemsSection extends StatelessWidget {
  final String title;
  final List<ProblemSolution> problems;

  const RealWorldProblemsSection({
    super.key,
    required this.title,
    required this.problems,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.psychology_alt_rounded, color: AppColors.crimsonRedDark),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15.5)),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ...problems.map((p) => _ProblemTile(item: p)),
          ],
        ),
      ),
    );
  }
}

class _ProblemTile extends StatelessWidget {
  final ProblemSolution item;
  const _ProblemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(bottom: 12),
      leading: const Icon(Icons.help_outline_rounded, color: AppColors.crimsonRed, size: 20),
      title: Text(
        item.problem,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5),
      ),
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.emeraldGreen.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.lightbulb_outline_rounded, color: AppColors.emeraldGreen, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(item.solution, style: const TextStyle(fontSize: 13, height: 1.4)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
