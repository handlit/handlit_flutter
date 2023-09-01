import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorScreen extends ConsumerStatefulWidget {
  const ErrorScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends ConsumerState<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
