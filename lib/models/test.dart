class Test {
  final int? id;
  final String imagePath;
  final String result;
  final double confidence;
  final String name;
  final String lastName;
  final int age;
  final DateTime? createdAt;

  Test({
    this.id,
    required this.imagePath,
    required this.result,
    required this.confidence,
    required this.name,
    required this.lastName,
    required this.age,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'result': result,
      'confidence': confidence,
      'name': name,
      'lastName': lastName,
      'age': age,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      id: map['id'] as int?,
      imagePath: map['imagePath'] as String,
      result: map['result'] as String,
      confidence: map['confidence'] is int
          ? (map['confidence'] as int).toDouble()
          : (map['confidence'] as num).toDouble(),
      name: map['name'] as String,
      lastName: map['lastName'] as String,
      age: map['age'] is String
          ? int.parse(map['age'] as String)
          : map['age'] as int,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'] as String)
          : null,
    );
  }

  Test copyWith({
    int? id,
    String? imagePath,
    String? result,
    double? confidence,
    String? name,
    String? lastName,
    int? age,
    DateTime? createdAt,
  }) {
    return Test(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      result: result ?? this.result,
      confidence: confidence ?? this.confidence,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Test(id: $id, imagePath: $imagePath, result: $result, confidence: $confidence, name: $name, lastName: $lastName, age: $age, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Test &&
        other.id == id &&
        other.imagePath == imagePath &&
        other.result == result &&
        other.confidence == confidence &&
        other.name == name &&
        other.lastName == lastName &&
        other.age == age &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imagePath.hashCode ^
        result.hashCode ^
        confidence.hashCode ^
        name.hashCode ^
        lastName.hashCode ^
        age.hashCode ^
        createdAt.hashCode;
  }
}
