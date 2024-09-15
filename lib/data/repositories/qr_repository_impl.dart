import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/qr_code_entity.dart';
import '../datasources/local_datasource.dart';
import '../datasources/remote_datasource.dart';
import '../../domain/repositories/qr_repository.dart';

/// Implementation of the QRRepository interface.
/// This class acts as a bridge between the data sources (local and remote) 
/// and the domain layer, managing QR code scanning and generation operations.
class QRRepositoryImpl implements QRRepository {
  final LocalDataSource localDataSource; // Handles operations related to local storage.
  final RemoteDataSource remoteDataSource; // Manages remote API interactions.

  // Constructor initializes the required data sources.
  QRRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  /// Scans a QR code using the remote data source.
  ///
  /// [context] is required for accessing UI-related operations during scanning.
  /// Returns either a failure or the scanned QR code entity.
  @override
  Future<Either<Failure, QRCodeEntity>> scanQRCode(BuildContext context) async {
    try {
      final qrCode = await remoteDataSource.scanQRCode(context); // Performs the scan operation.
      return Right(qrCode); // Returns the scanned QR code data.
    } on ServerException {
      // Handles server-related exceptions by returning a failure message.
      return Left(ServerFailure('Failed to scan QR code.'));
    }
  }

  /// Generates a QR code from the provided data using the local data source.
  ///
  /// Takes the [data] to be encoded into a QR code.
  /// Returns either a failure or the generated QR code as a string.
  @override
  Future<Either<Failure, String>> generateQRCode(String data) async {
    try {
      final qrImage = await localDataSource.generateQRCode(data); // Generates the QR code locally.
      return Right(qrImage); // Returns the generated QR code image data.
    } on CacheException {
      // Handles cache-related exceptions by returning a failure message.
      return Left(CacheFailure('Failed to generate QR code.'));
    }
  }
}
