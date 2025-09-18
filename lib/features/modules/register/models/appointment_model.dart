class AppointmentModel {
  String name;
  String executive;
  String payment;
  String phone;
  String address;
  int totalAmount;
  int discountAmount;
  int advanceAmount;
  int balanceAmount;
  String dateAndTime;
  String id;
  List<int> male;
  List<int> female;
  int branch;
  List<int> treatments;

  AppointmentModel({
    required this.name,
    required this.executive,
    required this.payment,
    required this.phone,
    required this.address,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.dateAndTime,
    required this.id,
    required this.male,
    required this.female,
    required this.branch,
    required this.treatments,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      name: json['name'] ?? '',
      executive: json['excecutive'] ?? '',
      payment: json['payment'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      totalAmount: (json['total_amount'] ?? 0.0).toDouble(),
      discountAmount: (json['discount_amount'] ?? 0.0).toDouble(),
      advanceAmount: (json['advance_amount'] ?? 0.0).toDouble(),
      balanceAmount: (json['balance_amount'] ?? 0.0).toDouble(),
      dateAndTime: json['date_nd_time'] ?? '',
      id: json['id']?.toString() ?? '',
      male: List<int>.from(json['male'] ?? []),
      female: List<int>.from(json['female'] ?? []),
      branch: json['branch'] ?? 0,
      treatments: List<int>.from(json['treatments'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'excecutive': executive,
      'payment': payment,
      'phone': phone,
      'address': address,
      'total_amount': totalAmount,
      'discount_amount': discountAmount,
      'advance_amount': advanceAmount,
      'balance_amount': balanceAmount,
      'date_nd_time': dateAndTime,
      'id': id,
      'male': male,
      'female': female,
      'branch': branch,
      'treatments': treatments,
    };
  }
}
