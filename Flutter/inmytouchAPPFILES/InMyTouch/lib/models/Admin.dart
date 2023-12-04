class Admin {
  final String id;
  final String name;
  final String email;
  // Add more properties as needed

  Admin({
    required this.id,
    required this.name,
    required this.email,
    // Initialize additional properties here
  });

  // Factory constructor to create an Admin object from a Map
  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      // Initialize additional properties from the map
    );
  }

  // Convert the Admin object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      // Add additional properties to the map
    };
  }
}
