import 'dart:convert';

class DeviceData {
  DeviceData({
    required this.chipId,
    required this.bowlAmount,
    required this.feedBoxAmount,
  });

  String chipId;
  int bowlAmount;
  int feedBoxAmount;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chipId': chipId,
      'bowlAmount': bowlAmount,
      'feedBoxAmount': feedBoxAmount,
    };
  }

  factory DeviceData.fromMap(Map<String, dynamic> map) {
    return DeviceData(
      chipId: map['chip_id'] as String,
      bowlAmount: map['bowl_amount'] as int,
      feedBoxAmount: map['feed_box_amount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceData.fromJson(String source) => DeviceData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DeviceData(chipId: $chipId, bowlAmount: $bowlAmount, feedBoxAmount: $feedBoxAmount)';
}
