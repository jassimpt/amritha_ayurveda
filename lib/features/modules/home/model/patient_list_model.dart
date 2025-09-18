import 'dart:convert';

class PatientListModel {
  final bool? status;
  final String? message;
  final List<Patient>? patient;

  PatientListModel({
    this.status,
    this.message,
    this.patient,
  });

  factory PatientListModel.fromJson(Map<String, dynamic> json) =>
      PatientListModel(
        status: json['status'] as bool?,
        message: json['message'] as String?,
        patient: json['patient'] == null
            ? null
            : List<Patient>.from(
                (json['patient'] as List<dynamic>).map(
                  (x) => Patient.fromJson(x as Map<String, dynamic>),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'patient': patient == null
            ? null
            : List<dynamic>.from(patient!.map((x) => x.toJson())),
      };
}

class Patient {
  final int? id;
  final List<PatientDetail>? patientdetailsSet;
  final Branch? branch;
  final String? user;
  final String? payment;
  final String? name;
  final String? phone;
  final String? address;
  final dynamic price;
  final int? totalAmount;
  final int? discountAmount;
  final int? advanceAmount;
  final int? balanceAmount;
  final String? dateNdTime;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  Patient({
    this.id,
    this.patientdetailsSet,
    this.branch,
    this.user,
    this.payment,
    this.name,
    this.phone,
    this.address,
    this.price,
    this.totalAmount,
    this.discountAmount,
    this.advanceAmount,
    this.balanceAmount,
    this.dateNdTime,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json['id'] as int?,
        patientdetailsSet: json['patientdetails_set'] == null
            ? null
            : List<PatientDetail>.from(
                (json['patientdetails_set'] as List<dynamic>).map(
                  (x) => PatientDetail.fromJson(x as Map<String, dynamic>),
                ),
              ),
        branch: json['branch'] == null
            ? null
            : Branch.fromJson(json['branch'] as Map<String, dynamic>),
        user: json['user'] as String?,
        payment: json['payment'] as String?,
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        address: json['address'] as String?,
        price: json['price'],
        totalAmount: json['total_amount'] as int?,
        discountAmount: json['discount_amount'] as int?,
        advanceAmount: json['advance_amount'] as int?,
        balanceAmount: json['balance_amount'] as int?,
        dateNdTime: json['date_nd_time'] as String?,
        isActive: json['is_active'] as bool?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'patientdetails_set': patientdetailsSet == null
            ? null
            : List<dynamic>.from(patientdetailsSet!.map((x) => x.toJson())),
        'branch': branch?.toJson(),
        'user': user,
        'payment': payment,
        'name': name,
        'phone': phone,
        'address': address,
        'price': price,
        'total_amount': totalAmount,
        'discount_amount': discountAmount,
        'advance_amount': advanceAmount,
        'balance_amount': balanceAmount,
        'date_nd_time': dateNdTime,
        'is_active': isActive,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}

class PatientDetail {
  final int? id;
  final String? male;
  final String? female;
  final int? patient;
  final int? treatment;
  final String? treatmentName;

  PatientDetail({
    this.id,
    this.male,
    this.female,
    this.patient,
    this.treatment,
    this.treatmentName,
  });

  factory PatientDetail.fromJson(Map<String, dynamic> json) => PatientDetail(
        id: json['id'] as int?,
        male: json['male'] as String?,
        female: json['female'] as String?,
        patient: json['patient'] as int?,
        treatment: json['treatment'] as int?,
        treatmentName: json['treatment_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'male': male,
        'female': female,
        'patient': patient,
        'treatment': treatment,
        'treatment_name': treatmentName,
      };
}

class Branch {
  final int? id;
  final String? name;
  final int? patientsCount;
  final String? location;
  final String? phone;
  final String? mail;
  final String? address;
  final String? gst;
  final bool? isActive;

  Branch({
    this.id,
    this.name,
    this.patientsCount,
    this.location,
    this.phone,
    this.mail,
    this.address,
    this.gst,
    this.isActive,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json['id'] as int?,
        name: json['name'] as String?,
        patientsCount: json['patients_count'] as int?,
        location: json['location'] as String?,
        phone: json['phone'] as String?,
        mail: json['mail'] as String?,
        address: json['address'] as String?,
        gst: json['gst'] as String?,
        isActive: json['is_active'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'patients_count': patientsCount,
        'location': location,
        'phone': phone,
        'mail': mail,
        'address': address,
        'gst': gst,
        'is_active': isActive,
      };
}
