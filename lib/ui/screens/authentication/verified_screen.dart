import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class VerifiedScreen extends ConsumerStatefulWidget {
  const VerifiedScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerifiedScreenState();
}

class _VerifiedScreenState extends ConsumerState<VerifiedScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 2), () {
        context.pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_rounded, size: 60, color: Theme.of(context).colorScheme.onSecondaryContainer),
              const SizedBox(height: 24),
              const Text('Verified!', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
