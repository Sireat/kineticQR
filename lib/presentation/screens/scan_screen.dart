import 'package:flutter/material.dart';
import '../widgets/qr_scanner_widget.dart';
import 'qr_result_screen.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Code')),
      body: QRScannerWidget(
        onScan: (data) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => QRResultScreen(data: data)),
          );
        },
      ),
    );
  }
}
