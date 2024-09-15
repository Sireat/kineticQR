// scan_qr_code.dart

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../core/error/failures.dart';
import '../entities/qr_code_entity.dart';
import '../repositories/qr_repository.dart';

/// Use case class responsible for scanning QR codes.
/// This class interacts with the QRRepository to handle QR code scanning.
class ScanQRCode {
  final QRRepository repository; // Repository instance to manage QR scanning operations.

  // Constructor to initialize the repository dependency.
  ScanQRCode(this.repository);

  /// Executes the use case to scan a QR code.
  ///
  /// [context] is passed to provide access to the current widget tree during scanning.
  /// Returns either a Failure or a QRCodeEntity containing the scanned data.
  Future<Either<Failure, QRCodeEntity>> call(BuildContext context) async {
    // Uses the repository to perform the scan operation, providing necessary context.
    return await repository.scanQRCode(context);
  }
}
