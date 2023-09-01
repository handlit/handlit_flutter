import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:handlit_flutter/ui/widgets/widgets.dart';
import 'package:handlit_flutter/utils/routes.dart';
import 'package:styled_widget/styled_widget.dart';

final nameProvider = StateProvider<String?>((ref) => null);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late ScrollController _scrollController;
  late TextEditingController _nameEditingController;
  late TextEditingController _emailEditingController;
  late TextEditingController _companyNameEditingController;
  late TextEditingController _titleEditingController;
  late TextEditingController _selfDescriptionEditingController;
  late FocusNode _nameFocusNode;
  late FocusNode _emailFocusNode;

  late final double _cardSize = 350;

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

    Future(() {
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
  }

  Future<void> createNewCard() async {}

  void showCardInputBottomSheet() {
    showModalBottomSheet(
      context: context,
      constraints: const BoxConstraints(minWidth: double.infinity),
      enableDrag: true,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.95,
          child: BaseBottomSheetContainer(
            title: 'Create New Card',
            action: Container(
              margin: const EdgeInsets.only(right: 24),
              child: CustomChipBox(
                tintColor: Theme.of(context).colorScheme.onSecondaryContainer,
                onTap: () {},
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 48,
                        height: (MediaQuery.of(context).size.width - 48) * 9 / 7,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Builder(builder: (context) {
                              return Transform.scale(
                                scale: (MediaQuery.of(context).size.width - 48) / _cardSize,
                                child: Container(
                                  width: _cardSize,
                                  height: _cardSize * 9.0 / 7.0,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: _cardSize * 0.35,
                                            height: _cardSize * 0.45,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              color: Theme.of(context).colorScheme.secondary,
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(4),
                                              child: CachedNetworkImage(
                                                imageUrl: 'https://picsum.photos/id/237/200',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 16),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  // CustomChipBox(
                                                  //   child: Text('Going to ETH CC'),
                                                  // ),
                                                  // const SizedBox(height: 12),
                                                  // CustomChipBox(
                                                  //   child: Text('Based in 🇰🇷'),
                                                  // ),
                                                  // const SizedBox(height: 12),
                                                  InkWell(
                                                    onTap: () {
                                                      _nameFocusNode.requestFocus();
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          //dotted border
                                                          width: 1,
                                                          color: _nameFocusNode.hasFocus ? Theme.of(context).colorScheme.secondary : Colors.transparent,
                                                          style: BorderStyle.solid,
                                                        ),
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                      child: AutoSizeText(
                                                        ref.watch(nameProvider) ?? '',
                                                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 22),
                                                        maxLines: 3,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Community Manager',
                                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Developer relation',
                                        style:
                                            Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Contact',
                                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(Icons.email, size: 20, color: Theme.of(context).colorScheme.primary),
                                          const SizedBox(width: 4),
                                          Text(
                                            'qlqjsdmsz8@gmail.com',
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          FaIcon(FontAwesomeIcons.telegram, size: 20, color: Theme.of(context).colorScheme.primary),
                                          const SizedBox(width: 4),
                                          const Text('@swdoo'),
                                          // FaIcon(FontAwesomeIcons.linkedin, size: 20, color: Theme.of(context).colorScheme.primary),
                                          // const SizedBox(width: 4),
                                          // FaIcon(FontAwesomeIcons.twitter, size: 20, color: Theme.of(context).colorScheme.primary),
                                          // const SizedBox(width: 4),
                                          // FaIcon(FontAwesomeIcons.github, size: 20, color: Theme.of(context).colorScheme.primary),
                                          // const SizedBox(width: 4),
                                          // FaIcon(FontAwesomeIcons.facebook, size: 20, color: Theme.of(context).colorScheme.primary),
                                          // const SizedBox(width: 4),
                                          // FaIcon(FontAwesomeIcons.instagram, size: 20, color: Theme.of(context).colorScheme.primary),
                                          // const SizedBox(width: 4),
                                          // FaIcon(FontAwesomeIcons.youtube, size: 20, color: Theme.of(context).colorScheme.primary),
                                          // const SizedBox(width: 4),
                                          // FaIcon(FontAwesomeIcons.medium, size: 20, color: Theme.of(context).colorScheme.primary),
                                        ],
                                      ),
                                    ],
                                  ),
                                ).elevation(4, borderRadius: BorderRadius.circular(10)),
                              );
                            }),
                          ],
                        ),
                      ),
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
                              placeholder: 'ethconSeoul@handleit.com',
                              onTap: () {
                                setState(() {});
                              },
                              onChanged: (p0) {},
                            ),
                            const SizedBox(height: 16),
                            Text('Company *', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
                            const SizedBox(height: 8),
                            CustomBoxInputFields(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              controller: _companyNameEditingController,
                              placeholder: 'Handleit corp.',
                              onTap: () {
                                setState(() {});
                              },
                              onChanged: (p0) => setState(() {}),
                            ),
                            const SizedBox(height: 16),
                            Text('Title *', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
                            const SizedBox(height: 8),
                            CustomBoxInputFields(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              controller: _titleEditingController,
                              placeholder: 'Community manager',
                              onChanged: (p0) => setState(() {}),
                            ),
                            const SizedBox(height: 16),
                            Text('Self description', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
                            const SizedBox(height: 8),
                            CustomBoxInputFields(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              controller: _selfDescriptionEditingController,
                              placeholder: 'Hi there, I am a developer at Handle It.',
                              onChanged: (p0) => setState(() {}),
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
      }),
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
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // ListView.separated(
                      //   scrollDirection: Axis.horizontal,
                      //   physics: const ClampingScrollPhysics(),
                      //   padding: const EdgeInsets.fromLTRB(24, 24, 0, 24),
                      //   itemBuilder: (context, index) {
                      //     if (index == 2) {
                      //       return Container(
                      //         width: MediaQuery.of(context).size.width * 0.15,
                      //         padding: const EdgeInsets.all(24),
                      //         decoration: BoxDecoration(
                      //           color: Theme.of(context).colorScheme.secondary,
                      //           borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(20),
                      //             bottomLeft: Radius.circular(20),
                      //           ),
                      //         ),
                      //       );
                      //     } else {
                      //       return Container(
                      //         width: MediaQuery.of(context).size.width * 0.7,
                      //         padding: const EdgeInsets.all(24),
                      //         decoration: BoxDecoration(
                      //           color: Theme.of(context).colorScheme.secondary,
                      //           borderRadius: BorderRadius.circular(20),
                      //         ),
                      //       );
                      //     }
                      //   },
                      //   itemCount: 3,
                      //   separatorBuilder: (BuildContext context, int index) {
                      //     return const SizedBox(width: 24);
                      //   },
                      // ),
                      Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: CustomThemeButton(
                                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                borderRadius: 20,
                                onTap: showCardInputBottomSheet,
                                child: Container(
                                  width: (MediaQuery.of(context).size.width - 48) * 0.8,
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
                      ),
                    ],
                  ),
                ),
                Opacity(
                  opacity: 0.3,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _CardActionButton(
                          iconWidget: const Icon(Icons.download),
                          label: 'Download',
                          onTap: () {},
                        ),
                        _CardActionButton(
                          iconWidget: const Icon(Icons.qr_code),
                          label: 'QR Code',
                          onTap: () {
                            context.push('/${HandleItRoutes.qrScan.name}');
                          },
                        ),
                        _CardActionButton(
                          iconWidget: const Icon(Icons.ios_share),
                          label: 'Share',
                          onTap: () {},
                        ),
                        _CardActionButton(
                          iconWidget: const FaIcon(FontAwesomeIcons.telegram),
                          label: 'Telegram',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Cards (122)', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ),
                ],
              ),
            ).gestures(
              onTap: () => {
                // fold/unfold cards
              },
            ),
            SizedBox(
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
                          'Events(32)',
                          style: index == 0
                              ? Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 12)
                              : Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: 5,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 12);
                },
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
                mainAxisExtent: (MediaQuery.of(context).size.width - 64) * 9 / 14,
              ),
              itemBuilder: (context, index) {
                return CustomThemeButton(
                  onTap: () {
                    context.push('/${HandleItRoutes.cardProfileDetail.name}');
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: 'https://picsum.photos/id/237/200',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              itemCount: 5,
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
  final VoidCallback onTap;

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
