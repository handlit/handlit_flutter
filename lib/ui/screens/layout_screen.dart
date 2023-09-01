import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LayoutScreen extends ConsumerStatefulWidget {
  const LayoutScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends ConsumerState<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text('Hello, World!'),
      ),
    );
  }
}
