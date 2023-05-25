import 'dart:convert';

class Event {
  final int chipId;
  final int consume;
  final DateTime date;
  Event({
    required this.chipId,
    required this.consume,
    required this.date,
  });

  Event copyWith({
    int? chipId,
    int? consume,
    DateTime? date,
  }) {
    return Event(
      chipId: chipId ?? this.chipId,
      consume: consume ?? this.consume,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chipId': chipId,
      'consume': consume,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      chipId: map['chipId'] as int,
      consume: map['consume'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Event(chipId: $chipId, consume: $consume, date: $date)';
}
