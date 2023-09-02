import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handlit_flutter/ui/screens/screens.dart';
import 'package:handlit_flutter/ui/widgets/widgets.dart';
import 'package:handlit_flutter/utils/routes.dart';

final scanQrProvider = Provider<QRScanRepository>((ref) {
  return QRScanRepository(ref);
});

abstract class BaseQRScanRepository {
  Future<void> scanQRCode(BuildContext context);
  Future<void> uploadFriendProfile(String userAddress, String friendAddress);
  void showInputBottomSheet(BuildContext context);
}

class QRScanRepository implements BaseQRScanRepository {
  QRScanRepository(this.ref);

  final Ref ref;

  @override
  Future<void> scanQRCode(BuildContext context) async {
    context.push('/${HandleItRoutes.barcodeScanner.name}').then((value) {
      if (ref.read(qrScannedProvider) != null) {
        ref.read(scanQrProvider).showInputBottomSheet(context);
      }
    });
  }

  @override
  Future<void> uploadFriendProfile(String userAddress, String friendAddress) async {
    print('uploadFriendProfile');
  }

  @override
  void showInputBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      constraints: const BoxConstraints(minWidth: double.infinity),
      enableDrag: true,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const QRScanInputBottomSheet(),
    );
  }
}
