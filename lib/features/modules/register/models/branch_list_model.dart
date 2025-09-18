class BranchListModel {
  final bool? status;
  final String? message;
  final List<Branch>? branches;

  BranchListModel({
    this.status,
    this.message,
    this.branches,
  });

  factory BranchListModel.fromJson(Map<String, dynamic> json) {
    return BranchListModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      branches: json['branches'] != null
          ? (json['branches'] as List)
              .map((branchJson) => Branch.fromJson(branchJson))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'branches': branches?.map((branch) => branch.toJson()).toList(),
    };
  }
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

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
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
  }

  Map<String, dynamic> toJson() {
    return {
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
}
