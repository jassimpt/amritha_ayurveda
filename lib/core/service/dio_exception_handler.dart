import 'dart:developer';

import 'package:dio/dio.dart';

class DioExceptionHandler implements Exception {
  late String errorMessage;

  DioExceptionHandler.fromDioError(DioException dioError) {
    log(dioError.response?.data.toString() ?? "");
    switch (dioError.type) {
      case DioExceptionType.cancel:
        errorMessage =
            dioError.response?.data['message'] ?? 'Request Cancelled';
        print("Error: $errorMessage");
        break;

      case DioExceptionType.connectionTimeout:
        errorMessage =
            dioError.message ?? 'Connection Timeout. No Internet Connection';
        print("Error: $errorMessage");
        break;

      case DioExceptionType.receiveTimeout:
        errorMessage = dioError.response?.data['message'] ?? 'Receive Timeout';
        print("Error: $errorMessage");
        break;

      case DioExceptionType.sendTimeout:
        errorMessage = dioError.response?.data['message'] ?? 'Send Timeout';
        print("Error: $errorMessage");
        break;

      case DioExceptionType.badResponse:
        try {
          final responseData = dioError.response?.data;
          if (responseData != null &&
              responseData['status'] != null &&
              responseData['status']['message'] != null) {
            errorMessage = responseData['status']['message'];
          } else if (responseData != null && responseData['message'] != null) {
            errorMessage = responseData['message'];
          } else {
            errorMessage = 'Bad Response from Server';
          }
        } catch (e) {
          errorMessage = 'Bad Response from Server';
        }
        print("Error: $errorMessage");
        break;

      case DioExceptionType.badCertificate:
        errorMessage = dioError.response?.data['message'] ?? 'Bad Certificate';
        print("Error: $errorMessage");
        break;

      case DioExceptionType.connectionError:
        errorMessage =
             'Connection Error. Please check your network';
        print("Error: $errorMessage");
        break;

      default:
        errorMessage = dioError.message ?? 'Unexpected error occurred';
        print("Error: $errorMessage");
        break;
    }
  }

  @override
  String toString() => errorMessage;
}
