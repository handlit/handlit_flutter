import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handlit_flutter/ui/screens/screens.dart';

enum HandleItRoutes {
  onboarding,
  home,
}

final goRouterStateProvider = StateProvider<GoRouter>(
  (ref) {
    return GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const OnboardingScreen()),
        GoRoute(
          path: '/${HandleItRoutes.home.name}',
          builder: (context, state) => const HomeScreen(),
        ),
      ],
      errorBuilder: (context, state) => const ErrorScreen(),
    );
  },
);
