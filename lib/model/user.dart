enum Roles { driver, admin }

class User {
  final String uid;
  final String firstname;
  final String lastname;
  final String email;

  final DateTime createdAt;

  final bool isVerified;
  final String licensePlate;
  final String phone;

  final Roles role;
  final bool isActive;



  bool get isDriverRole => role == Roles.driver;

  bool get isAdminRole => role == Roles.admin;

  String get getFullName => firstname + " " + lastname;

  const User({
    required this.isActive,
    required this.uid,
    required this.firstname,
    required this.lastname,
    required this.email,
   required this.createdAt,
    required this.isVerified,
    required this.phone,
    required this.role,
    required this.licensePlate


  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      uid: data['uid'] ?? '',
      isActive: data['is_active'] ?? false,
      firstname: data['firstname'] ?? '',
      lastname: data['lastname'] ?? '',
      email: data['email'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(data['createdAt'].millisecondsSinceEpoch),
      isVerified: data['is_verified'] ?? false,
      licensePlate: data['license_plate'] ?? '',
      phone: data['phone'] ?? '',

      role: Roles.values[data['role'] ?? 0],

    );
  }
}