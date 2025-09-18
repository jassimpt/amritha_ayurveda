import 'package:amritha_ayurveda/features/modules/register/models/treatment_list_model.dart';

class PatientTreatmentCreateModel {
  int? male;
  int? female;
  Treatment? selectedTreatment;

  PatientTreatmentCreateModel({
    required this.female,
    required this.male,
    required this.selectedTreatment,
  });

  factory PatientTreatmentCreateModel.fromJson(Map<String, dynamic> json) {
    return PatientTreatmentCreateModel(
      female: json["female"],
      male: json["male"],
      selectedTreatment: json["selectedTreatment"] != null
          ? Treatment.fromJson(
              json["selectedTreatment"],
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "male": male,
      "female": female,
      "selectedTreatment": selectedTreatment?.toJson()
    };
  }
}
