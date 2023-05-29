import 'dart:convert';

class FeedingSchedule {
  FeedingSchedule({
    required this.isEnable,
    required this.date,
    required this.amount,
  });

  factory FeedingSchedule.fromJson(String source) => FeedingSchedule.fromMap(json.decode(source) as Map<String, dynamic>);

  factory FeedingSchedule.fromMap(Map<String, dynamic> map) {
    return FeedingSchedule(
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

  FeedingSchedule copyWith({
    bool? isEnable,
    DateTime? date,
    int? amount,
  }) {
    return FeedingSchedule(
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
