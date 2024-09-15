// local_datasource.dart

import 'dart:ui';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../../core/error/exceptions.dart';

/// Handles local operations related to QR code generation and storage.
class LocalDataSource {
  
  /// Generates a QR code from the given [data] and saves it to the local file system.
  ///
  /// Returns the file path of the saved QR code image.
  /// Throws a [CacheException] if any error occurs during the generation or saving process.
  Future<String> generateQRCode(String data) async {
    try {
      // Creates a QR code painter with the provided data and configuration.
      final qrCode = QrPainter(
        data: data,
        version: QrVersions.auto, // Automatically selects the best version based on the data length.
        gapless: false, // Controls whether the QR code should have gaps between modules.
        // ignore: deprecated_member_use
        color: const Color(0xFF000000), // Sets the color of the QR code.
        // ignore: deprecated_member_use
        emptyColor: const Color(0xFFFFFFFF), // Sets the background color of the QR code.
      );

      // Gets the directory path where the QR code image will be saved.
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/qr_code.png';
      final file = File(path);

      // Converts the QR code painter to image data with a specified resolution.
      final picData = await qrCode.toImageData(300);
      // Writes the image data to the file in the specified path.
      await file.writeAsBytes(picData!.buffer.asUint8List());

      // Saves the generated QR code image to the gallery.
      await ImageGallerySaver.saveFile(file.path);
      return file.path; // Returns the file path of the saved QR code image.
    } catch (e) {
      // Throws a cache exception if any error occurs during the operation.
      throw CacheException();
    }
  }
}
