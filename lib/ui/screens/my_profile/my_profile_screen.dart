// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handlit_flutter/repositories/local_pref.dart';
import 'package:handlit_flutter/ui/widgets/widgets.dart';

class MyProfileScreen extends ConsumerStatefulWidget {
  const MyProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends ConsumerState<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: CustomThemeButton(
          onTap: () async {
            Future(() async {
              (await ref.read(sharedPrefProvider)).clear();
              Future.delayed(const Duration(milliseconds: 500));
              context.go('/');
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            width: double.infinity,
            child: Text(
              'Sign out',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.background),
            ),
          ),
        ),
      ),
    );
  }
}
