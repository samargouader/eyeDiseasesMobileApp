class User {
  final int? id;
  final String name;
  final String lastName;
  final int age;
  final DateTime? createdAt;

  User({
    this.id,
    required this.name,
    required this.lastName,
    required this.age,
    this.createdAt,
  });

  // Convert User object to Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'age': age,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  // Create User object from Map (from database)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      lastName: map['lastName'],
      age: map['age'],
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }

  // Create a copy of User with updated fields
  User copyWith({
    int? id,
    String? name,
    String? lastName,
    int? age,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, lastName: $lastName, age: $age, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.name == name &&
        other.lastName == lastName &&
        other.age == age &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ lastName.hashCode ^ age.hashCode ^ createdAt.hashCode;
  }
}
