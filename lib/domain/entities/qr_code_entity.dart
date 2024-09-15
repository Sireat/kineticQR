/// Represents a QR code entity in the application.
/// This class encapsulates the data associated with a QR code
/// and any potential error message that might occur during QR code processing.
class QRCodeEntity {
  final String data; // The data encoded within the QR code (e.g., URL, text).
  final String? errorMessage; // Optional error message if something goes wrong.

  // Constructor to initialize the QR code entity with required data and optional error message.
  QRCodeEntity({required this.data, this.errorMessage});
}
