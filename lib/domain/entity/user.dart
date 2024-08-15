import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String sessionId;
  final int accountId;

  const User({
    required this.sessionId,
    required this.accountId,
  });

  static const User empty = User(sessionId: '', accountId: 0);

  @override
  List<Object> get props => [sessionId, accountId];

  Map<String, dynamic> toMap() {
    return {
      'sessionId': sessionId,
      'accountId': accountId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      sessionId: map['sessionId'] as String,
      accountId: map['accountId'] as int,
    );
  }

  User copyWith({
    String? sessionId,
    int? accountId,
  }) {
    return User(
      sessionId: sessionId ?? this.sessionId,
      accountId: accountId ?? this.accountId,
    );
  }
}
