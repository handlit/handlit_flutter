import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handlit_flutter/ui/screens/home/home.dart';
import 'package:handlit_flutter/ui/widgets/custom_snackbar.dart';
import 'package:handlit_flutter/ui/widgets/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

final profileImageProvider = StateProvider<XFile?>((ref) => null);
final profileImageCroppedFileProvider = StateProvider<CroppedFile?>((ref) => null);
final editedProfileImageProvider = StateProvider<File?>((ref) => null);
final capturedImageProvider = StateProvider<File?>((ref) => null);

ImageCropper cropper = ImageCropper();

class ProfileCardContainer extends ConsumerStatefulWidget {
  const ProfileCardContainer({
    super.key,
    this.nameFocusNode,
    this.emailFocusNode,
    this.companyNameFocusNode,
    this.titleFocusNode,
    this.selfDescriptionFocusNode,
    this.unFocusTapped,
  });

  final FocusNode? nameFocusNode;
  final FocusNode? emailFocusNode;
  final FocusNode? companyNameFocusNode;
  final FocusNode? titleFocusNode;
  final FocusNode? selfDescriptionFocusNode;
  final VoidCallback? unFocusTapped;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileCardContainerState();
}

class _ProfileCardContainerState extends ConsumerState<ProfileCardContainer> with SingleTickerProviderStateMixin {
  late final double _cardSize = 350;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
        ref.read(profileImageProvider.notifier).state = value;
      }).whenComplete(() async {
        if (ref.read(profileImageProvider) == null) {
          CustomSnackbar.show(context, 'Failed to import image.\nPlease try again with a file in .png format.');
          ref.read(profileImageProvider.notifier).state = null;
          ref.read(profileImageCroppedFileProvider.notifier).state = null;
          return;
        }
        try {
          await cropper.cropImage(
            aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
            sourcePath: ref.read(profileImageProvider)?.path ?? '',
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
            ref.read(profileImageCroppedFileProvider.notifier).state = value;
          }).whenComplete(() async {
            if (ref.read(profileImageCroppedFileProvider) == null) {
              ref.read(profileImageProvider.notifier).state = null;
              ref.read(profileImageCroppedFileProvider.notifier).state = null;
              CustomSnackbar.show(context, 'An error occurred while cropping the image.');
              return;
            } else {
              File file = File(ref.read(profileImageCroppedFileProvider)!.path);
              int sizeInBytes = file.lengthSync();
              double sizeInMb = sizeInBytes / (1024 * 1024);
              if (sizeInMb > 20) {
                // Do nothing!
                ref.read(profileImageProvider.notifier).state = null;
                ref.read(profileImageCroppedFileProvider.notifier).state = null;
                CustomSnackbar.show(context, 'Only files smaller than 20MB can be uploaded.');
              } else {
                ref.read(editedProfileImageProvider.notifier).state = File(ref.read(profileImageCroppedFileProvider)!.path);
              }
            }
          });
        } catch (e) {
          ref.read(profileImageProvider.notifier).state = null;
          ref.read(profileImageCroppedFileProvider.notifier).state = null;
          CustomSnackbar.show(context, 'An error occurred while cropping the image.');
        }
      });
    } catch (e) {
      ref.read(profileImageProvider.notifier).state = null;
      ref.read(profileImageCroppedFileProvider.notifier).state = null;
      CustomSnackbar.show(context, 'Failed to upload image.\nPlease try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 48,
          height: (MediaQuery.of(context).size.width - 48),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Builder(builder: (context) {
                return Transform.scale(
                  scale: (MediaQuery.of(context).size.width - 48) / _cardSize,
                  child: Container(
                    width: _cardSize,
                    height: _cardSize,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 24),
                          width: _cardSize * 0.3,
                          height: _cardSize * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(_cardSize),
                            color: Theme.of(context).colorScheme.onSecondaryContainer.withOpacity(0.2),
                          ),
                          child: ref.watch(editedProfileImageProvider) != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(_cardSize),
                                  child: Image.file(
                                    ref.watch(editedProfileImageProvider) ?? File(''),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.person, size: 50, color: Colors.white);
                                    },
                                  ),
                                )
                              : Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Lottie.asset(
                                      'assets/lotties/profile_animation.json',
                                      controller: _animationController,
                                      onLoaded: (composition) {
                                        _animationController
                                          ..duration = composition.duration
                                          ..repeat();
                                      },
                                    ),
                                    CustomThemeButton(
                                      backgroundColor: Theme.of(context).colorScheme.background,
                                      borderRadius: 20,
                                      onTap: _pickImage,
                                      child: Padding(padding: const EdgeInsets.all(4), child: Icon(Icons.add, color: Theme.of(context).colorScheme.onSecondaryContainer)),
                                    ).alignment(Alignment.bottomRight),
                                  ],
                                ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: const BoxConstraints(minWidth: 100),
                              margin: const EdgeInsets.fromLTRB(24, 6, 24, 0),
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: (widget.nameFocusNode?.hasFocus ?? false) ? Theme.of(context).colorScheme.secondary : Colors.transparent,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: AutoSizeText(
                                (ref.watch(nameProvider) ?? '').isEmpty ? 'John Doe' : ref.watch(nameProvider) ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontSize: 22, color: (ref.watch(nameProvider) ?? '').isEmpty ? Theme.of(context).colorScheme.primary.withOpacity(0.3) : null),
                                maxLines: 1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          constraints: const BoxConstraints(minWidth: 100),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: (widget.emailFocusNode?.hasFocus ?? false) ? Theme.of(context).colorScheme.secondary : Colors.transparent,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: AutoSizeText(
                            (ref.watch(emailProvider) ?? 'ethconSeoul@handlit.com').isEmpty ? 'ethconSeoul@handlit.com' : ref.watch(emailProvider) ?? 'ethconSeoul@handlit.com',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: (ref.watch(emailProvider) ?? '').isEmpty ? Theme.of(context).colorScheme.primary.withOpacity(0.2) : Theme.of(context).colorScheme.primary.withOpacity(0.6),
                                ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          constraints: const BoxConstraints(minWidth: 220),
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                constraints: const BoxConstraints(minWidth: 100),
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  color: (widget.companyNameFocusNode?.hasFocus ?? false) ? Theme.of(context).colorScheme.secondary : Colors.transparent,
                                ),
                                child: AutoSizeText(
                                  (ref.watch(companyNameProvider) ?? 'Handlit corp.').isEmpty ? 'Handlit corp.' : ref.watch(companyNameProvider) ?? 'Handlit corp.',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        fontSize: 13,
                                        color: (ref.watch(companyNameProvider) ?? '').isEmpty ? Theme.of(context).colorScheme.primary.withOpacity(0.3) : null,
                                      ),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                constraints: const BoxConstraints(minWidth: 100),
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  color: (widget.titleFocusNode?.hasFocus ?? false) ? Theme.of(context).colorScheme.secondary : Colors.transparent,
                                ),
                                child: AutoSizeText(
                                  (ref.watch(titleProvider) ?? '').isEmpty ? 'Software Engineer' : ref.watch(titleProvider) ?? '',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontSize: 13,
                                        color:
                                            (ref.watch(titleProvider) ?? '').isEmpty ? Theme.of(context).colorScheme.primary.withOpacity(0.3) : Theme.of(context).colorScheme.primary.withOpacity(0.7),
                                      ),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            alignment: Alignment.center,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              color: Theme.of(context).colorScheme.onSecondaryContainer.withOpacity(0.1),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(minWidth: 100),
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: (widget.selfDescriptionFocusNode?.hasFocus ?? false) ? Theme.of(context).colorScheme.secondary : Colors.transparent,
                              ),
                              child: AutoSizeText(
                                (ref.watch(selfDescriptionProvider) ?? '').isEmpty ? 'Hi there! I am an app developer\nat Handleit corp. 👋' : ref.watch(selfDescriptionProvider) ?? '',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: (ref.watch(selfDescriptionProvider) ?? '').isEmpty
                                          ? Theme.of(context).colorScheme.primary.withOpacity(0.4)
                                          : Theme.of(context).colorScheme.primary.withOpacity(0.8),
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).elevation(
                    4,
                    borderRadius: BorderRadius.circular(10),
                    shadowColor: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
