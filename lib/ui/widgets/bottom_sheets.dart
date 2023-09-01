import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

class BaseBottomSheetContainer extends ConsumerWidget {
  const BaseBottomSheetContainer({super.key, required this.child, this.title, this.action});

  final String? title;
  final Widget? action;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Theme.of(context).primaryColor.withAlpha(40),
      borderRadius: const BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: Theme.of(context).colorScheme.background,
          ),
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Theme.of(context).disabledColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    title == null
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            child: Text(
                              title ?? '',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
                            ).alignment(Alignment.centerLeft),
                          ),
                    action == null ? const SizedBox.shrink() : action!,
                  ],
                ),
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
