import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../repositories/qr_repository.dart';

class GenerateQRCode {
  final QRRepository repository;

  GenerateQRCode(this.repository);

  Future<Either<Failure, String>> call(String data) async {
    return await repository.generateQRCode(data);
  }
}
