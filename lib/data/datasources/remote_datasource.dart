// remote_data_source.dart

import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../domain/entities/qr_code_entity.dart';
import 'package:flutter/material.dart';

/// Handles remote operations related to scanning QR codes using the device's camera.
class RemoteDataSource {
  // Key used to identify the QR scanner widget.
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  
  // Controller to manage the QR scanning view.
  QRViewController? _controller;

  /// Initiates the QR code scanning process and returns a [QRCodeEntity] with the scan result.
  ///
  /// Navigates to a new screen displaying the QR scanner interface, waits for the scan result,
  /// and then returns the scanned data wrapped in a [QRCodeEntity].
  Future<QRCodeEntity> scanQRCode(BuildContext context) async {
    // Launches the QR scanner interface and waits for a scan result.
    final scanResult = await Navigator.push<Barcode?>(
      context,
      MaterialPageRoute(
        builder: (context) => QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated, // Sets up the QR view when created.
          overlay: QrScannerOverlayShape( // Customizes the scanner overlay appearance.
            borderColor: Colors.green,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: 300, // Size of the cut-out window in the scanner.
          ),
        ),
      ),
    );

    // Checks if a valid scan result was obtained and returns the corresponding QRCodeEntity.
    if (scanResult != null) {
      return QRCodeEntity(data: scanResult.code ?? '', errorMessage: null);
    } else {
      // Returns an error message if the scan was unsuccessful or canceled.
      return QRCodeEntity(data: '', errorMessage: 'Failed to scan QR Code.');
    }
  }

  /// Called when the QR view is created to initialize the controller.
  ///
  /// Sets up the controller to handle QR scanning functionalities.
  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
  }

  /// Disposes of the QR view controller to free resources when scanning is complete.
  void dispose() {
    _controller?.dispose();
  }
}
