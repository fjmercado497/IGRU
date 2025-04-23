class User {
  final String email;
  final String password;
  final String name;
  final String lastName;
  final String id;
  final String phoneNumber;
  final String photoUrl;

  User({
    required this.email,
    required this.password,
    required this.name,
    required this.lastName,
    required this.id,
    required this.phoneNumber,
    this.photoUrl = '',
  });

  // Convertir a Map para almacenar en localStorage
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'lastName': lastName,
      'id': id,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
    };
  }

  // Crear desde Map (para recuperar de localStorage)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      name: json['name'] ?? '',
      lastName: json['lastName'] ?? '',
      id: json['id'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
    );
  }

  // Nombre completo
  String get fullName => '$name $lastName';
}
