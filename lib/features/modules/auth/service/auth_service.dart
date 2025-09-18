import 'dart:developer';
import 'package:amritha_ayurveda/core/constants/api_constants.dart';
import 'package:amritha_ayurveda/core/service/dio_exception_handler.dart';
import 'package:amritha_ayurveda/core/service/dio_interceptor.dart';
import 'package:amritha_ayurveda/main.dart';
import 'package:dio/dio.dart';

class AuthService {
  late DioInterceptor _dioInterceptor;
  late Dio _dio;

  AuthService() {
    _dioInterceptor = DioInterceptor(
      baseUrl: ApiConstants.baseUrl,
      navigatorKey: navigatorKey,
    );
    _dio = _dioInterceptor.dio;
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final formData = FormData.fromMap({
        'username': username,
        'password': password,
      });
      final response = await _dio.post(
        ApiConstants.login,
        data: formData,
      );
      log(response.data.toString());
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw DioExceptionHandler.fromDioError(
          DioException(
            response: response,
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw DioExceptionHandler.fromDioError(e);
      }
      throw Exception('Failed to login: $e');
    }
  }
}
