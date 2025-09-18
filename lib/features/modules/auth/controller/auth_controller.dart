import 'package:amritha_ayurveda/core/constants/app_constants.dart';
import 'package:amritha_ayurveda/core/service/dio_exception_handler.dart';
import 'package:amritha_ayurveda/core/utils/shared_preference_utils.dart';
import 'package:amritha_ayurveda/features/modules/auth/model/auth_result.dart';
import 'package:amritha_ayurveda/features/modules/auth/service/auth_service.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final AuthService _service = AuthService();
  bool obscurePassword = true;
  bool isLoading = false;

  setObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<AuthResult> login(
    String username,
    String password,
  ) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _service.login(username, password);
      final accessToken = response["token"];
      await SharedPreferencesUtils.setStringValue(
        key: AppConstants.userAuthTokenKey,
        value: accessToken,
      );
      await SharedPreferencesUtils.setBoolValue(
        key: AppConstants.isUserLogged,
        value: true,
      );

      return AuthResult(
        success: true,
        message: response["message"],
        accessToken: accessToken,
      );
    } catch (e) {
      String errorMessage = 'Login failed';

      if (e is DioExceptionHandler) {
        errorMessage = e.toString();
      } else if (e is Exception) {
        errorMessage = e.toString().replaceAll('Exception: ', '');
      }
      return AuthResult(
        success: false,
        message: errorMessage,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
