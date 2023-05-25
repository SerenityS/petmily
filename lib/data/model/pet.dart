import 'dart:convert';

class Pet {
  String userId;
  String chipId;
  String name;
  bool isMale;
  int age;
  int weight;
  String? imageUrl;

  Pet({
    required this.userId,
    required this.chipId,
    required this.name,
    required this.isMale,
    required this.age,
    required this.weight,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'chipId': chipId,
      'name': name,
      'isMale': isMale,
      'age': age,
      'weight': weight,
      'imageUrl': imageUrl,
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
        userId: map['user_id'] as String,
        chipId: map['chip_id'] as String,
        name: map['name'] as String,
        isMale: map['is_male'] as bool,
        age: map['age'] as int,
        weight: map['weight'] as int,
        imageUrl: map['image_url'] != null ? map['image_url'] as String : null);
  }

  String toJson() => json.encode(toMap());

  factory Pet.fromJson(String source) => Pet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pet(userId: $userId, chipId: $chipId, name: $name, isMale: $isMale, age: $age, weight: $weight, imageUrl: $imageUrl)';
  }
}
