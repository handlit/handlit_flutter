import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handlit_flutter/ui/widgets/widgets.dart';

final scanQrProvider = Provider<QRScanRepository>((ref) {
  return QRScanRepository();
});

abstract class BaseQRScanRepository {
  Future<String> scanQRCode();
  Future<void> uploadFriendProfile(String userAddress, String friendAddress);
  void showInputBottomSheet(BuildContext context);
}

class QRScanRepository implements BaseQRScanRepository {
  @override
  Future<String> scanQRCode() async {
    return 'dummyAddress';
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
