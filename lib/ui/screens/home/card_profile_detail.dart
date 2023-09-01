import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:handlit_flutter/ui/widgets/widgets.dart';
import 'package:styled_widget/styled_widget.dart';

class CardProfileDetailScreen extends ConsumerStatefulWidget {
  const CardProfileDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardProfileDetailScreenState();
}

class _CardProfileDetailScreenState extends ConsumerState<CardProfileDetailScreen> {
  late final double _cardSize = 350;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const HandleitCustomHeader(
                title: 'Julia Kim',
                leading: BackButton(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                              width: _cardSize * 0.4,
                                              height: _cardSize * 0.4,
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
                                                      onTap: () {},
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(4),
                                                        ),
                                                        child: AutoSizeText(
                                                          'Julia Kim',
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
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
                        const SizedBox(height: 24),
                        const Text('Mutual Friends', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: _cardSize * 0.4,
                          child: ListView.separated(
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                width: _cardSize * 0.4,
                                height: _cardSize * 0.4,
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
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 16);
                            },
                            itemCount: 3,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text('Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        const CustomChipBox(child: Text('Julia Kim', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400))),
                        const SizedBox(height: 24),
                        const Text('E-mail', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        const CustomChipBox(child: Text('julia@gmail.com')),
                        const SizedBox(height: 24),
                        const Text('Company', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        const CustomChipBox(child: Text('Google')),
                        const SizedBox(height: 24),
                        const Text('Title', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        const CustomChipBox(child: Text('Software Engineer')),
                        const SizedBox(height: 24),
                        const Text('Self description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        const CustomChipBox(child: Text('I am a s', maxLines: 2, overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
