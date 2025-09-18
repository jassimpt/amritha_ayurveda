import 'dart:developer';

import 'package:amritha_ayurveda/core/constants/api_constants.dart';
import 'package:amritha_ayurveda/core/service/dio_exception_handler.dart';
import 'package:amritha_ayurveda/core/service/dio_interceptor.dart';
import 'package:amritha_ayurveda/features/modules/register/models/appointment_model.dart';
import 'package:amritha_ayurveda/features/modules/register/models/branch_list_model.dart';
import 'package:amritha_ayurveda/features/modules/register/models/treatment_list_model.dart';
import 'package:amritha_ayurveda/main.dart';
import 'package:dio/dio.dart';

class RegisterService {
  late DioInterceptor _dioInterceptor;
  late Dio _dio;

  RegisterService() {
    _dioInterceptor = DioInterceptor(
      baseUrl: ApiConstants.baseUrl,
      navigatorKey: navigatorKey,
    );
    _dio = _dioInterceptor.dio;
  }

   createAppointment(AppointmentModel appointment) async {
    try {
      log("THIS IS APPOINTMENT DATA ${appointment.toJson()}");
      final formData = FormData.fromMap(
        appointment.toJson(),
      );
      final response = await _dio.post(
        ApiConstants.patientUpdate,
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
      throw Exception('Failed to Create: $e');
    }
  }

  // SERVICE FUNCTION TO FETCH TREATMENTS DATA

  getTreatmentData({
    Map<String, dynamic>? additionalParams,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {};
      if (additionalParams != null) {
        queryParams.addAll(additionalParams);
      }
      final response = await _dio.get(
        ApiConstants.treatmentList,
        queryParameters: queryParams,
      );
      log("TREATMENTS:${response.data.toString()}");
      if (response.statusCode == 200) {
        final data = response.data;
        return TreatmentListModel.fromJson(data);
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

  // SERVICE FUNCTION TO FETCH BRANCH DATA

  getBranchList({
    Map<String, dynamic>? additionalParams,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {};
      if (additionalParams != null) {
        queryParams.addAll(additionalParams);
      }
      final response = await _dio.get(
        ApiConstants.branchList,
        queryParameters: queryParams,
      );
      log("BRANCHES:${response.data.toString()}");
      if (response.statusCode == 200) {
        final data = response.data;
        return BranchListModel.fromJson(data);
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
