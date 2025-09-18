import 'package:amritha_ayurveda/features/modules/home/model/patient_list_model.dart';
import 'package:amritha_ayurveda/features/modules/home/service/home_service.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  bool patientListLoader = false;
  List<Patient> patients = [];
  final HomeService _service = HomeService();
  getPatientsData({
    Map<String, dynamic>? additionalParams,
  }) async {
    try {
      patientListLoader = true;
      PatientListModel patientData = await _service.getPatientsData(
        additionalParams: additionalParams,
      );
      patients = patientData.patient ?? [];
    } catch (e) {
      patients = [];
    } finally {
      patientListLoader = false;
      notifyListeners();
    }
  }
}
