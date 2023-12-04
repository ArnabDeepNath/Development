class User {
  final String uid;
  final String crmId;
  final String email;
  final String name;
  final String address;
  final String phone;
  final String role;

  User({
    required this.uid,
    required this.crmId,
    required this.email,
    required this.name,
    required this.address,
    required this.phone,
    required this.role,
  });

  factory User.fromMap(Map<String, dynamic> data, String id) {
    return User(
        uid: data['uid'],
        crmId: data['crmId'],
        email: data['email'],
        name: data['Name'] ?? '',
        address: data['address'] ?? '',
        phone: data['Phone'] ?? '',
        role: data['role'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'crmId': crmId,
      'email': email,
      'name': name,
      'address': address,
      'phone': phone,
      'role': role,
    };
  }
}
