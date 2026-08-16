import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../data/shop_audit_data.dart';

class ShopAuditTab extends StatefulWidget {
  const ShopAuditTab({super.key});

  @override
  State<ShopAuditTab> createState() => _ShopAuditTabState();
}

class _ShopAuditTabState extends State<ShopAuditTab> {
  final _pageController = PageController();
  final List<int?> _answers = List.filled(shopAuditQuestions.length, null);
  int _currentPage = 0;
  ShopAuditResult? _result;

  void _selectOption(int questionIndex, int optionIndex) {
    setState(() => _answers[questionIndex] = optionIndex);
    Future.delayed(const Duration(milliseconds: 250), () {
      if (questionIndex == shopAuditQuestions.length - 1) {
        _submit();
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _submit() {
    final selections = _answers.map((a) => a ?? 0).toList();
    setState(() => _result = ShopAuditEvaluator.evaluate(selections));
  }

  void _restart() {
    setState(() {
      _answers.fillRange(0, _answers.length, null);
      _result = null;
      _currentPage = 0;
    });
    _pageController.jumpToPage(0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_result != null) {
      return _ResultView(result: _result!, onRestart: _restart);
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: LinearProgressIndicator(
            value: (_currentPage + 1) / shopAuditQuestions.length,
            backgroundColor: AppColors.cardBorder,
            color: AppColors.emeraldGreen,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Question ${_currentPage + 1} / ${shopAuditQuestions.length}',
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12.5),
            ),
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: shopAuditQuestions.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, index) {
              final q = shopAuditQuestions[index];
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      q.question,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, height: 1.4),
                    ),
                    const SizedBox(height: 20),
                    ...List.generate(q.options.length, (optIndex) {
                      final label = String.fromCharCode(65 + optIndex); // A, B, C
                      final isSelected = _answers[index] == optIndex;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Material(
                          color: isSelected
                              ? AppColors.royalBlue.withValues(alpha: 0.08)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () => _selectOption(index, optIndex),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.royalBlue
                                      : AppColors.cardBorder,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor:
                                        isSelected ? AppColors.royalBlue : AppColors.surface,
                                    child: Text(
                                      label,
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : AppColors.textPrimary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(q.options[optIndex],
                                        style: const TextStyle(fontSize: 14.5, height: 1.3)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ResultView extends StatelessWidget {
  final ShopAuditResult result;
  final VoidCallback onRestart;

  const _ResultView({required this.result, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    final isLow = result.healthScorePercent < 40;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Center(
          child: Column(
            children: [
              SizedBox(
                width: 140,
                height: 140,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: result.healthScorePercent / 100,
                      strokeWidth: 12,
                      backgroundColor: AppColors.cardBorder,
                      color: isLow ? AppColors.crimsonRed : AppColors.emeraldGreen,
                    ),
                    Text(
                      '${result.healthScorePercent.toStringAsFixed(0)}%',
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Store Health Score',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isLow ? AppColors.crimsonRed : AppColors.emeraldGreen,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        if (result.gaps.isNotEmpty)
          Card(
            color: isLow ? AppColors.crimsonRed.withValues(alpha: 0.06) : null,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'आपके धंधे में ${result.gaps.length} बड़ी कमियां हैं:',
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15.5),
                  ),
                  const SizedBox(height: 10),
                  ...result.gaps.asMap().entries.map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 11,
                                backgroundColor: AppColors.crimsonRed,
                                child: Text('${e.key + 1}',
                                    style: const TextStyle(color: Colors.white, fontSize: 11)),
                              ),
                              const SizedBox(width: 10),
                              Expanded(child: Text(e.value, style: const TextStyle(fontSize: 14))),
                            ],
                          ),
                        ),
                      ),
                ],
              ),
            ),
          )
        else
          Card(
            color: AppColors.emeraldGreen.withValues(alpha: 0.08),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'बढ़िया! आपकी दुकान डिजिटल रूप से काफी तैयार है। '
                'अगले टैब्स में मार्केटिंग और सोर्सिंग टिप्स देखें।',
                style: TextStyle(fontSize: 14.5),
              ),
            ),
          ),
        const SizedBox(height: 20),
        OutlinedButton.icon(
          onPressed: onRestart,
          icon: const Icon(Icons.refresh_rounded),
          label: const Text('Retake Quiz'),
        ),
      ],
    );
  }
}
