import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:handlit_flutter/controllers/exchanged_card.dart';
import 'package:handlit_flutter/controllers/user_card.dart';
import 'package:handlit_flutter/models/exchanged_card.dart';
import 'package:handlit_flutter/repositories/api/exception/exception_wrapper.dart';
import 'package:handlit_flutter/ui/widgets/custom_snackbar.dart';
import 'package:handlit_flutter/ui/widgets/profile_card.dart';
import 'package:handlit_flutter/ui/widgets/widgets.dart';
import 'package:handlit_flutter/utils/routes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

final nameProvider = StateProvider<String?>((ref) => null);
final emailProvider = StateProvider<String?>((ref) => null);
final companyNameProvider = StateProvider<String?>((ref) => null);
final titleProvider = StateProvider<String?>((ref) => null);
final selfDescriptionProvider = StateProvider<String?>((ref) => null);

final selectedCardItemObjProvider = StateProvider<ExchangedCardItemObj?>((ref) => null);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Uint8List? bytes;
  late final WidgetsToImageController _widgetsToImageController = WidgetsToImageController();

  late ScrollController _scrollController;

  late TextEditingController _nameEditingController;
  late TextEditingController _emailEditingController;
  late TextEditingController _companyNameEditingController;
  late TextEditingController _titleEditingController;
  late TextEditingController _selfDescriptionEditingController;
  late FocusNode _nameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _companyNameFocusNode;
  late FocusNode _titleFocusNode;
  late FocusNode _selfDescriptionFocusNode;

  bool _canMint() {
    return ref.watch(editedProfileImageProvider) != null &&
        ref.watch(nameProvider) != null &&
        ref.watch(emailProvider) != null &&
        ref.watch(companyNameProvider) != null &&
        ref.watch(titleProvider) != null;
  }

  Future<void> _capture() async {
    final capturedBytes = await _widgetsToImageController.capture();
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/image.png').create();
    file.writeAsBytesSync(capturedBytes!);
    ref.read(capturedImageProvider.notifier).state = file;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _nameEditingController = TextEditingController();
    _emailEditingController = TextEditingController();
    _companyNameEditingController = TextEditingController();
    _titleEditingController = TextEditingController();
    _selfDescriptionEditingController = TextEditingController();

    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _companyNameFocusNode = FocusNode();
    _titleFocusNode = FocusNode();
    _selfDescriptionFocusNode = FocusNode();

    Future(() {
      ref.read(userCardListAsyncController.notifier).getUserCardList();
      ref.read(exchangedCardAsyncController.notifier).getExchangedCards();
      _nameFocusNode.requestFocus();
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();

    _nameEditingController.dispose();
    _emailEditingController.dispose();
    _companyNameEditingController.dispose();
    _titleEditingController.dispose();
    _selfDescriptionEditingController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _companyNameFocusNode.dispose();
    _titleFocusNode.dispose();
    _selfDescriptionFocusNode.dispose();
  }

  Future<void> createNewCard() async {
    Future(() => FocusScope.of(context).unfocus());
    await _capture();
    ref.watch(editedProfileImageProvider)!;
    ref.watch(capturedImageProvider)!;

    await ref.read(userCardListAsyncController.notifier).mintUserCard({
      "name": ref.read(nameProvider),
      "email": ref.read(emailProvider),
      "company": ref.read(companyNameProvider),
      "title": ref.read(titleProvider),
      "description": ref.read(selfDescriptionProvider),
    }, [
      ref.read(editedProfileImageProvider)!,
      ref.read(capturedImageProvider)!
    ]).whenComplete(() {
      if (ref.read(userCardListAsyncController).hasError) {
        print('error;;;;;;;;;;;');
        final exception = ref.read(userCardListAsyncController).error as CustomException;
        CustomSnackbar.show(context, exception.message ?? '');
      } else {
        print('pop;;;;;;;;;;;');
        context.pop();
      }
    });
  }

  void showCardInputBottomSheet() {
    showModalBottomSheet(
      context: context,
      constraints: const BoxConstraints(minWidth: double.infinity),
      enableDrag: true,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.95,
            child: BaseBottomSheetContainer(
              title: 'Create New Card',
              action: Container(
                margin: const EdgeInsets.only(right: 24),
                child: ref.watch(userCardListAsyncController).isLoading
                    ? const CircularProgressIndicator()
                    : CustomChipBox(
                        tintColor: _canMint() ? Theme.of(context).colorScheme.onSecondaryContainer : Theme.of(context).colorScheme.primary.withOpacity(0.5),
                        onTap: createNewCard,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            'MINT',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 14, color: Theme.of(context).colorScheme.background),
                          ),
                        ),
                      ),
              ),
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        WidgetsToImage(
                            controller: _widgetsToImageController,
                            child: ProfileCardContainer(
                              nameFocusNode: _nameFocusNode,
                              emailFocusNode: _emailFocusNode,
                              companyNameFocusNode: _companyNameFocusNode,
                              titleFocusNode: _titleFocusNode,
                              selfDescriptionFocusNode: _selfDescriptionFocusNode,
                              unFocusTapped: () {
                                FocusScope.of(context).unfocus();
                                setState(() {});
                              },
                            ).gestures(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                              },
                            )),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name *', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
                              const SizedBox(height: 8),
                              CustomBoxInputFields(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                controller: _nameEditingController,
                                focusNode: _nameFocusNode,
                                isloading: ref.watch(userCardListAsyncController).isLoading,
                                placeholder: 'John Doe',
                                onTap: () {
                                  _nameFocusNode.requestFocus();
                                  setState(() {});
                                },
                                onChanged: (p0) {
                                  ref.read(nameProvider.notifier).state = p0;
                                  setState(() {});
                                },
                              ),
                              const SizedBox(height: 16),
                              Text('E-mail *', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
                              const SizedBox(height: 8),
                              CustomBoxInputFields(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                controller: _emailEditingController,
                                focusNode: _emailFocusNode,
                                placeholder: 'ethconSeoul@handlit.com',
                                isloading: ref.watch(userCardListAsyncController).isLoading,
                                onTap: () {
                                  _emailFocusNode.requestFocus();
                                  setState(() {});
                                },
                                onChanged: (p0) {
                                  ref.read(emailProvider.notifier).state = p0;
                                  setState(() {});
                                },
                              ),
                              const SizedBox(height: 16),
                              Text('Company *', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
                              const SizedBox(height: 8),
                              CustomBoxInputFields(
                                focusNode: _companyNameFocusNode,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                controller: _companyNameEditingController,
                                placeholder: 'Handleit corp.',
                                isloading: ref.watch(userCardListAsyncController).isLoading,
                                onTap: () {
                                  _companyNameFocusNode.requestFocus();
                                  setState(() {});
                                },
                                onChanged: (p0) {
                                  ref.read(companyNameProvider.notifier).state = p0;
                                  setState(() {});
                                },
                              ),
                              const SizedBox(height: 16),
                              Text('Title *', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
                              const SizedBox(height: 8),
                              CustomBoxInputFields(
                                focusNode: _titleFocusNode,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                controller: _titleEditingController,
                                placeholder: 'Software Engineer',
                                isloading: ref.watch(userCardListAsyncController).isLoading,
                                onTap: () {
                                  _titleFocusNode.requestFocus();
                                  setState(() {});
                                },
                                onChanged: (p0) {
                                  ref.read(titleProvider.notifier).state = p0;
                                  setState(() {});
                                },
                              ),
                              const SizedBox(height: 16),
                              Text('Self description *', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
                              const SizedBox(height: 8),
                              CustomBoxInputFields(
                                focusNode: _selfDescriptionFocusNode,
                                textHeight: 1.2,
                                minLine: 2,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                controller: _selfDescriptionEditingController,
                                isloading: ref.watch(userCardListAsyncController).isLoading,
                                placeholder: 'Hi there! I am an app developer at Handleit corp. 👋',
                                onTap: () {
                                  _selfDescriptionFocusNode.requestFocus();
                                  setState(() {});
                                },
                                onChanged: (p0) {
                                  ref.read(selfDescriptionProvider.notifier).state = p0;
                                  setState(() {});
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
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.03)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ref.watch(userCardListAsyncController).when(
                        loading: () {
                          return const Center(child: CircularProgressIndicator());
                        },
                        data: (cardListObj) {
                          if (cardListObj == null || (cardListObj.list?.isEmpty ?? true)) {
                            return _CreateCardButton(onTap: showCardInputBottomSheet);
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(24),
                              child: CachedNetworkImage(imageUrl: cardListObj.list?[0].imageUrl ?? ''),
                            );
                          }
                        },
                        error: (Object error, StackTrace stackTrace) {
                          return SizedBox(
                            width: double.infinity,
                            height: 80,
                            child: Center(
                              child: Column(
                                children: [
                                  const Text('Something went wrong!'),
                                  const SizedBox(height: 12),
                                  CustomChipBox(
                                    child: const Text('REFRESH'),
                                    onTap: () => ref.read(userCardListAsyncController.notifier).getUserCardList(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Opacity(
                  opacity: ref.watch(userCardListAsyncController).isLoading || (ref.watch(userCardListAsyncController).value?.list?.isEmpty ?? true) ? 0.2 : 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _CardActionButton(
                          iconWidget: const Icon(Icons.download),
                          label: 'Download',
                          onTap: ref.watch(userCardListAsyncController).isLoading || (ref.watch(userCardListAsyncController).value?.list?.isEmpty ?? true)
                              ? null
                              : () async {
                                  await launchUrl(
                                    Uri.parse(ref.watch(userCardListAsyncController).value?.list?[0].imageUrl ?? ''),
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                        ),
                        _CardActionButton(
                          iconWidget: const Icon(Icons.qr_code),
                          label: 'QR Code',
                          onTap: ref.watch(userCardListAsyncController).isLoading || (ref.watch(userCardListAsyncController).value?.list?.isEmpty ?? true)
                              ? null
                              : () {
                                  context.push('/${HandleItRoutes.qrScan.name}');
                                },
                        ),
                        _CardActionButton(
                          iconWidget: const Icon(Icons.ios_share),
                          label: 'Share',
                          onTap: ref.watch(userCardListAsyncController).isLoading || (ref.watch(userCardListAsyncController).value?.list?.isEmpty ?? true)
                              ? null
                              : () {
                                  Share.share(ref.watch(userCardListAsyncController).value?.list?[0].imageUrl ?? '');
                                },
                        ),
                        _CardActionButton(
                          iconWidget: const FaIcon(FontAwesomeIcons.telegram),
                          label: 'Telegram',
                          onTap: ref.watch(userCardListAsyncController).isLoading || (ref.watch(userCardListAsyncController).value?.list?.isEmpty ?? true)
                              ? null
                              : () {
                                  launchUrl(
                                    Uri.parse('https://t.me/share/url?url=${ref.watch(userCardListAsyncController).value?.list?[0].imageUrl ?? ''}'),
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.03)),
              child: ref.watch(exchangedCardAsyncController).when(
                data: (exchangedCardsObj) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Cards (${exchangedCardsObj?.list?.length ?? 0})', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
                            // Icon(
                            //   Icons.keyboard_arrow_down_rounded,
                            //   color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                            // ),
                          ],
                        ),
                      ).gestures(
                        onTap: () => {
                          // fold/unfold cards
                        },
                      ),
                      (exchangedCardsObj?.list?.length ?? 0) == 0
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: SizedBox(
                                width: double.infinity,
                                height: 40,
                                child: ListView.separated(
                                  physics: const ClampingScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, int index) {
                                    return CustomChipBox(
                                      tintColor: index == 0 ? Theme.of(context).colorScheme.secondaryContainer : Theme.of(context).primaryColor.withOpacity(0.1),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'September(${exchangedCardsObj?.list?.length ?? 0})',
                                            style: index == 0
                                                ? Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 12)
                                                : Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: 1,
                                  separatorBuilder: (BuildContext context, int index) {
                                    return const SizedBox(width: 12);
                                  },
                                ),
                              ),
                            ),
                      const SizedBox(height: 24),
                      GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 36),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          mainAxisExtent: (MediaQuery.of(context).size.width - 64) * 0.5,
                        ),
                        itemBuilder: (context, index) {
                          return CustomThemeButton(
                            backgroundColor: Theme.of(context).colorScheme.background,
                            onTap: () {
                              ref.read(selectedCardItemObjProvider.notifier).state = exchangedCardsObj?.list?[index];
                              context.push('/${HandleItRoutes.cardProfileDetail.name}');
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            SizedBox(
                                              width: (MediaQuery.of(context).size.width - 64) * 0.5 * 0.4,
                                              height: (MediaQuery.of(context).size.width - 64) * 0.5 * 0.4,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(50),
                                                child: CachedNetworkImage(
                                                  imageUrl: exchangedCardsObj?.list?[index].faceUrl ?? '',
                                                  fit: BoxFit.fitWidth,
                                                  width: (MediaQuery.of(context).size.width - 64) * 0.5 * 0.4,
                                                ),
                                              ),
                                            ),
                                            Image.asset('assets/images/verified.png', width: 24, height: 24),
                                          ],
                                        ),
                                        // Container(
                                        //   width: 32,
                                        //   height: 32,
                                        //   decoration: BoxDecoration(
                                        //     color: Theme.of(context).colorScheme.onSecondaryContainer,
                                        //     borderRadius: BorderRadius.circular(30),
                                        //   ),
                                        //   child: Center(child: Text('1', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 14, color: Theme.of(context).colorScheme.background))),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  AutoSizeText(
                                    exchangedCardsObj?.list?[index].name ?? '',
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 14),
                                    maxLines: 1,
                                  ),
                                  AutoSizeText(
                                    exchangedCardsObj?.list?[index].email ?? '',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: 4),
                                  AutoSizeText(
                                    exchangedCardsObj?.list?[index].company ?? '',
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 12, color: Theme.of(context).colorScheme.primary),
                                    maxLines: 1,
                                  ),
                                  AutoSizeText(
                                    exchangedCardsObj?.list?[index].title ?? '',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, color: Theme.of(context).colorScheme.primary),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: exchangedCardsObj?.list?.length ?? 0,
                      ),
                    ],
                  );
                },
                error: (error, stackTrace) {
                  return const SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                      child: Text('Something went wrong!'),
                    ),
                  );
                },
                loading: () {
                  return const SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardActionButton extends ConsumerWidget {
  const _CardActionButton({required this.onTap, required this.iconWidget, required this.label});

  final String label;
  final Widget iconWidget;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateCardButton extends ConsumerWidget {
  const _CreateCardButton({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: CustomThemeButton(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: 20,
              onTap: onTap,
              child: Container(
                width: (MediaQuery.of(context).size.width - 48),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Theme.of(context).colorScheme.background, size: 24),
                    ).elevation(
                      4,
                      borderRadius: BorderRadius.circular(30),
                      shadowColor: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Create My Card',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
