import 'package:flutter/material.dart';

enum PaymentStatus { notStarted, processing, success, failed }

class PricingRecommendation {
  final double recommendedPrice;
  final double marginPercent;
  final String bundlingGuideline;
  final String loseLeaderNote;

  PricingRecommendation({
    required this.recommendedPrice,
    required this.marginPercent,
    required this.bundlingGuideline,
    required this.loseLeaderNote,
  });
}

class KpiInputs {
  double marketingSpend = 0;
  double newCustomers = 0;
  double avgOrderValue = 0;
  double avgPurchaseFrequencyPerYear = 1;
  double monthlyRecurringRevenue = 0;
  double monthlyBurn = 0;
  double cashInBank = 0;

  double get cac => newCustomers == 0 ? 0 : marketingSpend / newCustomers;
  double get ltv => avgOrderValue * avgPurchaseFrequencyPerYear;
  double get mrr => monthlyRecurringRevenue;
  double get runwayMonths => monthlyBurn <= 0 ? 0 : cashInBank / monthlyBurn;
}

class ModuleCProvider extends ChangeNotifier {
  // Screen 1 inputs
  String industryCategory = '';
  String cityTier = 'Tier 1';
  double? startingCapital;

  PaymentStatus paymentStatus = PaymentStatus.notStarted;

  // Sub-tab 1: Pricing engine
  double? costPrice;
  double? competitorPrice;

  // KPI tracker state
  final KpiInputs kpi = KpiInputs();

  void setIndustry(String v) {
    industryCategory = v;
    notifyListeners();
  }

  void setCityTier(String v) {
    cityTier = v;
    notifyListeners();
  }

  void setStartingCapital(String v) {
    startingCapital = double.tryParse(v.replaceAll(',', ''));
    notifyListeners();
  }

  bool get canProceedToPayment =>
      industryCategory.isNotEmpty && startingCapital != null && startingCapital! > 0;

  Future<void> simulatePayment() async {
    paymentStatus = PaymentStatus.processing;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    paymentStatus = PaymentStatus.success;
    notifyListeners();
  }

  void setCostPrice(String v) {
    costPrice = double.tryParse(v);
    notifyListeners();
  }

  void setCompetitorPrice(String v) {
    competitorPrice = double.tryParse(v);
    notifyListeners();
  }

  /// Simple, transparent illustrative pricing model — NOT a substitute for
  /// real unit-economics analysis with the founder's actual cost structure.
  PricingRecommendation? get pricingRecommendation {
    if (costPrice == null || costPrice! <= 0) return null;

    final cp = costPrice!;
    final competitor = competitorPrice ?? (cp * 1.6);

    // Target a healthy margin, but stay under competitor pricing if possible.
    final targetPrice = cp * 1.45;
    final finalPrice = targetPrice < competitor ? targetPrice : competitor * 0.95;
    final margin = ((finalPrice - cp) / finalPrice) * 100;

    return PricingRecommendation(
      recommendedPrice: finalPrice,
      marginPercent: margin,
      bundlingGuideline:
          'Consider a "3 for the price of 2.5" wholesale bundle for orders above '
          '10 units to move inventory faster without cutting your per-unit margin as much.',
      loseLeaderNote:
          'Use only 1 low-margin "loss-leader" SKU to bring in footfall/clicks — '
          'recover margin on complementary items sold alongside it.',
    );
  }

  void updateKpi({
    double? marketingSpend,
    double? newCustomers,
    double? avgOrderValue,
    double? avgPurchaseFrequencyPerYear,
    double? monthlyRecurringRevenue,
    double? monthlyBurn,
    double? cashInBank,
  }) {
    if (marketingSpend != null) kpi.marketingSpend = marketingSpend;
    if (newCustomers != null) kpi.newCustomers = newCustomers;
    if (avgOrderValue != null) kpi.avgOrderValue = avgOrderValue;
    if (avgPurchaseFrequencyPerYear != null) {
      kpi.avgPurchaseFrequencyPerYear = avgPurchaseFrequencyPerYear;
    }
    if (monthlyRecurringRevenue != null) kpi.monthlyRecurringRevenue = monthlyRecurringRevenue;
    if (monthlyBurn != null) kpi.monthlyBurn = monthlyBurn;
    if (cashInBank != null) kpi.cashInBank = cashInBank;
    notifyListeners();
  }
}
