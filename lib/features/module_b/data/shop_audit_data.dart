class AuditQuestion {
  final String question;
  final List<String> options; // A, B, C
  final List<int> scores; // score per option, higher = healthier

  const AuditQuestion({
    required this.question,
    required this.options,
    required this.scores,
  });
}

/// The 5 diagnostic questions, verbatim per spec (Hindi), each option scored
/// A=2 (healthiest habit), B=1 (partial), C=0 (weakest) for a simple,
/// transparent 0-10 -> 0-100% Store Health Score.
const List<AuditQuestion> shopAuditQuestions = [
  AuditQuestion(
    question:
        'क्या आपकी दुकान Google Maps (गूगल मैप्स) पर लिस्टेड है ताकि आस-पास के लोग आपको ढूंढ सकें?',
    options: [
      'हाँ, अच्छे रिव्यूज़ के साथ है',
      'लिस्टेड है पर कभी चेक नहीं किया',
      'नहीं, गूगल मैप्स पर नहीं है।',
    ],
    scores: [2, 1, 0],
  ),
  AuditQuestion(
    question:
        'ग्राहक जब दुकान पर आता है, तो क्या आप उनका नाम-नंबर सेव करते हैं या ऑनलाइन पेमेंट्स लेते हैं?',
    options: [
      'सिर्फ QR कोड से पेमेंट लेते हैं',
      'पेमेंट के साथ ग्राहकों का नंबर भी सेव करते हैं ताकि उन्हें ऑफर्स भेज सकें',
      'सिर्फ कैश (नकद) में काम करते हैं।',
    ],
    scores: [1, 2, 0],
  ),
  AuditQuestion(
    question: 'आप अपनी दुकान का सामान (Wholesale Inventory) कहाँ से खरीदते हैं?',
    options: [
      'सीधे दिल्ली/बड़े शहरों के सबसे सस्ते थोक बाज़ार से',
      'अपने लोकल डिस्ट्रीब्यूटर से (जो थोड़ा महंगा देता है)',
      'जहां से भी मिल जाए।',
    ],
    scores: [2, 1, 0],
  ),
  AuditQuestion(
    question:
        'त्योहारों या मंदी के समय ग्राहकों को दुकान तक खींचने के लिए आप क्या करते हैं?',
    options: [
      'लोकल पर्चे (Pamphlets) छपवाते हैं या मोबाइल पर विज्ञापन चलाते हैं',
      'दुकान के बाहर बोर्ड लगा देते हैं',
      'कुछ नहीं करते, ग्राहक के आने का इंतजार करते हैं।',
    ],
    scores: [2, 1, 0],
  ),
  AuditQuestion(
    question:
        'आपको ऑनलाइन कंपनियों (जैसे बड़ी e-commerce/quick-commerce कंपनियों) से कितना नुकसान हो रहा है?',
    options: [
      'बहुत ज़्यादा, ग्राहक ऑनलाइन भाग रहे हैं',
      'थोड़ा बहुत असर पड़ा है',
      'कोई असर नहीं पड़ा, हमारे ग्राहक फिक्स हैं।',
    ],
    // Note: for this question, "very affected" (A) reflects awareness of a
    // real threat, not a bad habit, so it is scored neutrally rather than
    // penalized — only used for messaging, not for the health score.
    scores: [1, 1, 1],
  ),
];

class ShopAuditResult {
  final int rawScore; // out of 10 (Q1-4 scored, Q5 excluded from score)
  final double healthScorePercent;
  final List<String> gaps;

  ShopAuditResult({
    required this.rawScore,
    required this.healthScorePercent,
    required this.gaps,
  });
}

class ShopAuditEvaluator {
  static ShopAuditResult evaluate(List<int> selectedOptionIndexes) {
    int score = 0;
    // Only Q1-Q4 (index 0-3) count toward the health score.
    for (int i = 0; i < 4 && i < selectedOptionIndexes.length; i++) {
      final optionIndex = selectedOptionIndexes[i];
      score += shopAuditQuestions[i].scores[optionIndex];
    }
    final percent = (score / 8) * 100; // max 8 (4 questions x 2)

    final gaps = <String>[];
    if (selectedOptionIndexes.isNotEmpty && selectedOptionIndexes[0] == 2) {
      gaps.add('स्थानीय ग्राहकों को आपकी लोकेशन नहीं दिख रही (Google Maps पर नहीं हैं)');
    }
    if (selectedOptionIndexes.length > 2 && selectedOptionIndexes[2] != 0) {
      gaps.add('आपकी खरीद (sourcing) महंगी पड़ रही है');
    }
    if (selectedOptionIndexes.length > 3 && selectedOptionIndexes[3] == 2) {
      gaps.add('आप कोई मार्केटिंग नहीं कर रहे');
    }
    if (selectedOptionIndexes.length > 1 && selectedOptionIndexes[1] == 2) {
      gaps.add('आप ग्राहकों का डेटा (नाम/नंबर) सेव नहीं कर रहे, दोबारा ऑफर नहीं भेज पा रहे');
    }

    return ShopAuditResult(rawScore: score, healthScorePercent: percent, gaps: gaps);
  }
}
