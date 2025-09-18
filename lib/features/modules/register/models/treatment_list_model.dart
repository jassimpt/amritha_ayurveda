import 'package:amritha_ayurveda/features/modules/register/models/branch_list_model.dart';

class TreatmentListModel {
  final bool? status;
  final String? message;
  final List<Treatment>? treatments;

  TreatmentListModel({
    this.status,
    this.message,
    this.treatments,
  });

  factory TreatmentListModel.fromJson(Map<String, dynamic> json) {
    return TreatmentListModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      treatments: json['treatments'] != null
          ? (json['treatments'] as List)
              .map((treatmentJson) => Treatment.fromJson(treatmentJson))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'treatments': treatments?.map((treatment) => treatment.toJson()).toList(),
    };
  }
}

class Treatment {
  final int? id;
  final List<Branch>? branches;
  final String? name;
  final String? duration;
  final String? price;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  Treatment({
    this.id,
    this.branches,
    this.name,
    this.duration,
    this.price,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      id: json['id'] as int?,
      branches: json['branches'] != null
          ? (json['branches'] as List)
              .map((branchJson) => Branch.fromJson(branchJson))
              .toList()
          : null,
      name: json['name'] as String?,
      duration: json['duration'] as String?,
      price: json['price'] as String?,
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'branches': branches?.map((branch) => branch.toJson()).toList(),
      'name': name,
      'duration': duration,
      'price': price,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
