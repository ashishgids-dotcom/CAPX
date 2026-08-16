import 'package:flutter/material.dart';

import '../logic/allocation_logic.dart';

enum PaymentStatus { notStarted, processing, success, failed }

class ModuleAProvider extends ChangeNotifier {
  double? amount;
  Tenure tenure = Tenure.shortTerm;
  PaymentStatus paymentStatus = PaymentStatus.notStarted;

  void setAmount(String value) {
    amount = double.tryParse(value.replaceAll(',', ''));
    notifyListeners();
  }

  void setTenure(Tenure t) {
    tenure = t;
    notifyListeners();
  }

  bool get canProceedToPayment => amount != null && amount! > 0;

  AllocationResult? get result {
    if (amount == null) return null;
    return AllocationEngine.compute(amount: amount!, tenure: tenure);
  }

  /// Simulated Razorpay/UPI intent payment flow.
  /// Replace with a real Razorpay/PhonePe/UPI SDK integration + server-side
  /// order verification before production. NEVER trust a client-only
  /// "success" flag for real money — verify the payment signature on your
  /// backend before unlocking paid content server-side too.
  Future<void> simulatePayment() async {
    paymentStatus = PaymentStatus.processing;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    paymentStatus = PaymentStatus.success;
    notifyListeners();
  }

  void reset() {
    amount = null;
    tenure = Tenure.shortTerm;
    paymentStatus = PaymentStatus.notStarted;
    notifyListeners();
  }
}
