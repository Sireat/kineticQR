import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../core/error/failures.dart';
import '../entities/qr_code_entity.dart';

/// Abstract class defining the contract for QR code-related operations.
/// This repository handles scanning and generating QR codes.
abstract class QRRepository {
  
  /// Scans a QR code using the device's camera.
  /// Returns either a Failure or a QRCodeEntity containing the scanned data.
  /// 
  /// [context] is passed to handle platform-specific operations, such as accessing the camera.
  Future<Either<Failure, QRCodeEntity>> scanQRCode(BuildContext context);

  /// Generates a QR code based on the provided data (e.g., text, URL).
  /// Returns either a Failure or a string representing the generated QR code data.
  /// 
  /// [data] represents the content to encode into the QR code.
  Future<Either<Failure, String>> generateQRCode(String data);
}
