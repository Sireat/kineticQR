// scan_qr_code.dart
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../core/error/failures.dart';
import '../entities/qr_code_entity.dart';
import '../repositories/qr_repository.dart';

class ScanQRCode {
  final QRRepository repository;

  ScanQRCode(this.repository);

  // Update the call method to accept BuildContext
  Future<Either<Failure, QRCodeEntity>> call(BuildContext context) async {
    // Pass the context to the repository method
    return await repository.scanQRCode(context);
  }
}
