import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handlit_flutter/ui/screens/authentication/telegram_auth_code_input_screen.dart';
import 'package:handlit_flutter/ui/screens/authentication/telegram_phone_input_screen.dart';
import 'package:handlit_flutter/ui/screens/screens.dart';

enum HandleItRoutes {
  // unauthenticated
  onboarding,
  registerWallet,
  telegramPhoneInput,
  telegramAuthCodeInput,
  verified,
  // authenticated
  layout,
  home,
}

final goRouterStateProvider = StateProvider<GoRouter>(
  (ref) {
    return GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const OnboardingScreen()),
        GoRoute(
          path: '/${HandleItRoutes.registerWallet.name}',
          builder: (context, state) => const RegisterWalletScreen(),
        ),
        GoRoute(
          path: '/${HandleItRoutes.telegramPhoneInput.name}',
          builder: (context, state) => const TelegramPhoneInputScreen(),
        ),
        GoRoute(
          path: '/${HandleItRoutes.telegramAuthCodeInput.name}',
          builder: (context, state) => const TelegramAuthCodeInputScreen(),
        ),
        GoRoute(
          path: '/${HandleItRoutes.verified.name}',
          pageBuilder: (context, state) => RouteTransition.withoutAnimationTransition(const VerifiedScreen()),
        ),
        GoRoute(
          path: '/${HandleItRoutes.layout.name}',
          builder: (context, state) => const LayoutScreen(),
        ),
        GoRoute(
          path: '/${HandleItRoutes.home.name}',
          builder: (context, state) => const HomeScreen(),
        ),
      ],
      errorBuilder: (context, state) => const ErrorScreen(),
    );
  },
);

class RouteTransition {
  const RouteTransition();
  static withFadeTransition(Widget child) {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation), child: child);
      },
    );
  }

  static withoutAnimationTransition(Widget child) {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }
}
