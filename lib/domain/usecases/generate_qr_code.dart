import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../repositories/qr_repository.dart';

/// Use case class responsible for generating QR codes.
/// This class interacts with the QRRepository to perform the QR code generation.
class GenerateQRCode {
  final QRRepository repository; // Repository instance to handle QR code operations.

  // Constructor to initialize the repository dependency.
  GenerateQRCode(this.repository);

  /// Executes the use case to generate a QR code with the given data.
  /// 
  /// [data] is the information to be encoded into the QR code.
  /// Returns either a Failure or a String representing the generated QR code data.
  Future<Either<Failure, String>> call(String data) async {
    return await repository.generateQRCode(data);
  }
}
