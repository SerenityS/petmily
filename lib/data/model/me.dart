import 'dart:convert';

class Me {
  String id;
  String email;
  String nick;

  Me({
    required this.id,
    required this.email,
    required this.nick,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'nick': nick,
    };
  }

  factory Me.fromMap(Map<String, dynamic> map) {
    return Me(
      id: map['id'] as String,
      email: map['email'] as String,
      nick: map['nick'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Me.fromJson(String source) => Me.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(id: $id, email: $email, nick: $nick)';
}
