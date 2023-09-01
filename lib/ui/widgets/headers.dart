import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HandleitCustomHeader extends ConsumerWidget {
  const HandleitCustomHeader({super.key, this.title, this.actions, this.leading});
  final Widget? leading;
  final String? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        leading == null
            ? const SizedBox(width: 24)
            : Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 24),
                  leading ?? const SizedBox.shrink(),
                  const SizedBox(width: 8),
                ],
              ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 16, 24, 16),
            child: Text(
              title ?? '',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          children: actions ?? [],
        ),
      ],
    );
  }
}
