import 'package:dio/dio.dart';

abstract class Failures {
  final String failuremessage;
  Failures(this.failuremessage);
}

class Serverfailure extends Failures {
  Serverfailure(super.failuremessage);
  factory Serverfailure.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Serverfailure("Connection timeout with API server");
      case DioExceptionType.sendTimeout:
        return Serverfailure("Send timeout with API server");
      case DioExceptionType.receiveTimeout:
        return Serverfailure("Receive timeout with API server");
      case DioExceptionType.badCertificate:
        return Serverfailure("Bad certificate with API server");
      case DioExceptionType.badResponse:
        return Serverfailure("Bad response with API server");
      case DioExceptionType.cancel:
        return Serverfailure("Request to API server was cancelled");
      case DioExceptionType.connectionError:
        return Serverfailure("Connection error with API server");
      case DioExceptionType.unknown:
        return Serverfailure("Unexpected error, please try again!");
      default:
        return Serverfailure("Unexpected error, please try again!");
    }
  }
}

