import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handlit_flutter/ui/widgets/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScanScreen extends ConsumerStatefulWidget {
  const QrScanScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends ConsumerState<QrScanScreen> {
  final String userNickname = '@john_doe_the_devloper';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HandleitCustomHeader(
              title: 'QR scan',
              leading: BackButton(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userNickname, style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 24),
                      QrImageView(
                        data: '${userNickname}',
                        version: QrVersions.auto,
                        size: MediaQuery.of(context).size.width,
                        gapless: false,
                        padding: EdgeInsets.zero,
                        dataModuleStyle: QrDataModuleStyle(
                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                          dataModuleShape: QrDataModuleShape.circle,
                        ),
                      ),
                      const Row(
                        children: [
                          Expanded(
                              child: Divider(
                            height: 1,
                          )),
                          SizedBox(width: 8),
                          Text('or', style: TextStyle(fontSize: 18)),
                          SizedBox(width: 8),
                          Expanded(
                            child: Divider(
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      CustomThemeButton(
                        backgroundColor: Color.alphaBlend(Theme.of(context).colorScheme.background.withOpacity(0.9), Theme.of(context).colorScheme.primary),
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt_outlined, size: 16),
                              SizedBox(width: 8),
                              Text('Scan'),
                            ],
                          ),
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
    );
  }
}
