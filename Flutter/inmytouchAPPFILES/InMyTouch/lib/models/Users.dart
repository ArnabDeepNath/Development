class User {
  final String id;
  final String name;
  final String email;
  // Add more properties as needed

  User({
    required this.id,
    required this.name,
    required this.email,
    // Initialize additional properties here
  });

  // Factory constructor to create a User object from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      // Initialize additional properties from the map
    );
  }

  // Convert the User object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      // Add additional properties to the map
    };
  }
}
