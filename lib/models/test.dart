class Test {
  final int? id;
  final String imagePath;
  final String result;
  final double confidence;
  final int userId;
  final DateTime? createdAt;

  Test({
    this.id,
    required this.imagePath,
    required this.result,
    required this.confidence,
    required this.userId,
    this.createdAt,
  });

  // Convert Test object to Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'result': result,
      'confidence': confidence,
      'userId': userId,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  // Create Test object from Map (from database)
  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      id: map['id'],
      imagePath: map['imagePath'],
      result: map['result'],
      confidence: (map['confidence'] is int) ? (map['confidence'] as int).toDouble() : map['confidence'],
      userId: map['userId'],
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
    );
  }

  // Create a copy of Test with updated fields
  Test copyWith({
    int? id,
    String? imagePath,
    String? result,
    double? confidence,
    int? userId,
    DateTime? createdAt,
  }) {
    return Test(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      result: result ?? this.result,
      confidence: confidence ?? this.confidence,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Test(id: $id, imagePath: $imagePath, result: $result, confidence: $confidence, userId: $userId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Test &&
        other.id == id &&
        other.imagePath == imagePath &&
        other.result == result &&
        other.confidence == confidence &&
        other.userId == userId &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imagePath.hashCode ^
        result.hashCode ^
        confidence.hashCode ^
        userId.hashCode ^
        createdAt.hashCode;
  }
}
