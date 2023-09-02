import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handlit_flutter/controllers/user_info.dart';
import 'package:handlit_flutter/ui/widgets/widgets.dart';
import 'package:handlit_flutter/utils/routes.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    Future(() => ref.read(userInfoAsyncController.notifier).getUserInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width * 0.6,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 24),
              ref.watch(userInfoAsyncController).when(
                data: (data) {
                  if (data != null && (data.isAuth ?? false)) {
                    Future(() => context.go('/${HandleItRoutes.layout.name}'));
                  }
                  return CustomChipBox(
                    onTap: () => context.go('/${HandleItRoutes.registerWallet.name}'),
                    child: Text(
                      'PRESS TO CONTINUE',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Theme.of(context).primaryColor.withOpacity(0.5),
                            fontSize: 16,
                          ),
                    ),
                  );
                },
                loading: () {
                  return const SizedBox(width: 24, height: 24, child: CircularProgressIndicator());
                },
                error: (error, stackTrace) {
                  context.go('/${HandleItRoutes.registerWallet.name}');
                  return CustomChipBox(
                    onTap: () => context.go('/${HandleItRoutes.registerWallet.name}'),
                    child: Text(
                      'PRESS TO CONTINUE',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Theme.of(context).primaryColor.withOpacity(0.5),
                            fontSize: 16,
                          ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
