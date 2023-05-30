import 'dart:convert';

class Schedule {
  Schedule({
    required this.isEnable,
    required this.date,
    required this.amount,
  });

  factory Schedule.fromJson(String source) => Schedule.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      isEnable: map['is_enable'] as bool,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      amount: map['amount'] as int,
    );
  }

  int amount;
  DateTime date;
  bool isEnable;

  @override
  String toString() => 'FeedingSchedule(isEnable: $isEnable, date: $date, amount: $amount)';

  Schedule copyWith({
    bool? isEnable,
    DateTime? date,
    int? amount,
  }) {
    return Schedule(
      isEnable: isEnable ?? this.isEnable,
      date: date ?? this.date,
      amount: amount ?? this.amount,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'is_enable': isEnable,
      'date': date.millisecondsSinceEpoch,
      'amount': amount,
    };
  }
}
