// qr_repository.dart
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../core/error/failures.dart';
import '../entities/qr_code_entity.dart';

abstract class QRRepository {
  // Add BuildContext parameter to match the implementation
  Future<Either<Failure, QRCodeEntity>> scanQRCode(BuildContext context);
  Future<Either<Failure, String>> generateQRCode(String data);
}
