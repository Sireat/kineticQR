import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';

class QRGeneratorWidget extends StatefulWidget {
  const QRGeneratorWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QRGeneratorWidgetState createState() => _QRGeneratorWidgetState();
}

class _QRGeneratorWidgetState extends State<QRGeneratorWidget> {
  final TextEditingController _controller = TextEditingController();
  String qrData = '';
  final GlobalKey globalKey = GlobalKey();

  // Method to generate QR code by updating the state with entered data
  void _generateQRCode() {
    setState(() {
      qrData = _controller.text.trim();
    });
  }

  // Method to save the generated QR code as an image in the gallery
  Future<void> _saveQRCode() async {
    try {
      // Capture QR code image from the widget tree
      RenderRepaintBoundary boundary =
          globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save the captured image to the gallery
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(pngBytes),
        quality: 100,
        name: 'qr_code_${DateTime.now().millisecondsSinceEpoch}',
      );

      if (result['isSuccess']) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('QR Code saved to gallery!')),
        );
      } else {
        throw Exception('Failed to save QR Code');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save QR Code')),
      );
    }
  }

  // Method to share the generated QR code image via various apps
  Future<void> _shareQRCode() async {
    try {
      // Capture QR code image from the widget tree
      RenderRepaintBoundary boundary =
          globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save the image temporarily to share
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/qr_code.png').create();
      await file.writeAsBytes(pngBytes);

      // Share the saved file using share_plus package
      await Share.shareXFiles([XFile(file.path)], text: 'Check out this QR code!');
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to share QR Code')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Enter data to generate QR Code',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _generateQRCode,
            child: const Text('Generate QR Code'),
          ),
          if (qrData.isNotEmpty)
            Column(
              children: [
                RepaintBoundary(
                  key: globalKey,
                  child: QrImageView(
                    data: qrData,
                    size: 200.0,
                    backgroundColor: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.save),
                      onPressed: _saveQRCode,
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: _shareQRCode,
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
