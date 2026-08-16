import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';
import 'features/language_selection/providers/language_provider.dart';
import 'features/module_a/providers/module_a_provider.dart';
import 'features/module_c/providers/module_c_provider.dart';

/// Entry point.
///
/// IMPORTANT (read before shipping):
/// This app is an educational / self-help toolkit for retail savings habits,
/// small-shop digital readiness, and generic startup planning frameworks.
/// It does NOT provide licensed SEBI investment advisory, licensed legal
/// filing, or certified tax-filing services. See [kGlobalDisclaimer] in
/// core/constants/app_strings.dart, and get a compliance/legal review before
/// a public release, especially for Module A (savings allocation tool) and
/// Module B Tab 4 (GST/ITR guidance).
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(CapxApp(prefs: prefs));
}

class CapxApp extends StatelessWidget {
  final SharedPreferences prefs;
  const CapxApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider(prefs)),
        ChangeNotifierProvider(create: (_) => ModuleAProvider()),
        ChangeNotifierProvider(create: (_) => ModuleCProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, _) {
          return MaterialApp.router(
            title: 'CAPX',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            routerConfig: AppRouter.router(languageProvider),
          );
        },
      ),
    );
  }
}
