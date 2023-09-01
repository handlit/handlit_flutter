import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handlit_flutter/ui/widgets/widgets.dart';
import 'package:handlit_flutter/utils/routes.dart';
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
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
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

class QRScanInputBottomSheet extends ConsumerStatefulWidget {
  const QRScanInputBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QRScanInputBottomSheetState();
}

class _QRScanInputBottomSheetState extends ConsumerState<QRScanInputBottomSheet> {
  late TextEditingController _hiMessageEditingController;
  late FocusNode _hiMessageFocusNode;

  @override
  void initState() {
    super.initState();
    _hiMessageEditingController = TextEditingController();
    _hiMessageFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _hiMessageEditingController.dispose();
    _hiMessageFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.95,
      child: BaseBottomSheetContainer(
        title: 'Add friend',
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Container(
                    width: MediaQuery.of(context).size.width - 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Telegram handle',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.background,
                                ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Scanned',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.background,
                              ),
                        ),
                        Icon(Icons.check, color: Theme.of(context).colorScheme.background, size: 12),
                        const SizedBox(width: 8),
                        CustomChipBox(
                          tintColor: Color.alphaBlend(Theme.of(context).colorScheme.background.withOpacity(0.1), Theme.of(context).colorScheme.secondary),
                          onTap: () {},
                          child: Text(
                            'Retake',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.background,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Send "Hi" message *', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
                        const SizedBox(height: 8),
                        CustomBoxInputFields(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                          controller: _hiMessageEditingController,
                          placeholder: 'Default message',
                          focusNode: _hiMessageFocusNode,
                          onChanged: (p0) {
                            setState(() {});
                          },
                          trailing: const Icon(Icons.keyboard_arrow_down_rounded),
                        ),
                        const SizedBox(height: 16),
                        Text('Take/Upload a photo (Optional)', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
                        const SizedBox(height: 4),
                        Text(
                          'Take a selfie with your new friend to capture the moment! 🤳',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                        ),
                        const SizedBox(height: 8),
                        CustomThemeButton(
                          onTap: () {
                            // TODO scan QR
                          },
                          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                  size: 32,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Upload a photo',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        fontSize: 14,
                                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text('Send my social token (Optional)', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.check_circle, color: Theme.of(context).colorScheme.secondary, size: 24),
                            const SizedBox(height: 8),
                            CustomThemeButton(
                              onTap: () {},
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: 'https://picsum.photos/id/237/200',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        CustomThemeButton(
                          backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 54,
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'Send friend request via Telegram',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16, color: Theme.of(context).colorScheme.background),
                            ),
                          ),
                          onTap: () {
                            context.pop();
                            context.push('/${HandleItRoutes.friendRequestSent.name}');
                          },
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
