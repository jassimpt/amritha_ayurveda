import 'package:amritha_ayurveda/core/utils/custom_snackbar.dart';
import 'package:amritha_ayurveda/core/utils/enums.dart';
import 'package:amritha_ayurveda/features/modules/register/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FieldValidationUtils {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static bool validateFields({
    required BuildContext context,
    required TextEditingController nameController,
    required TextEditingController whatsappController,
    required TextEditingController addressController,
    required TextEditingController totalAmountController,
  }) {
    final registerController = context.read<RegisterController>();

    if (nameController.text.trim().isEmpty) {
      showCustomSnackBar(
        context: context,
        type: SnackBarType.error,
        content: 'Please enter patient name',
      );
      return false;
    }

    if (whatsappController.text.trim().isEmpty) {
      showCustomSnackBar(
        context: context,
        type: SnackBarType.error,
        content: 'Please enter WhatsApp number',
      );
      return false;
    }

    if (addressController.text.trim().isEmpty) {
      showCustomSnackBar(
        context: context,
        type: SnackBarType.error,
        content: 'Please enter address',
      );
      return false;
    }

    if (registerController.selectedBranch == null) {
      showCustomSnackBar(
        context: context,
        type: SnackBarType.error,
        content: 'Please select a branch',
      );
      return false;
    }

    if (registerController.patientTreatmentList.isEmpty) {
      showCustomSnackBar(
        context: context,
        type: SnackBarType.error,
        content: 'Please add at least one treatment',
      );
      return false;
    }

    if (totalAmountController.text.trim().isEmpty) {
      showCustomSnackBar(
        context: context,
        type: SnackBarType.error,
        content: 'Please enter total amount',
      );
      return false;
    }

    if (registerController.selectedPaymentOption == null) {
      showCustomSnackBar(
        context: context,
        type: SnackBarType.error,
        content: 'Please select payment option',
      );
      return false;
    }

    if (registerController.selectedDate == null) {
      showCustomSnackBar(
        context: context,
        type: SnackBarType.error,
        content: 'Please select treatment date',
      );
      return false;
    }

    if (registerController.selectedHour == null ||
        registerController.selectedMinute == null) {
      showCustomSnackBar(
        context: context,
        type: SnackBarType.error,
        content: 'Please select treatment time',
      );
      return false;
    }

    return true;
  }
}
