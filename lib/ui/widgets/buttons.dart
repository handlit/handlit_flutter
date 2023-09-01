import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_widget/styled_widget.dart';

class CustomThemeButton extends ConsumerStatefulWidget {
  const CustomThemeButton({super.key, required this.child, required this.onTap, this.backgroundColor, this.borderRadius = 8});

  final Widget child;
  final void Function()? onTap;
  final Color? backgroundColor;
  final double borderRadius;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomThemeButtonState();
}

class _CustomThemeButtonState extends ConsumerState<CustomThemeButton> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: widget.child,
    )
        .elevation(
          isTapped ? 0 : 4,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          shadowColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
        )
        .gestures(
          onTapChange: (tapState) {
            setState(() => isTapped = tapState);
          },
          onTap: widget.onTap,
        )
        .scale(
          all: isTapped ? 0.97 : 1,
          animate: true,
        )
        .animate(
          const Duration(milliseconds: 250),
          Curves.easeOutCubic,
        );
  }
}

// ignore: must_be_immutable
class CustomFooterButton extends StatelessWidget {
  CustomFooterButton({
    super.key,
    this.onTap,
    required this.title,
    this.isDisabled = false,
    this.isProgressing = false,
  });

  final VoidCallback? onTap;
  final String title;
  bool isDisabled;
  final bool isProgressing;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDisabled || isProgressing ? Theme.of(context).secondaryHeaderColor : Theme.of(context).colorScheme.secondary,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled || isProgressing ? null : onTap,
          child: Container(
            height: 60 + MediaQuery.of(context).padding.bottom,
            width: double.infinity,
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isProgressing
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.onSecondary),
                          ),
                        ),
                  isProgressing ? Transform.scale(scale: 0.7, child: const CircularProgressIndicator()) : const SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomBackButton extends ConsumerWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        context.pop();
      },
      child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.arrow_back)),
    );
  }
}

class CustomChipBox extends ConsumerWidget {
  const CustomChipBox({
    required this.child,
    this.tintColor,
    this.gradient,
    this.border,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderRadius,
  });

  final Color? tintColor;
  final Gradient? gradient;
  final Widget child;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final Border? border;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius ?? BorderRadius.circular(10),
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 48),
        decoration: BoxDecoration(
          border: border ?? null,
          borderRadius: borderRadius ?? BorderRadius.circular(10),
          color: tintColor ?? Theme.of(context).primaryColor.withOpacity(0.1),
          gradient: gradient,
        ),
        padding: padding,
        child: child,
      ),
    );
  }
}
