part of 'login_bloc.dart';

final class LoginState extends Equatable {
  final TextFormSubmissionStatus status;
  final Username username;
  final Password password;
  final bool isValid;
  final String? error;

  const LoginState({
    this.status = TextFormSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.error,
  });

  LoginState copyWith({
    TextFormSubmissionStatus? status,
    Username? username,
    Password? password,
    bool? isValid,
    String? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, username, password];
}
