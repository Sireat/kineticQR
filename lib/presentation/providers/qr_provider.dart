import 'package:flutter/material.dart';

class QRProvider with ChangeNotifier {
  String scannedData = '';

  void updateScannedData(String data) {
    scannedData = data;
    notifyListeners();
  }
}
