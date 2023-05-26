import 'dart:convert';

class History {
  final int id;
  final String userId;
  final String chipId;
  final int consume;
  final DateTime date;
  History({
    required this.id,
    required this.userId,
    required this.chipId,
    required this.consume,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'chipId': chipId,
      'consume': consume,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      id: map['id'] as int,
      userId: map['user_id'] as String,
      chipId: map['chip_id'] as String,
      consume: map['consume'] as int,
      date: DateTime.parse(map['date'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory History.fromJson(String source) => History.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'History(id: $id, userId: $userId, chipId: $chipId, consume: $consume, date: $date)';
}
