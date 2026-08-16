import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../providers/module_c_provider.dart';
import '../data/problem_solution_data.dart';
import '../widgets/blueprint_pdf_exporter.dart';
import '../widgets/consultation_scheduler_widget.dart';
import '../widgets/real_world_problems_section.dart';

class ModuleCDashboardScreen extends StatelessWidget {
  const ModuleCDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ModuleCProvider>();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Startup Advisory Dashboard'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.sell_rounded), text: 'Product & Price'),
              Tab(icon: Icon(Icons.trending_up_rounded), text: 'Sales & Marketing'),
              Tab(icon: Icon(Icons.local_shipping_rounded), text: 'Distribution'),
              Tab(icon: Icon(Icons.query_stats_rounded), text: 'Performance'),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'Export Blueprint PDF',
              icon: const Icon(Icons.picture_as_pdf_rounded),
              onPressed: () => BlueprintPdfExporter.exportAndShare(provider),
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            _ProductPricingTab(),
            _SalesMarketingTab(),
            _DistributionTab(),
            _PerformanceTab(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sub-Tab 1: Product & Pricing Strategy
// ---------------------------------------------------------------------------
class _ProductPricingTab extends StatelessWidget {
  const _ProductPricingTab();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ModuleCProvider>();
    final rec = provider.pricingRecommendation;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Pricing Architecture Engine',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(height: 12),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Cost Price (₹)'),
                  onChanged: provider.setCostPrice,
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Competitor Pricing (₹, optional)'),
                  onChanged: provider.setCompetitorPrice,
                ),
                if (rec != null) ...[
                  const SizedBox(height: 16),
                  const Divider(),
                  _kv('Recommended Price', '₹${rec.recommendedPrice.toStringAsFixed(2)}'),
                  _kv('Estimated Margin', '${rec.marginPercent.toStringAsFixed(1)}%'),
                  const SizedBox(height: 8),
                  Text('Bundling: ${rec.bundlingGuideline}',
                      style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
                  const SizedBox(height: 6),
                  Text('Loss-leader: ${rec.loseLeaderNote}',
                      style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const _PmfTesterCard(),
        const SizedBox(height: 16),
        const RealWorldProblemsSection(
          title: 'Real-World Problems: Product & Price',
          problems: productPriceProblems,
        ),
      ],
    );
  }

  Widget _kv(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(k, style: const TextStyle(color: AppColors.textSecondary)),
            Text(v, style: const TextStyle(fontWeight: FontWeight.w800)),
          ],
        ),
      );
}

class _PmfTesterCard extends StatefulWidget {
  const _PmfTesterCard();

  @override
  State<_PmfTesterCard> createState() => _PmfTesterCardState();
}

class _PmfTesterCardState extends State<_PmfTesterCard> {
  final Map<String, double> _scores = {
    'Product Quality': 3,
    'USP vs Online Incumbents': 3,
    'Packaging / Presentation': 3,
  };

  @override
  Widget build(BuildContext context) {
    final avg = _scores.values.reduce((a, b) => a + b) / _scores.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Product Market Fit Tester',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            const SizedBox(height: 8),
            ..._scores.keys.map((k) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$k  (${_scores[k]!.toStringAsFixed(0)}/5)'),
                    Slider(
                      value: _scores[k]!,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      activeColor: AppColors.emeraldGreen,
                      onChanged: (v) => setState(() => _scores[k] = v),
                    ),
                  ],
                )),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.emeraldGreen.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Overall PMF Score: ${avg.toStringAsFixed(1)} / 5',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sub-Tab 2: Sales & Hyper-Marketing
// ---------------------------------------------------------------------------
class _SalesMarketingTab extends StatelessWidget {
  const _SalesMarketingTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _InfoCard(
          icon: Icons.handshake_rounded,
          title: 'Customer Acquisition Blueprint',
          body:
              'B2B leads: build a targeted list on LinkedIn/IndiaMART, send a short '
              'value-first outreach message, follow up 3 times over 2 weeks. '
              'Consumer traffic: run a small paid-ad test (₹500-1000) on the '
              'channel your audience actually uses, and double down on whichever '
              'converts best rather than spreading thin across all channels.',
        ),
        const _InfoCard(
          icon: Icons.rocket_launch_rounded,
          title: 'Growth Hacking Matrix',
          body:
              'Low-budget virality: user-generated content contests, "tag 3 friends" '
              'giveaways, and before/after demo Reels. Local influencer collabs: '
              'micro-influencers (5k-50k followers) in your city often convert '
              'better per rupee than big names. Ad hook formula: lead with the '
              'problem, show the transformation in 3 seconds, end with one clear CTA.',
        ),
        const RealWorldProblemsSection(
          title: 'Real-World Problems: Sales & Marketing',
          problems: promotionProblems,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Sub-Tab 3: Distribution & Logistics
// ---------------------------------------------------------------------------
class _DistributionTab extends StatelessWidget {
  const _DistributionTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _InfoCard(
          icon: Icons.route_rounded,
          title: 'Supply Chain Roadmap',
          body:
              'Route inventory through regional hubs closest to your customer '
              'clusters rather than one central warehouse — this cuts last-mile '
              'delivery cost and time. For low volume, 3PL (third-party logistics) '
              'partners are usually cheaper than building your own fleet until '
              'you cross a few hundred orders/month.',
        ),
        const _InfoCard(
          icon: Icons.storefront_rounded,
          title: 'Omnichannel Setup Guide',
          body:
              'ONDC: register as a seller via an ONDC-enabled buyer/seller app to '
              'reach a wider network without platform lock-in. Quick-commerce '
              'partner networks: apply through their seller/partner onboarding '
              'portal, keep SKU counts lean initially. D2C storefront: start with '
              'a simple, fast-loading store and clear WhatsApp-based order support '
              'before investing in a heavy custom build.',
        ),
        const RealWorldProblemsSection(
          title: 'Real-World Problems: Distribution & Place',
          problems: placeProblems,
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _InfoCard({required this.icon, required this.title, required this.body});

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
                  backgroundColor: AppColors.royalBlue.withValues(alpha: 0.12),
                  child: Icon(icon, color: AppColors.royalBlue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15.5)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(body, style: const TextStyle(fontSize: 13.5, height: 1.45)),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sub-Tab 4: Performance Tracking Dashboard (KPI)
// ---------------------------------------------------------------------------
class _PerformanceTab extends StatelessWidget {
  const _PerformanceTab();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ModuleCProvider>();
    final kpi = provider.kpi;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Weekly / Monthly Metrics Input',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(height: 12),
                _numField('Marketing Spend (₹)',
                    (v) => provider.updateKpi(marketingSpend: double.tryParse(v))),
                _numField('New Customers Acquired',
                    (v) => provider.updateKpi(newCustomers: double.tryParse(v))),
                _numField('Average Order Value (₹)',
                    (v) => provider.updateKpi(avgOrderValue: double.tryParse(v))),
                _numField('Avg Purchases / Customer / Year',
                    (v) => provider.updateKpi(avgPurchaseFrequencyPerYear: double.tryParse(v))),
                _numField('Monthly Recurring Revenue (₹)',
                    (v) => provider.updateKpi(monthlyRecurringRevenue: double.tryParse(v))),
                _numField('Monthly Burn (₹)',
                    (v) => provider.updateKpi(monthlyBurn: double.tryParse(v))),
                _numField('Cash in Bank (₹)',
                    (v) => provider.updateKpi(cashInBank: double.tryParse(v))),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: [
            _KpiTile(label: 'CAC', value: '₹${kpi.cac.toStringAsFixed(0)}', color: AppColors.royalBlue),
            _KpiTile(label: 'LTV', value: '₹${kpi.ltv.toStringAsFixed(0)}', color: AppColors.emeraldGreen),
            _KpiTile(label: 'MRR', value: '₹${kpi.mrr.toStringAsFixed(0)}', color: AppColors.goldAccent),
            _KpiTile(
              label: 'Runway',
              value: '${kpi.runwayMonths.toStringAsFixed(1)} mo',
              color: kpi.runwayMonths < 3 ? AppColors.crimsonRed : AppColors.emeraldGreen,
            ),
          ],
        ),
        const SizedBox(height: 16),
        RealWorldProblemsSection(
          title: 'Real-World Problems: Performance & Runway',
          problems: performanceProblems,
        ),
        const SizedBox(height: 4),
        const Divider(),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Still stuck? Book a live expert call below.',
            style: TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
          ),
        ),
        const ConsultationSchedulerWidget(),
      ],
    );
  }

  Widget _numField(String label, ValueChanged<String> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(labelText: label),
        onChanged: onChanged,
      ),
    );
  }
}

class _KpiTile extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _KpiTile({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withValues(alpha: 0.08),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12.5)),
            const SizedBox(height: 4),
            Text(value,
                style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 19)),
          ],
        ),
      ),
    );
  }
}
