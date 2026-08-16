import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../providers/module_c_provider.dart';

/// Generates the "Instant Export Blueprint" PDF: 4Ps diagnostics summary +
/// pricing recommendation + KPI snapshot. Uses client-side canvas PDF
/// generation via the `pdf` + `printing` packages (no server round-trip
/// needed for this document).
class BlueprintPdfExporter {
  static Future<void> exportAndShare(ModuleCProvider provider) async {
    final doc = pw.Document();
    final pricing = provider.pricingRecommendation;
    final kpi = provider.kpi;

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Header(level: 0, text: 'Startup Blueprint Report'),
          pw.Text('Industry: ${provider.industryCategory}'),
          pw.Text('City Tier: ${provider.cityTier}'),
          pw.Text('Starting Capital: Rs. ${provider.startingCapital?.toStringAsFixed(0) ?? "-"}'),
          pw.SizedBox(height: 16),

          pw.Header(level: 1, text: 'Product & Pricing Strategy'),
          if (pricing != null) ...[
            pw.Text('Recommended Price: Rs. ${pricing.recommendedPrice.toStringAsFixed(2)}'),
            pw.Text('Estimated Margin: ${pricing.marginPercent.toStringAsFixed(1)}%'),
            pw.Text('Bundling Guideline: ${pricing.bundlingGuideline}'),
            pw.Text('Loss-Leader Note: ${pricing.loseLeaderNote}'),
          ] else
            pw.Text('No pricing data entered yet.'),
          pw.SizedBox(height: 16),

          pw.Header(level: 1, text: 'Performance Snapshot (KPI Tracker)'),
          pw.Bullet(text: 'Customer Acquisition Cost (CAC): Rs. ${kpi.cac.toStringAsFixed(2)}'),
          pw.Bullet(text: 'Lifetime Value (LTV): Rs. ${kpi.ltv.toStringAsFixed(2)}'),
          pw.Bullet(text: 'Monthly Recurring Revenue (MRR): Rs. ${kpi.mrr.toStringAsFixed(2)}'),
          pw.Bullet(text: 'Runway: ${kpi.runwayMonths.toStringAsFixed(1)} months'),
          pw.SizedBox(height: 16),

          pw.Header(level: 1, text: 'Sourcing & Local Marketing'),
          pw.Text(
            'See in-app Marketing Blueprint and Sourcing Map tabs for full, '
            'up-to-date pamphlet templates and wholesale hub listings.',
          ),
          pw.SizedBox(height: 20),

          pw.Divider(),
          pw.Text(
            'This report is an educational business-planning aid based on the '
            'inputs you provided. It is not certified financial, legal, or tax '
            'advice.',
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
          ),
        ],
      ),
    );

    await Printing.sharePdf(bytes: await doc.save(), filename: 'startup_blueprint.pdf');
  }
}
