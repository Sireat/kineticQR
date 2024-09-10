// remote_data_source.dart
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../domain/entities/qr_code_entity.dart';
import 'package:flutter/material.dart';

class RemoteDataSource {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;

  // Function to scan the QR code and return the QRCodeEntity
  Future<QRCodeEntity> scanQRCode(BuildContext context) async {
    // Scaffold to display the QR scanner interface
    final scanResult = await Navigator.push<Barcode?>(
      context,
      MaterialPageRoute(
        builder: (context) => QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: Colors.green,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: 300,
          ),
        ),
      ),
    );

    // Check the scan result and return the QRCodeEntity
    if (scanResult != null) {
      return QRCodeEntity(data: scanResult.code ?? '', errorMessage: null);
    } else {
      return QRCodeEntity(data: '', errorMessage: 'Failed to scan QR Code.');
    }
  }

  // QR code view created handler
  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
  }

  // Dispose the controller when done
  void dispose() {
    _controller?.dispose();
  }
}
