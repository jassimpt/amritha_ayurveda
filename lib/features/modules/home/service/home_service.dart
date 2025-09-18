import 'dart:developer';

import 'package:amritha_ayurveda/core/constants/api_constants.dart';
import 'package:amritha_ayurveda/core/service/dio_exception_handler.dart';
import 'package:amritha_ayurveda/core/service/dio_interceptor.dart';
import 'package:amritha_ayurveda/features/modules/home/model/patient_list_model.dart';
import 'package:amritha_ayurveda/main.dart';
import 'package:dio/dio.dart';

class HomeService {
  late DioInterceptor _dioInterceptor;
  late Dio _dio;

  HomeService() {
    _dioInterceptor = DioInterceptor(
      baseUrl: ApiConstants.baseUrl,
      navigatorKey: navigatorKey,
    );
    _dio = _dioInterceptor.dio;
  }

  getPatientsData({
    Map<String, dynamic>? additionalParams,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {};
      if (additionalParams != null) {
        queryParams.addAll(additionalParams);
      }
      final response = await _dio.get(
        ApiConstants.patientList,
        queryParameters: queryParams,
      );
      log("Patient:${response.data.toString()}");
      if (response.statusCode == 200) {
        final data = response.data;
        return PatientListModel.fromJson(data);
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
      throw Exception('$e');
    }
  }
}
