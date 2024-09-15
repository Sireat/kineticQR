import 'package:flutter/material.dart';

/// A provider class for managing and updating the scanned QR code data.
class QRProvider with ChangeNotifier {
  // Holds the data from the scanned QR code.
  String scannedData = '';

  /// Updates the scanned data and notifies listeners about the change.
  ///
  /// [data] is the new scanned QR code string that will replace the current value.
  /// After updating the data, it calls [notifyListeners] to update any UI elements
  /// that are listening for changes in the provider.
  void updateScannedData(String data) {
    scannedData = data;
    notifyListeners(); // Notifies all the widgets that are listening to this provider.
  }
}
