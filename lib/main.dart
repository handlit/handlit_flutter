import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handlit_flutter/utils/routes.dart';
import 'package:handlit_flutter/utils/styles/theme_data.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(const ProviderScope(child: HandlitApp()));
}

class HandlitApp extends ConsumerWidget {
  const HandlitApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Handlit',
      routerConfig: ref.watch(goRouterStateProvider),
      theme: CustomThemeData.lightMode,
    );
  }
}
