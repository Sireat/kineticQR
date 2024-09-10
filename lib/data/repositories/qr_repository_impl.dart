// qr_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/qr_code_entity.dart';
import '../datasources/local_datasource.dart';
import '../datasources/remote_datasource.dart';
import '../../domain/repositories/qr_repository.dart';

class QRRepositoryImpl implements QRRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  QRRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  // Updated method signature to match the QRRepository interface
  @override
  Future<Either<Failure, QRCodeEntity>> scanQRCode(BuildContext context) async {
    try {
      final qrCode = await remoteDataSource.scanQRCode(context);
      return Right(qrCode);
    } on ServerException {
      return Left(ServerFailure('Failed to scan QR code.'));
    }
  }

  @override
  Future<Either<Failure, String>> generateQRCode(String data) async {
    try {
      final qrImage = await localDataSource.generateQRCode(data);
      return Right(qrImage);
    } on CacheException {
      return Left(CacheFailure('Failed to generate QR code.'));
    }
  }
}
