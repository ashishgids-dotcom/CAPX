import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../../language_selection/providers/language_provider.dart';
import 'legal_compliance_tab.dart';
import 'marketing_blueprint_tab.dart';
import 'shop_audit_tab.dart';
import 'sourcing_map_tab.dart';

class ModuleBDashboardScreen extends StatelessWidget {
  const ModuleBDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>().language;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Digital Merchant Rescue Suite'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.fact_check_rounded), text: 'Shop Audit'),
              Tab(icon: Icon(Icons.campaign_rounded), text: 'Marketing'),
              Tab(icon: Icon(Icons.local_shipping_rounded), text: 'Sourcing'),
              Tab(icon: Icon(Icons.gavel_rounded), text: 'GST & ITR'),
            ],
          ),
        ),
        body: Column(
          children: [
            // Header disclaimer banner — reiterated per spec: this suite is
            // business education / case studies only, not certified
            // consulting, and CAPX takes no responsibility for business
            // profit/loss outcomes.
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: AppColors.royalBlue.withValues(alpha: 0.08),
              child: Text(
                AppStrings.moduleBDisclaimer(lang),
                style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, height: 1.3),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ShopAuditTab(),
                  MarketingBlueprintTab(),
                  SourcingMapTab(),
                  LegalComplianceTab(),
                ],
              ),
            ),
            // Footer disclaimer banner — same message reiterated at the
            // bottom, so it's visible regardless of which tab/scroll
            // position the user is on.
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: AppColors.royalBlue,
              child: Text(
                AppStrings.moduleBDisclaimer(lang),
                style: const TextStyle(fontSize: 10.5, color: Colors.white, height: 1.3),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
