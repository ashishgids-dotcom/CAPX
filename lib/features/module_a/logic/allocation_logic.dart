enum Tenure { shortTerm, longTerm }

class AllocationResult {
  final double safeZonePercent; // Post Office / FD
  final double growthZonePercent; // Mutual/Index Funds category
  final double emergencyZonePercent; // Digital Gold

  const AllocationResult({
    required this.safeZonePercent,
    required this.growthZonePercent,
    required this.emergencyZonePercent,
  });
}

/// Deterministic, rule-based, purely illustrative split.
///
/// IMPORTANT: This is intentionally generic and non-personalized — it maps
/// an amount+tenure bucket to one of a small, fixed set of illustrative
/// allocation examples. It must NOT be extended to factor in age, income,
/// risk appetite, goals, or other individual circumstances, since that
/// would tip this from "educational calculator" into "personalized
/// investment advice," which requires SEBI Registered Investment Adviser
/// registration. Get compliance/legal sign-off before changing this logic.
class AllocationEngine {
  static const double _ruleThresholdAmount = 25000;

  static AllocationResult compute({
    required double amount,
    required Tenure tenure,
  }) {
    // Rule 1: Amount < 25,000 & Short-Term
    if (amount < _ruleThresholdAmount && tenure == Tenure.shortTerm) {
      return const AllocationResult(
        safeZonePercent: 80,
        emergencyZonePercent: 20,
        growthZonePercent: 0,
      );
    }

    // Rule 2: Amount >= 25,000 & Long-Term
    if (amount >= _ruleThresholdAmount && tenure == Tenure.longTerm) {
      return const AllocationResult(
        safeZonePercent: 40,
        growthZonePercent: 50,
        emergencyZonePercent: 10,
      );
    }

    // Fallback (mixed cases not explicitly specified): balanced illustrative
    // default, weighted safer for short-term, growth-leaning for long-term.
    if (tenure == Tenure.shortTerm) {
      return const AllocationResult(
        safeZonePercent: 65,
        growthZonePercent: 15,
        emergencyZonePercent: 20,
      );
    }
    return const AllocationResult(
      safeZonePercent: 50,
      growthZonePercent: 40,
      emergencyZonePercent: 10,
    );
  }
}

/// Scam Detector: flags schemes promising unrealistic fixed annual returns.
class ScamDetector {
  static const double redFlagThresholdPercent = 15.0;

  static bool isLikelyFraud(double promisedAnnualReturnPercent) {
    return promisedAnnualReturnPercent > redFlagThresholdPercent;
  }

  static const String warningMessage =
      'High Risk of Fraud Detected\n(लालच में मत आइए, यह फर्जी स्कीम हो सकती है)';
}
