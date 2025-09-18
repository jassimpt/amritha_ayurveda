import 'package:amritha_ayurveda/core/service/dio_exception_handler.dart';
import 'package:amritha_ayurveda/core/utils/date_format_utils.dart';
import 'package:amritha_ayurveda/core/utils/enums.dart';
import 'package:amritha_ayurveda/features/modules/register/models/appointment_model.dart';
import 'package:amritha_ayurveda/features/modules/register/models/branch_list_model.dart';
import 'package:amritha_ayurveda/features/modules/register/models/patient_treatment_create_model.dart';
import 'package:amritha_ayurveda/features/modules/register/models/treatment_list_model.dart';
import 'package:amritha_ayurveda/features/modules/register/service/pdf_generation_service.dart';
import 'package:amritha_ayurveda/features/modules/register/service/register_service.dart';
import 'package:flutter/material.dart';

class RegisterController extends ChangeNotifier {
  bool branchListLoader = false;
  bool treatmentListLoader = false;
  List<Branch> branches = [];
  List<Treatment> treatments = [];
  Branch? selectedBranch;
  Treatment? selectedTreatment;
  List<PatientTreatmentCreateModel> patientTreatmentList = [];
  final RegisterService _service = RegisterService();
  PaymentOption? selectedPaymentOption;
  bool appointmentLoader = false;

  DateTime? selectedDate;
  String? selectedHour;
  String? selectedMinute;

  List<String> hours = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
  ];

  List<String> allMinutes =
      List.generate(60, (index) => index.toString().padLeft(2, '0'));

  Future<bool> createAppointment({
    required String name,
    required String phone,
    required String address,
    required String totalAmount,
    required String discountAmount,
    required String advanceAmount,
    required String balanceAmount,
    String executive = '',
  }) async {
    appointmentLoader = true;
    notifyListeners();

    try {
      String formattedDateTime = _formatDateTime();

      List<int> maleList = [];
      List<int> femaleList = [];
      List<int> treatmentIds = [];

      for (PatientTreatmentCreateModel treatment in patientTreatmentList) {
        if (treatment.selectedTreatment?.id != null) {
          treatmentIds.add(treatment.selectedTreatment!.id!);

          if (treatment.male != null && treatment.male! > 0) {
            for (int i = 0; i < treatment.male!; i++) {
              maleList.add(treatment.selectedTreatment!.id!);
            }
          }

          if (treatment.female != null && treatment.female! > 0) {
            for (int i = 0; i < treatment.female!; i++) {
              femaleList.add(treatment.selectedTreatment!.id!);
            }
          }
        }
      }

      AppointmentModel data = AppointmentModel(
        name: name,
        executive: executive,
        payment: getSelectedPaymentOptionAsString() ?? '',
        phone: phone,
        address: address,
        totalAmount: int.tryParse(totalAmount) ?? 0,
        discountAmount: int.tryParse(discountAmount) ?? 0,
        advanceAmount: int.tryParse(advanceAmount) ?? 0,
        balanceAmount: int.tryParse(balanceAmount) ?? 0,
        dateAndTime: formattedDateTime,
        id: '',
        male: maleList,
        female: femaleList,
        branch: selectedBranch?.id ?? 0,
        treatments: treatmentIds,
      );

      final response = await _service.createAppointment(data);

      await PdfService.generateAndOpenAppointmentPdf(
        selectedbranch: selectedBranch,
        patientName: name,
        address: address,
        whatsappNumber: phone,
        bookedOn: DateFormatUtils.getCurrentDateFormatted(),
        treatmentDate: DateFormatUtils.getFormattedDate(selectedDate),
        treatmentTime: DateFormatUtils.getFormattedTime(
            selectedHour ?? "", selectedMinute ?? ""),
        treatments: patientTreatmentList,
        totalAmount: double.tryParse(totalAmount) ?? 0.0,
        discountAmount: double.tryParse(discountAmount) ?? 0.0,
        advanceAmount: double.tryParse(advanceAmount) ?? 0.0,
        balanceAmount: double.tryParse(balanceAmount) ?? 0.0,
      );
      return true;
    } catch (e) {
      print('Error creating appointment: $e');
      return false;
    } finally {
      appointmentLoader = false;
      notifyListeners();
    }
  }

  // Helper method to format date and time
  String _formatDateTime() {
    if (selectedDate == null ||
        selectedHour == null ||
        selectedMinute == null) {
      return '';
    }

    // Format date as dd/MM/yyyy
    String day = selectedDate!.day.toString().padLeft(2, '0');
    String month = selectedDate!.month.toString().padLeft(2, '0');
    String year = selectedDate!.year.toString();

    // Convert hour to 12-hour format and determine AM/PM
    int hourInt = int.parse(selectedHour!);
    String period = 'AM';
    if (hourInt > 12) {
      hourInt -= 12;
      period = 'PM';
    } else if (hourInt == 12) {
      period = 'PM';
    } else if (hourInt == 0) {
      hourInt = 12;
    }

    String formattedHour = hourInt.toString().padLeft(2, '0');

    return '$day/$month/$year-$formattedHour:$selectedMinute $period';
  }

  // METHOD TO SET SELECTED HOUR
  void setSelectedHour(String? hour) {
    selectedHour = hour;
    notifyListeners();
  }

// METHOD TO SET SELECTED MINUTE
  void setSelectedMinute(String? minute) {
    selectedMinute = minute;
    notifyListeners();
  }

// METHOD TO CLEAR SELECTED TIME
  void clearSelectedTime() {
    selectedHour = null;
    selectedMinute = null;
    notifyListeners();
  }

// METHOD TO SET SELECTED DATE
  void setSelectedDate(DateTime? date) {
    selectedDate = date;
    notifyListeners();
  }

// METHOD TO CLEAR SELECTED DATE
  void clearSelectedDate() {
    selectedDate = null;
    notifyListeners();
  }

  clearPatientTreatmentList() {
    notifyListeners();
  }

  clearAll() {
    selectedPaymentOption = null;
    selectedBranch = null;
    selectedTreatment = null;
    patientTreatmentList.clear();
    selectedHour = null;
    selectedMinute = null;
    selectedDate = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  clearSelectedTreatment() {
    selectedTreatment = null;
    notifyListeners();
  }

  // CONTROLLER METHOD TO MANAGE STATE OF BRANCH LIST
  getBranchData({
    Map<String, dynamic>? additionalParams,
  }) async {
    try {
      branchListLoader = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
      BranchListModel branchData = await _service.getBranchList(
        additionalParams: additionalParams,
      );
      branches = branchData.branches ?? [];
    } catch (e) {
      branches = [];
    } finally {
      branchListLoader = false;
      notifyListeners();
    }
  }

  // CONTROLLER METHOD TO MANAGE STATE OF TREATMENT LIST
  getTreatmentList({
    Map<String, dynamic>? additionalParams,
  }) async {
    try {
      treatmentListLoader = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
      TreatmentListModel treatMentData = await _service.getTreatmentData(
        additionalParams: additionalParams,
      );
      treatments = treatMentData.treatments ?? [];
    } catch (e) {
      treatments = [];
    } finally {
      treatmentListLoader = false;
      notifyListeners();
    }
  }

  // METHOD TO UPDATE TREATMENT TO THE LIST
  void updatePatientTreatment(
      int index, PatientTreatmentCreateModel patientTreatment) {
    if (index >= 0 && index < patientTreatmentList.length) {
      patientTreatmentList[index] = patientTreatment;
      notifyListeners();
    }
  }

  // METHOD TO ADD TREATMENT TO THE LIST
  void addPatientTreatment(PatientTreatmentCreateModel patientTreatment) {
    patientTreatmentList.add(patientTreatment);
    notifyListeners();
  }

// METHOD TO REMOVE TREATMENT FROM THE LIST
  void removePatientTreatment(int index) {
    if (index >= 0 && index < patientTreatmentList.length) {
      patientTreatmentList.removeAt(index);
      notifyListeners();
    }
  }

  // METHOD TO SET SELECTED TREATMENT
  setSelectedTreatment(Treatment? treatment) {
    selectedTreatment = treatment;
    notifyListeners();
  }

  // METHOD TO SET SELECTED BRANCH
  setSelectedBranch(Branch? branch) {
    selectedBranch = branch;
    notifyListeners();
  }

  // METHOD TO CLEAR SELECTED BRANCH
  clearSelectedBranch() {
    selectedBranch = null;
    notifyListeners();
  }

  // METHOD TO SET SELECTED PAYMENT OPTION
  void setSelectedPaymentOption(PaymentOption? paymentOption) {
    selectedPaymentOption = paymentOption;
    notifyListeners();
  }

// METHOD TO CLEAR SELECTED PAYMENT OPTION
  void clearSelectedPaymentOption() {
    selectedPaymentOption = null;
    notifyListeners();
  }

// METHOD TO GET PAYMENT OPTION AS STRING
  String? getSelectedPaymentOptionAsString() {
    switch (selectedPaymentOption) {
      case PaymentOption.cash:
        return 'cash';
      case PaymentOption.card:
        return 'card';
      case PaymentOption.upi:
        return 'upi';
      default:
        return null;
    }
  }
}
