import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handlit_flutter/utils/routes.dart';
import 'package:handlit_flutter/utils/styles/theme_data.dart';

void main() {
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text('Hello, World!'),
      ),
    );
  }
}
