import 'dart:developer';
import 'package:amritha_ayurveda/core/constants/app_constants.dart';
import 'package:amritha_ayurveda/core/utils/shared_preference_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioInterceptor {
  late Dio _dio;
  final GlobalKey<NavigatorState> navigatorKey;

  DioInterceptor({
    required String baseUrl,
    required this.navigatorKey,
  }) {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
    _setupInterceptors();
  }

  Dio get dio => _dio;

  void _setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await SharedPreferencesUtils.getStringValue(
          key: AppConstants.userAuthTokenKey,
        );
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        print('\n🚀 REQUEST: ${options.baseUrl}${options.path}');
        print('📋 Headers: ${options.headers}');

        return handler.next(options);
      },
      onResponse: (response, handler) async {
        print(
            '✅ RESPONSE: ${response.requestOptions.baseUrl}${response.requestOptions.path}');
        print('📥 Data: ${response.data}');
        print('');

        return handler.next(response);
      },
      onError: (error, handler) async {
        final request = error.requestOptions;
        final response = error.response;

        log("❌ API Error Occurred");
        log("➡️ URL: ${request.uri}");
        log("➡️ METHOD: ${request.method}");
        log("➡️ HEADERS: ${request.headers}");
        log("➡️ REQUEST BODY: ${request.data}");

        if (response != null) {
          log("⬅️ STATUS CODE: ${response.statusCode}");
          log("⬅️ RESPONSE DATA: ${response.data}");
        } else {
          log("⚠️ No response received.");
        }

        if (error.response?.statusCode == 401) {
          if (navigatorKey.currentState != null) {
          } else {}
        }

        return handler.next(error);
      },
    ));
  }
}
