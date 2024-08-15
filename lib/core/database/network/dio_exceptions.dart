import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessages;

  Failure(this.errorMessages);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessages);

  factory ServerFailure.fromDioException(DioException e) {
    final statusCode = e.response?.statusCode;
    final responseData = e.response?.data;
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Recieve timeout with ApiServer');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(statusCode!, responseData!);
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure('Connection timeout with ApiServer');
      case DioExceptionType.unknown:
        if (e.message!.contains('SoketEcxeption')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unexpected Error, Please try later!');
      default:
        return ServerFailure('Opps there was an error, Please try later!');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response["message"]);
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, Please try later!');
    } else if (statusCode == 500) {
      return ServerFailure(response["message"]);
    } else {
      return ServerFailure(response["message"]);
    }
  }
}
