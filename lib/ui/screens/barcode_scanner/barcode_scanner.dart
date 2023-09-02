import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handlit_flutter/ui/screens/screens.dart';

class BarcodeScannerScreen extends ConsumerStatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends ConsumerState<BarcodeScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AiBarcodeScanner(
        controller: MobileScannerController(),
        onScan: (String value) {
          ref.read(qrScannedProvider.notifier).state = value;
        },
        onDetect: (BarcodeCapture barcodeCapture) {
          debugPrint(barcodeCapture.toString());
        },
      ),
    );
  }
}
