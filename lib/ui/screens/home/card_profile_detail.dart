import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handlit_flutter/models/exchanged_card.dart';
import 'package:handlit_flutter/ui/screens/screens.dart';
import 'package:handlit_flutter/ui/widgets/widgets.dart';

class CardProfileDetailScreen extends ConsumerStatefulWidget {
  const CardProfileDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardProfileDetailScreenState();
}

class _CardProfileDetailScreenState extends ConsumerState<CardProfileDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              HandleitCustomHeader(
                title: ref.watch(selectedCardItemObjProvider)?.name ?? '',
                leading: const BackButton(),
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
                          child: CachedNetworkImage(
                            imageUrl: ref.watch(selectedCardItemObjProvider)?.imageUrl ?? '',
                            width: MediaQuery.of(context).size.width - 48,
                            height: (MediaQuery.of(context).size.width - 48),
                            fit: BoxFit.cover,
                          ),
                        ),
                        // const SizedBox(height: 24),
                        // const Text('Mutual Friends', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        // const SizedBox(height: 24),
                        // SizedBox(
                        //   height: _cardSize * 0.4,
                        //   child: ListView.separated(
                        //     physics: const ClampingScrollPhysics(),
                        //     scrollDirection: Axis.horizontal,
                        //     shrinkWrap: true,
                        //     itemBuilder: (context, index) {
                        //       return Container(
                        //         width: _cardSize * 0.4,
                        //         height: _cardSize * 0.4,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(4),
                        //           color: Theme.of(context).colorScheme.secondary,
                        //         ),
                        //         child: ClipRRect(
                        //           borderRadius: BorderRadius.circular(4),
                        //           child: CachedNetworkImage(
                        //             imageUrl: 'https://picsum.photos/id/237/200',
                        //             fit: BoxFit.cover,
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //     separatorBuilder: (context, index) {
                        //       return const SizedBox(width: 16);
                        //     },
                        //     itemCount: 3,
                        //   ),
                        // ),
                        const SizedBox(height: 24),
                        const Text('Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        CustomChipBox(child: Text(ref.watch(selectedCardItemObjProvider)?.name ?? '', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400))),
                        const SizedBox(height: 24),
                        const Text('E-mail', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        CustomChipBox(child: Text(ref.watch(selectedCardItemObjProvider)?.email ?? '')),
                        const SizedBox(height: 24),
                        const Text('Company', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        CustomChipBox(child: Text(ref.watch(selectedCardItemObjProvider)?.company ?? '')),
                        const SizedBox(height: 24),
                        const Text('Title', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        CustomChipBox(child: Text(ref.watch(selectedCardItemObjProvider)?.title ?? '')),
                        const SizedBox(height: 24),
                        const Text('Self description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        CustomChipBox(
                          child: Text(
                            ref.watch(selectedCardItemObjProvider)?.description ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
