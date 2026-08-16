import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../widgets/marquee_disclaimer.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/language_selection/providers/language_provider.dart' show LanguageProvider;
import '../../features/language_selection/screens/language_selection_screen.dart';
import '../../features/module_a/screens/module_a_input_screen.dart';
import '../../features/module_a/screens/module_a_output_screen.dart';
import '../../features/module_a/screens/module_a_paywall_screen.dart';
import '../../features/module_b/screens/module_b_dashboard_screen.dart';
import '../../features/module_c/screens/module_c_dashboard_screen.dart';
import '../../features/module_c/screens/module_c_input_screen.dart';
import '../../features/module_c/screens/module_c_paywall_screen.dart';

class AppRouter {
  static GoRouter router(LanguageProvider languageProvider) {
    return GoRouter(
      initialLocation: languageProvider.hasOnboarded ? '/dashboard' : '/language',
      routes: [
        GoRoute(
          path: '/language',
          builder: (context, state) {
            final isSwitch = state.uri.queryParameters['switch'] == 'true';
            return LanguageSelectionScreen(isSwitchMode: isSwitch);
          },
        ),
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),

        // Mandatory disclaimer gate — shown every time before Module A's
        // inputs, so "we are not a SEBI-registered adviser, educational
        // only, invest at your own risk" is read and acknowledged before
        // any numbers are generated, not just skimmable in a footer.
        GoRoute(
          path: '/module-a-disclaimer',
          builder: (context, state) {
            final lang = context.read<LanguageProvider>().language;
            return DisclaimerGateScreen(
              language: lang,
              onAcknowledge: () => context.go('/module-a'),
            );
          },
        ),

        // Module A: Mass Market Investment & Savings Guide
        GoRoute(
          path: '/module-a',
          builder: (context, state) => const ModuleAInputScreen(),
          routes: [
            GoRoute(
              path: 'paywall',
              builder: (context, state) => const ModuleAPaywallScreen(),
            ),
            GoRoute(
              path: 'output',
              builder: (context, state) => const ModuleAOutputScreen(),
            ),
          ],
        ),

        // Module B: Digital Merchant Rescue Suite
        GoRoute(
          path: '/module-b',
          builder: (context, state) => const ModuleBDashboardScreen(),
        ),

        // Module C: Premium Startup Advisory
        GoRoute(
          path: '/module-c',
          builder: (context, state) => const ModuleCInputScreen(),
          routes: [
            GoRoute(
              path: 'paywall',
              builder: (context, state) => const ModuleCPaywallScreen(),
            ),
            GoRoute(
              path: 'dashboard',
              builder: (context, state) => const ModuleCDashboardScreen(),
            ),
          ],
        ),
      ],
    );
  }
}
