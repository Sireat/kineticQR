import 'dart:ui';

import 'package:qr_flutter/qr_flutter.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../../core/error/exceptions.dart';

class LocalDataSource {
  Future<String> generateQRCode(String data) async {
    try {
      final qrCode = QrPainter(
        data: data,
        version: QrVersions.auto,
        gapless: false,
        // ignore: deprecated_member_use
        color: const Color(0xFF000000),
        // ignore: deprecated_member_use
        emptyColor: const Color(0xFFFFFFFF),
      );

      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/qr_code.png';
      final file = File(path);

      final picData = await qrCode.toImageData(300);
      await file.writeAsBytes(picData!.buffer.asUint8List());

      await ImageGallerySaver.saveFile(file.path);
      return file.path;
    } catch (e) {
      throw CacheException();
    }
  }
}
