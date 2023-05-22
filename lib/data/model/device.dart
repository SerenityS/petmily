import 'dart:convert';

class Device {
  final String userId;
  final String name;
  final int chipId;

  Device({required this.userId, required this.name, required this.chipId});

  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
      userId: map['user_id'] as String,
      name: map['name'] as String,
      chipId: int.parse(map['chip_id']),
    );
  }

  factory Device.fromJson(String source) => Device.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Device(userId: $userId, name: $name, chipId: $chipId)';
}
