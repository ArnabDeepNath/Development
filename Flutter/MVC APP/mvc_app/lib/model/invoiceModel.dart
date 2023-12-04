class Invoice {
  final String id;
  final String userId;
  final String name;
  final String phoneNumber;
  final String address;
  final String carName;
  final int exShowroomPrice;
  final int hsrp;
  final int temp;
  final int regn;
  final int scheme;
  final int grandTotal;
  final DateTime createdAt;

  Invoice({
    required this.id,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.carName,
    required this.exShowroomPrice,
    required this.hsrp,
    required this.temp,
    required this.regn,
    required this.scheme,
    required this.grandTotal,
    required this.createdAt,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json['id'],
        userId: json['userId'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        address: json['address'],
        carName: json['carName'],
        exShowroomPrice: json['exShowroomPrice'],
        hsrp: json['hsrp'],
        temp: json['temp'],
        regn: json['regn'],
        scheme: json['scheme'],
        grandTotal: json['grandTotal'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'phoneNumber': phoneNumber,
        'address': address,
        'carName': carName,
        'exShowroomPrice': exShowroomPrice,
        'hsrp': hsrp,
        'temp': temp,
        'regn': regn,
        'scheme': scheme,
        'grandTotal': grandTotal,
        'createdAt': createdAt.toIso8601String(),
      };
}
