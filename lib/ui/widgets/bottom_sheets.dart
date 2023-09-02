import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handlit_flutter/controllers/handlit_actions.dart';
import 'package:handlit_flutter/controllers/user_card.dart';
import 'package:handlit_flutter/controllers/user_info.dart';
import 'package:handlit_flutter/repositories/scan_qr_repository.dart';
import 'package:handlit_flutter/ui/screens/layout_screen.dart';
import 'package:handlit_flutter/ui/widgets/custom_snackbar.dart';
import 'package:handlit_flutter/ui/widgets/profile_card.dart';
import 'package:handlit_flutter/ui/widgets/widgets.dart';
import 'package:handlit_flutter/utils/routes.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
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

final handlitImageProvider = StateProvider<XFile?>((ref) => null);
final handlitImageCroppedFileProvider = StateProvider<CroppedFile?>((ref) => null);
final editedhandlitImageProvider = StateProvider<File?>((ref) => null);

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
    _hiMessageEditingController = TextEditingController(text: 'Hi, I\'m ${ref.read(userInfoAsyncController).value?.user?.userName ?? ''}!');
    _hiMessageFocusNode = FocusNode();
    Future(() {
      ref.read(handlitImageProvider.notifier).state = null;
      ref.read(handlitImageCroppedFileProvider.notifier).state = null;
      ref.read(editedhandlitImageProvider.notifier).state = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _hiMessageEditingController.dispose();
    _hiMessageFocusNode.dispose();
  }

  Future<void> _pickImage() async {
    try {
      ImagePicker().pickImage(source: ImageSource.camera).then((value) {
        ref.read(handlitImageProvider.notifier).state = value;
      }).whenComplete(() async {
        if (ref.read(handlitImageProvider) == null) {
          CustomSnackbar.show(context, 'Failed to import image.\nPlease try again with a file in .png format.');
          ref.read(handlitImageProvider.notifier).state = null;
          ref.read(handlitImageCroppedFileProvider.notifier).state = null;
          return;
        }
        try {
          await cropper.cropImage(
            aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
            sourcePath: ref.read(handlitImageProvider)?.path ?? '',
            compressFormat: ImageCompressFormat.png,
            aspectRatioPresets: [CropAspectRatioPreset.square],
            uiSettings: [
              AndroidUiSettings(
                toolbarTitle: 'CROP',
                toolbarColor: Theme.of(context).colorScheme.secondary,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false,
              ),
              IOSUiSettings(),
            ],
          ).then((value) {
            ref.read(handlitImageCroppedFileProvider.notifier).state = value;
          }).whenComplete(() async {
            if (ref.read(handlitImageCroppedFileProvider) == null) {
              ref.read(handlitImageProvider.notifier).state = null;
              ref.read(handlitImageCroppedFileProvider.notifier).state = null;
              CustomSnackbar.show(context, 'An error occurred while cropping the image.');
              return;
            } else {
              File file = File(ref.read(handlitImageCroppedFileProvider)!.path);
              int sizeInBytes = file.lengthSync();
              double sizeInMb = sizeInBytes / (1024 * 1024);
              if (sizeInMb > 20) {
                // Do nothing!
                ref.read(handlitImageProvider.notifier).state = null;
                ref.read(handlitImageCroppedFileProvider.notifier).state = null;
                CustomSnackbar.show(context, 'Only files smaller than 20MB can be uploaded.');
              } else {
                ref.read(editedhandlitImageProvider.notifier).state = File(ref.read(handlitImageCroppedFileProvider)!.path);
              }
            }
          });
        } catch (e) {
          ref.read(handlitImageProvider.notifier).state = null;
          ref.read(handlitImageCroppedFileProvider.notifier).state = null;
          CustomSnackbar.show(context, 'An error occurred while cropping the image.');
        }
      });
    } catch (e) {
      ref.read(handlitImageProvider.notifier).state = null;
      ref.read(handlitImageCroppedFileProvider.notifier).state = null;
      CustomSnackbar.show(context, 'Failed to upload image.\nPlease try again.');
    }
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
                          onTap: () {
                            context.pop();
                            ref.read(scanQrProvider).scanQRCode(context).then((value) => ref.read(scanQrProvider).showInputBottomSheet(context));
                          },
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
                        ),
                        const SizedBox(height: 16),
                        Text('Take/Upload a photo (Optional)', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
                        const SizedBox(height: 4),
                        Text(
                          'Take a selfie with your new friend to capture the moment! 🤳',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomThemeButton(
                              onTap: _pickImage,
                              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                              child: SizedBox(
                                width: 200,
                                height: 200,
                                child: ref.watch(handlitImageProvider) != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.file(
                                          ref.watch(editedhandlitImageProvider) ?? File(''),
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Icon(Icons.person, size: 50, color: Colors.white);
                                          },
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Text('Send my social token (Optional)', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
                        // const SizedBox(height: 8),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Icon(Icons.check_circle, color: Theme.of(context).colorScheme.secondary, size: 24),
                        //     const SizedBox(height: 8),
                        //     CustomThemeButton(
                        //       onTap: () {},
                        //       child: SizedBox(
                        //         width: 200,
                        //         height: 200,
                        //         child: ClipRRect(
                        //           borderRadius: BorderRadius.circular(8),
                        //           child: CachedNetworkImage(
                        //             imageUrl: 'https://picsum.photos/id/237/400',
                        //             fit: BoxFit.cover,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 24),
                        CustomThemeButton(
                          backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                          onTap: ref.watch(handlitActionsAsyncController).isLoading
                              ? null
                              : () async {
                                  await ref
                                      .read(handlitActionsAsyncController.notifier)
                                      .sendFriendRequest(
                                        ref.read(userCardListAsyncController).value?.list?[0].id ?? '',
                                        ref.watch(qrScannedProvider) ?? '',
                                        _hiMessageEditingController.text,
                                        ref.read(editedhandlitImageProvider),
                                      )
                                      .whenComplete(() {
                                    if (ref.watch(handlitActionsAsyncController).hasError) {
                                      CustomSnackbar.show(context, 'An error occurred while sending a friend request.\nPlease try again.');
                                    } else {
                                      context.pop();
                                      context.push('/${HandleItRoutes.friendRequestSent.name}');
                                    }
                                  });
                                },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 54,
                            padding: const EdgeInsets.all(12),
                            child: ref.watch(handlitActionsAsyncController).isLoading
                                ? const SizedBox(width: 30, height: 30, child: CircularProgressIndicator())
                                : Text(
                                    'Send friend request via Telegram',
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16, color: Theme.of(context).colorScheme.background),
                                  ),
                          ),
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
