import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handlit_flutter/controllers/user_card.dart';
import 'package:handlit_flutter/ui/widgets/widgets.dart';

class QrScanScreen extends ConsumerStatefulWidget {
  const QrScanScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends ConsumerState<QrScanScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HandleitCustomHeader(
              title: 'QR Code',
              leading: BackButton(),
            ),
            Expanded(
              child: ref.watch(userCardListAsyncController).maybeWhen(
                orElse: () {
                  return const Center(child: CircularProgressIndicator());
                },
                data: (data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(36, 24, 36, 0),
                        child: Text(data?.list?[0].name ?? '', style: Theme.of(context).textTheme.headlineMedium),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: data?.list?[0].qrCodeUrl ?? '',
                          fit: BoxFit.fitWidth,
                        ),
                      )
                    ],
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
