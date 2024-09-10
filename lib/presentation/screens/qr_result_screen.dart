import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class QRResultScreen extends StatelessWidget {
  final String data;

  const QRResultScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    bool isURL = Uri.tryParse(data)?.hasAbsolutePath ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Result')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18)),
            if (isURL)
              ElevatedButton(
                onPressed: () async {
                  if (await canLaunchUrl(Uri.parse(data))) {
                    await launchUrl(Uri.parse(data));
                  }
                },
                child: const Text('Open in Browser'),
              ),
          ],
        ),
      ),
    );
  }
}
